extension TextEditor {
    
    override func annotatedSubstring(forProposedRange range: NSRange, actualRange: NSRangePointer?) -> NSAttributedString? {
        guard let range = textCheckingAdjusted(range: range) else {
            return nil
        }
        
        let paragraphRange = (backingStore.string as NSString).paragraphRange(for: range)
        let result = backingStore.attributedSubstring(from: paragraphRange)
        actualRange?.pointee = paragraphRange
        checkingLog.print("annotatedSubstring(forProposedRange range: \(range), actualRange: \(String(describing: actualRange)) -> \(result)")
        return result
    }

    override func addAnnotations(_ annotations: [NSAttributedString.Key : String], range: NSRange) {
        guard let range = textCheckingAdjusted(range: range) else {
            return
        }
        backingStore.addAttributes(annotations, range: range)
        needsDisplay = true
    }

    //override func setAnnotations(_ annotations: [NSAttributedString.Key : String], range: NSRange) {
    //    guard let range = textCheckingAdjusted(range: range) else {
    //        return
    //    }
    //    backingStore.setAttributes(annotations, range: range)
    //}
    
    override func removeAnnotation(_ annotationName: NSAttributedString.Key, range: NSRange) {
        guard let range = textCheckingAdjusted(range: range) else {
            return
        }
        backingStore.removeAttribute(annotationName, range: range)
        needsDisplay = true
    }
    
    override func replaceCharacters(in range: NSRange, withAnnotatedString annotatedString: NSAttributedString) {
        guard let range = textCheckingAdjusted(range: range) else {
            return
        }
        
        backingStore.replaceCharacters(in: range, with: annotatedString)
        validateSelection()
        needsDisplay = true
    }

    override func selectAndShow(_ range: NSRange) {
        fatalError()
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
    
    /*
    
    
    @objc override func setAnnotations(_ annotations: [NSAttributedString.Key : String], range: NSRange) {
        guard let range = textCheckingAdjusted(range: range) else {
            return
        }
        backingStore.setAttributes(annotations, range: range)
    }
    
    override func removeAnnotation(_ annotationName: NSAttributedString.Key, range: NSRange) {
        guard let range = textCheckingAdjusted(range: range) else {
            return
        }
        backingStore.removeAttribute(annotationName, range: range)
    }
        
    override func candidateListTouchBarItem() -> NSCandidateListTouchBarItem<AnyObject>? {
        return nil
    }
    
    private func textCheckingAdjusted(range: NSRange) -> NSRange? {
        var range = range
        if range.location == NSNotFound {
            checkingLog.print("notFoundRange, replacing with document range: \(range)")
            range = NSRange(location: 0, length: backingStore.length)
        }
        
        if range.location > backingStore.length {
            checkingLog.print("invalidRange: \(range)")
            return nil
        }
        
        let rangeEnd = range.location + range.length
        if rangeEnd > backingStore.length {
            checkingLog.print("clippedRange: \(range)")
            range.length = backingStore.length - range.location
        }
        
        return range
    }*/
    
}

/*
- (void)setAnnotations:(NSDictionary<NSAttributedStringKey, NSString *> *)annotations range:(NSRange)range {
- (void)addAnnotations:(NSDictionary<NSAttributedStringKey, NSString *> *)annotations range:(NSRange)range {
- (void)removeAnnotation:(NSAttributedStringKey)annotationName range:(NSRange)range {
- (NSRange)validateTextCheckingRange:(NSRange)range {
*/
