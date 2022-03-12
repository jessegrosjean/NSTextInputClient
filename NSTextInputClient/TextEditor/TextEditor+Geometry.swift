import AppKit

extension TextEditor {

    override var isFlipped: Bool {
        return true
    }

    var caretRect: NSRect? {
        if selection.isCollapsed {
            return selectionRects()[0]
        }
        return nil
    }
    
    var caretSizedRect: NSRect? {
        if var r = caretRect {
            r.size.width = 1
            return r
        }
        return nil
    }
    
    func selectionRects(constraintedRange: NSRange? = nil) -> [NSRect] {
        return rangeRects(selection.range, constrainedRange: constraintedRange, affinity: selection.affinity)
    }
    
    func rangeRects(_ range: NSRange, constrainedRange: NSRange? = nil, affinity: NSSelectionAffinity? = nil) -> [NSRect] {
        let affinity = affinity ?? .downstream
        let collapsed = range.length == 0
        var selectionRange = range
        
        if collapsed {
            if affinity == .downstream && NSMaxRange(selectionRange) < backingStore.length {
                selectionRange.length = 1
            }
        } else if let constrainedRange = constrainedRange {
            selectionRange = NSIntersectionRange(selectionRange, constrainedRange)
            if selectionRange.length == 0 {
                return []
            }
        }
        
        var rectCount = 0
        var rects = [NSRect]()
        let selectionGlyphRange = layoutManager.glyphRange(forCharacterRange: selectionRange, actualCharacterRange: nil)
        if let rectArray = layoutManager.rectArray(forGlyphRange: selectionGlyphRange, withinSelectedGlyphRange: selectionGlyphRange, in: textContainer, rectCount: &rectCount) {
            for i in 0..<rectCount {
                rects.append(rectArray[i])
            }
        }
        
        if collapsed && selection.affinity == .downstream {
            rects[0].size.width = 0
        }
        
        return rects
    }
    
}
