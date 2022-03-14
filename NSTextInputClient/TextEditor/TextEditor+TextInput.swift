import AppKit

extension TextEditor {
    
    override func insertText(_ string: Any, replacementRange: NSRange) {
        inputLog.print("insertText(\(string), replacementRange: \(replacementRange)")
        
        let string = attributedString(anyString: string)
        let replacementRange = replaceCharacters(in: replacementRange, with: string)
        let insertedRange = NSRange(location: replacementRange.location, length: string.length)
        
        checkingController?.insertedText(in: insertedRange)
        checkingController?.considerTextChecking(for: insertedRange)
    }
    
    override func setMarkedText(_ string: Any, selectedRange: NSRange, replacementRange: NSRange) {
        inputLog.print("setMarkedText(\(string), selectedRange: \(selectedRange), replacementRange: \(replacementRange)")

        let string = attributedString(anyString: string)
        let replacementRange = selection.replacementRange(for: replacementRange)
        let stringLength = string.length

        backingStore.beginEditing()
        if stringLength == 0 {
            backingStore.deleteCharacters(in: replacementRange)
            unmarkText()
        } else {
            selection.markedRange = NSMakeRange(replacementRange.location, stringLength);
            backingStore.replaceCharacters(in: replacementRange, with: string)
        }
        backingStore.endEditing()
        
        let head = replacementRange.location + selectedRange.location
        selection.head = replacementRange.location + selectedRange.location
        selection.anchor = head + selectedRange.length
        
        inputContext?.invalidateCharacterCoordinates()
        
        needsDisplay = true
    }
    
    func attributedString(anyString: Any) -> NSAttributedString {
        if let s = anyString as? String {
            return NSAttributedString(string: s)
        } else {
            return NSAttributedString(string: (anyString as! NSAttributedString).string)
        }
    }
    
    override func unmarkText() {
        inputLog.print("unmarkText()")
        selection.markedRange = nil
        needsDisplay = true
    }
    
    override func selectedRange() -> NSRange {
        inputLog.print("selectedRange() -> \(selection.range)")
        return selection.range
    }
    
    override func markedRange() -> NSRange {
        let result = selection.markedRange ?? NSMakeRange(NSNotFound, 0)
        inputLog.print("markedRange() -> \(result)")
        return result
    }
    
    override func hasMarkedText() -> Bool {
        let result = selection.markedRange != nil
        inputLog.print("hasMarkedText() -> \(result)")
        return result
    }
    
    override func attributedSubstring(forProposedRange range: NSRange, actualRange: NSRangePointer?) -> NSAttributedString? {
        var substring: NSAttributedString? = nil
        if let range = range.intersection(NSMakeRange(0, backingStore.length)) {
            substring = backingStore.attributedSubstring(from: range)
        }
        
        inputLog.print("attributedSubstring(forProposedRange: \(range) actualRange: \(actualRange?.pointee ?? NSMakeRange(NSNotFound, 0)) () -> \(substring?.string ?? "nil")")
        
        return substring
    }
    
    override func validAttributesForMarkedText() -> [NSAttributedString.Key] {
        // this is what NSTextView returns... not sure its right for this example though
        [.underlineStyle, .underlineColor, .backgroundColor, .foregroundColor, .markedClauseSegment, .languageIdentifier, .replacementIndex, .glyphInfo, .textAlternatives, .attachment]
    }
    
    override public func firstRect(forCharacterRange range: NSRange, actualRange: NSRangePointer?) -> NSRect {
        let glyphRange = layoutManager.glyphRange(forCharacterRange: range, actualCharacterRange: actualRange)
        var glyphRect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
        glyphRect = convert(glyphRect, to: nil)
        glyphRect = window!.convertToScreen(glyphRect)

        inputLog.print("firstRect(forCharacterRange: \(range), actualRange: \(actualRange?.pointee ?? NSMakeRange(NSNotFound, 0)) -> \(glyphRect)")

        return glyphRect
    }

    override func characterIndex(for point: NSPoint) -> UInt {
        let windowPoint = window!.convertFromScreen(NSRect(origin: point, size: NSSize.zero)).origin
        let localPoint = convert(windowPoint, from: nil)
        let glyphIndex = layoutManager.glyphIndex(for: localPoint, in: textContainer)
        let index = layoutManager.characterIndexForGlyph(at: glyphIndex)
        inputLog.print("characterIndex(for: \(point)) -> \(index)")
        return UInt(index)
    }
    
}
