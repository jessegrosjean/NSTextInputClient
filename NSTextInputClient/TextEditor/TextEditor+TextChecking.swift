extension TextEditor {
    
    override func annotatedSubstring(forProposedRange range: NSRange, actualRange: NSRangePointer?) -> NSAttributedString? {
        guard let range = textCheckingAdjusted(range: range) else {
            return nil
        }
        
        let paragraphRange = (backingStore.string as NSString).paragraphRange(for: range)
        let result = backingStore.attributedSubstring(from: paragraphRange)
        actualRange?.pointee = paragraphRange
        checkingClientLog.print("annotatedSubstring(forProposedRange range: \(range), actualRange: \(String(describing: actualRange)) -> \(result)")
        return result
    }

    override func addAnnotations(_ annotations: [NSAttributedString.Key : String], range: NSRange) {
        guard let range = textCheckingAdjusted(range: range) else {
            return
        }
        backingStore.addAttributes(annotations, range: range)
        checkingClientLog.print("addAnnotations(\(annotations) range: \(range)")
        needsDisplay = true
    }

    // Crash if override this method, using implementation in TextEditorBase instead
    // override func setAnnotations(_ annotations: [NSAttributedString.Key : String], range: NSRange) {
    //    guard let range = textCheckingAdjusted(range: range) else {
    //        return
    //    }
    //    backingStore.setAttributes(annotations, range: range)
    // }
    
    override func removeAnnotation(_ annotationName: NSAttributedString.Key, range: NSRange) {
        guard let range = textCheckingAdjusted(range: range) else {
            return
        }
        backingStore.removeAttribute(annotationName, range: range)
        checkingClientLog.print("removeAnnotation(\(annotationName) range: \(range)")
        needsDisplay = true
    }
    
    override func replaceCharacters(in range: NSRange, withAnnotatedString annotatedString: NSAttributedString) {
        guard let range = textCheckingAdjusted(range: range) else {
            return
        }
        
        backingStore.replaceCharacters(in: range, with: annotatedString)
        checkingClientLog.print("replaceCharacters(in: \(range), withAnnotatedString: \(annotatedString)")
        selection.offset(by: annotatedString.length - range.length)
        needsDisplay = true
    }

    override func selectAndShow(_ range: NSRange) {
        checkingClientLog.print("selectAndShow(\(range)")
        guard let range = textCheckingAdjusted(range: range) else {
            return
        }
        selection = .init(head: NSMaxRange(range), anchor: range.location)
    }
    
    override func view(for range: NSRange, firstRect: NSRectPointer?, actualRange: NSRangePointer?) -> NSView? {
        guard let range = textCheckingAdjusted(range: range) else {
            return nil
        }

        actualRange?.pointee = range
        firstRect?.pointee = rangeRects(range, constrainedRange: nil, affinity: nil).first!

        return self
    }
    
    override func candidateListTouchBarItem() -> NSCandidateListTouchBarItem<AnyObject>? {
        return nil
    }
        
    func textCheckingAdjusted(range: NSRange) -> NSRange? {
        let range = validateTextChecking(range)
        if range.location == NSNotFound {
            return nil
        } else {
            return range
        }
    }
        
}
