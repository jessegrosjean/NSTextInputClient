extension TextEditor {
    
    override func annotatedSubstring(forProposedRange range: NSRange, actualRange: NSRangePointer?) -> NSAttributedString? {
        guard let range = textCheckingAdjusted(range: range) else {
            return nil
        }
        let result = backingStore.attributedSubstring(from: range)
        checkingLog.print("annotatedSubstring(forProposedRange range: \(range), actualRange: \(String(describing: actualRange)) -> \(result)")
        return result
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
    }

}
