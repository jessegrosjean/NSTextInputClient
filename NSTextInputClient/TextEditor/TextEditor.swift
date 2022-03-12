import AppKit
import OSLog

let coreLog = OSLog(subsystem: "com.hogbaysoftware.TextEditor", category: "core").enabled(false)
let inputLog = OSLog(subsystem: "com.hogbaysoftware.TextEditor", category: "input").enabled(false)
let checkingLog = OSLog(subsystem: "com.hogbaysoftware.TextEditor", category: "checking").enabled(false)

// The selection must be entirely within the marked text.
class TextEditor: TextEditorBase {
    
    var selection: Selection {
        didSet {
            if oldValue != selection {
                coreLog.print("selection = \(selection)")
                needsDisplay = true
            }
        }
    }

    let textContainer: NSTextContainer
    let layoutManager: NSLayoutManager
    let backingStore: NSTextStorage
    var checkingController: TextCheckingController?
    
    override init(frame frameRect: NSRect) {
        fatalError()
    }
    
    required init?(coder: NSCoder) {
        selection = Selection(head: 0)
        backingStore = NSTextStorage(string: "", attributes: nil)
        layoutManager = NSLayoutManager()
        backingStore.addLayoutManager(layoutManager)
        textContainer = NSTextContainer(containerSize: NSMakeSize(100, 100))
        layoutManager.addTextContainer(textContainer)
        
        super.init(coder: coder)

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
    }
    
    public func replaceCharacters(in range: NSRange, with string: Any) {
        coreLog.print("replaceCharacters(in range: \(range), with string: \(string)")
        
        let string = attributedString(anyString: string)
        let replacementRange = selection.replacementRange(for: range)
        let insertedRange = NSMakeRange(replacementRange.location, string.length)
        
        backingStore.beginEditing()
        backingStore.replaceCharacters(in: replacementRange, with: string)
        backingStore.endEditing()

        selection = Selection(head: NSMaxRange(insertedRange))
        unmarkText()
        inputContext?.invalidateCharacterCoordinates()
        needsDisplay = true
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
        selection = Selection(head: range.location)
        inputContext?.invalidateCharacterCoordinates()
        invalidateIntrinsicContentSize()
        needsDisplay = true
    }
}
