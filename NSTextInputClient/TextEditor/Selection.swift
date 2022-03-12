import AppKit

struct Selection: Equatable {
    
    var head: Int
    var anchor: Int
    var affinity: NSSelectionAffinity
    var granularity: NSSelectionGranularity
    var markedRange: NSRange?
    var stillSelecting: Bool
    
    init(head: Int, anchor: Int? = nil, affinity: NSSelectionAffinity? = nil, granularity: NSSelectionGranularity? = nil, stillSelecting: Bool? = nil) {
        self.head = head
        self.anchor = anchor ?? head
        self.affinity = affinity ?? .downstream
        self.granularity = granularity ?? .selectByCharacter
        self.stillSelecting = stillSelecting ?? false
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

}
