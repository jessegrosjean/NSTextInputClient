import AppKit

extension TextEditor {
    
    override func acceptsFirstMouse(for _: NSEvent?) -> Bool {
        return true
    }
    
    override var canBecomeKeyView: Bool {
        return true
    }
    
    override var needsPanelToBecomeKey: Bool {
        return true
    }
    
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        return true
    }
    
    override func keyDown(with event: NSEvent) {
        NSCursor.setHiddenUntilMouseMoves(true)
        if !(inputContext?.handleEvent(event) ?? false) {
            super.keyDown(with: event)
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        if inputContext?.handleEvent(event) ?? false {
            return
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        inputContext?.handleEvent(event)
    }
    
    override func menu(for event: NSEvent) -> NSMenu? {
        var range = NSRange()
        let menu = checkingController?.menu(at: 1, clickedOnSelection: false, effectiveRange: &range)
        return menu
    }
    
}
