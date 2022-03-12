import AppKit

extension TextEditor {
    
    override func moveRight(_ sender: Any?) {
        if selection.isCollapsed {
            if selection.head < backingStore.length {
                selection = Selection(head: selection.head + 1)
            }
        } else {
            selection = Selection(head: selection.maxIndex)
        }
    }
        
    override func moveLeft(_ sender: Any?) {
        if selection.isCollapsed {
            if selection.head > 0 {
                selection = Selection(head: selection.head - 1)
            }
        } else {
            selection = Selection(head: selection.minIndex)
        }
    }
        
    override func moveRightAndModifySelection(_ sender: Any?) {
        if selection.head < backingStore.length {
            selection = Selection(head: selection.head + 1, anchor: selection.anchor)
        }
    }
    
    override func moveLeftAndModifySelection(_ sender: Any?) {
        if selection.head > 0 {
            selection = Selection(head: selection.head - 1, anchor: selection.anchor)
        }
    }
    
    override func insertNewline(_ sender: Any?) {
        insertText("\n")
    }
     
    override func insertText(_ insertString: Any) {
        insertText(insertString, replacementRange: NSMakeRange(NSNotFound, 0))
    }

    override func deleteBackward(_ sender: Any?) {
        deleteBackward(decomposing: false)
    }
    
    override func deleteBackwardByDecomposingPreviousCharacter(_ sender: Any?) {
        deleteBackward(decomposing: true)
    }
    
    func deleteBackward(decomposing: Bool) {
        var deleteRange = selectedRange()
        if deleteRange.length == 0 {
            if deleteRange.location == 0 {
                return
            } else {
                deleteRange.location -= 1
                deleteRange.length = 1
            }
        }
        
        if decomposing {
            deleteCharacters(in: deleteRange)
        } else {
            if let composedRange = backingStore.string.nsRangeOfComposedCharacterSequences(for: deleteRange) {
                deleteCharacters(in: composedRange)
            }
        }
    }
    
}

