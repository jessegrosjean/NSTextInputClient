import AppKit

extension TextEditor {
        
    override func draw(_ dirtyRect: NSRect) {
        NSColor.white.set()
        NSBezierPath(rect: dirtyRect).fill()
        
        textContainer.size = bounds.size
        layoutManager.invalidateLayout(forCharacterRange: NSMakeRange(0, backingStore.length), actualCharacterRange: nil)
        layoutManager.ensureLayout(forCharacterRange: NSMakeRange(0, backingStore.length))
        
        let glyphRange = layoutManager.glyphRange(forBoundingRect: bounds, in: textContainer)
        let characterRange = layoutManager.characterRange(forGlyphRange: glyphRange, actualGlyphRange: nil)
        let origin = NSMakePoint(0, 0)
        
        layoutManager.drawBackground(forGlyphRange: glyphRange, at: origin)
        drawMarked(for: characterRange)
        drawSelection(for: characterRange)
        layoutManager.drawGlyphs(forGlyphRange: glyphRange, at: origin)
        
        drawCaret(forGlyphRange: glyphRange)
    }

    func drawMarked(for visibleCharacterRange: NSRange) {
        if let marked = selection.markedRange {
            NSColor.yellow.set()
            for each in rangeRects(marked, constrainedRange: visibleCharacterRange) {
                NSBezierPath(rect: each).fill()
            }
        }
    }

    func drawSelection(for visibleCharacterRange: NSRange) {
        if !selection.isCollapsed {
            NSColor.selectedTextBackgroundColor.set()
            for each in selectionRects(constraintedRange: visibleCharacterRange) {
                NSBezierPath(rect: each).fill()
            }
        }
    }
    
    func drawCaret(forGlyphRange range: NSRange) {
        if let caretRect = caretSizedRect {
            NSColor.systemBlue.set()
            NSBezierPath(rect: caretRect).fill()
        }
    }

}

