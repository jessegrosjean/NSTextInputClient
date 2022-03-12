import AppKit

extension String {
    
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)!
        let to = range.upperBound.samePosition(in: utf16)!
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
        else { return nil }
        return from ..< to
    }
    
    func nsRangeOfComposedCharacterSequences(for nsRange: NSRange) -> NSRange? {
        if let range = range(from: nsRange) {
            let compostedRange = rangeOfComposedCharacterSequences(for: range)
            return self.nsRange(from: compostedRange)
        }
        return nil
    }
    
}

extension NSTextStorage {
    
    func replaceCharacters(in range: NSRange, with str: Any) {
        if let string = str as? NSAttributedString {
            replaceCharacters(in: range, with: string)
        } else {
            replaceCharacters(in: range, with: str as! String)
        }
    }
    
}
