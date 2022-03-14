import AppKit

extension TextEditor {
        
    @IBAction func toggleAutocorrectionType(_ sender: Any?) {
        autocorrectionType = textInputTraitFromSender(sender)
    }
    
    @IBAction func toggleSpellCheckingType(_ sender: Any?) {
        spellCheckingType = textInputTraitFromSender(sender)
    }
    
    @IBAction func toggleGrammarCheckingType(_ sender: Any?) {
        grammarCheckingType = textInputTraitFromSender(sender)
    }
    
    @IBAction func toggleSmartQuotesType(_ sender: Any?) {
        smartQuotesType = textInputTraitFromSender(sender)
    }
    
    @IBAction func toggleSmartDashesType(_ sender: Any?) {
        smartDashesType = textInputTraitFromSender(sender)
    }
    
    @IBAction func toggleSmartInsertDeleteType(_ sender: Any?) {
        smartInsertDeleteType = textInputTraitFromSender(sender)
    }
    
    @IBAction func toggleTextReplacementType(_ sender: Any?) {
        textReplacementType = textInputTraitFromSender(sender)
    }
    
    @IBAction func toggleDataDetectionType(_ sender: Any?) {
        dataDetectionType = textInputTraitFromSender(sender)
    }
    
    @IBAction func toggleLinkDetectionType(_ sender: Any?) {
        linkDetectionType = textInputTraitFromSender(sender)
    }
    
    @IBAction func toggleTextCompletionType(_ sender: Any?) {
        textCompletionType = textInputTraitFromSender(sender)
    }
    
    @IBAction func considerTextCheckingEntireDocument(_ sender: Any?) {
        checkingController?.considerTextChecking(for: NSMakeRange(0, backingStore.length))
    }

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

    func textInputTraitFromSender(_ sender: Any?) -> NSTextInputTraitType {
        (sender as? NSButton).map { button in
            if button.state == .on {
                return .yes
            } else if button.state == .off {
                return .no
            } else {
                return .default
            }
        } ?? .no
    }

}

