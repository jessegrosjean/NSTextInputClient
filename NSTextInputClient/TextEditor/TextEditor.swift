import AppKit
import OSLog

let coreLog = OSLog(subsystem: "com.hogbaysoftware.TextEditor", category: "core").enabled(true)
let inputLog = OSLog(subsystem: "com.hogbaysoftware.TextEditor", category: "input").enabled(true)
let checkingClientLog = OSLog(subsystem: "com.hogbaysoftware.TextEditor", category: "checkingClient").enabled(true)

class TextEditor: TextEditorBase {
    
    var selection: Selection {
        didSet {
            if oldValue != selection {
                coreLog.print("selection = \(selection)")
                checkingController?.didChangeSelectedRange()
                needsDisplay = true
            }
        }
    }

    let textContainer: NSTextContainer
    let layoutManager: NSLayoutManager
    var checkingController: TextCheckingController?
    
    override init(frame frameRect: NSRect) {
        fatalError()
    }
    
    required init?(coder: NSCoder) {
        selection = Selection(head: 0)
        layoutManager = NSLayoutManager()
        textContainer = NSTextContainer(containerSize: NSMakeSize(100, 100))
        layoutManager.addTextContainer(textContainer)
        
        super.init(coder: coder)

        self.backingStore.addLayoutManager(layoutManager)

        autocorrectionType = .yes
        spellCheckingType = .yes
        grammarCheckingType = .yes
        smartQuotesType = .yes
        smartDashesType = .yes
        smartInsertDeleteType = .yes
        textReplacementType = .yes
        dataDetectionType = .yes
        linkDetectionType = .yes
        textCompletionType = .yes

        checkingController = TextCheckingController(client: self)
        checkingController?.insertedText(in: NSMakeRange(0, 0))
    }
    
    public func replaceCharacters(in range: NSRange, with string: Any) -> NSRange {
        coreLog.print("replaceCharacters(in range: \(range), with string: \(string)")
        
        let string = attributedString(anyString: string)
        let replacementRange = selection.replacementRange(for: range)
        let insertedRange = NSMakeRange(replacementRange.location, string.length)
        
        backingStore.beginEditing()
        backingStore.replaceCharacters(in: replacementRange, with: string)
        backingStore.endEditing()
        checkingController?.didChangeText(in: insertedRange)

        selection = Selection(head: NSMaxRange(insertedRange))
        unmarkText()
        inputContext?.invalidateCharacterCoordinates()
        needsDisplay = true
        
        return replacementRange
    }

    public func deleteCharacters(in range: NSRange) {
        coreLog.print("deleteCharacters(in range: \(range)")

        if var markedRange = selection.markedRange {
            if NSLocationInRange(NSMaxRange(range), markedRange) {
                markedRange.length -= NSMaxRange(range) - markedRange.location
                markedRange.location = range.location
            } else if markedRange.location > range.location {
                markedRange.location -= range.length
            }
            
            if markedRange.length == 0 {
                unmarkText()
            } else {
                selection.markedRange = markedRange
            }
        }
        
        backingStore.deleteCharacters(in: range)
        checkingController?.didChangeText(in: NSMakeRange(range.location, 0))
        selection = Selection(head: range.location)
        inputContext?.invalidateCharacterCoordinates()
        invalidateIntrinsicContentSize()
        needsDisplay = true
    }
        
}
