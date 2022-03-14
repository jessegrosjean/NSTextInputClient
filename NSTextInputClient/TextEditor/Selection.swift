import AppKit

struct Selection: Equatable {
    
    var head: Int
    var anchor: Int
    var affinity: NSSelectionAffinity
    var markedRange: NSRange?
    
    init(head: Int, anchor: Int? = nil, affinity: NSSelectionAffinity? = nil) {
        self.head = head
        self.anchor = anchor ?? head
        self.affinity = affinity ?? .downstream
    }
    
    var isCollapsed: Bool {
        return head == anchor
    }
    
    var minIndex: Int {
        return min(head, anchor)
    }
    
    var maxIndex: Int {
        return max(head, anchor)
    }
    
    var range: NSRange {
        if head < anchor {
            return NSMakeRange(head, anchor - head)
        } else {
            return NSMakeRange(anchor, head - anchor)
        }
    }
    
    func replacementRange(for proposed: NSRange) -> NSRange {
        if proposed.location == NSNotFound {
            return markedRange ?? range
        }
        return proposed
    }
    
    mutating func offset(by delta: Int) {
        head += delta
        anchor += delta
    }

}
