import OSLog

let checkingControllerLog = OSLog(subsystem: "com.hogbaysoftware.TextCheckingController", category: "checkingController").enabled(true)

class TextCheckingController: NSTextCheckingController {
    
    // To be called after text is changed.
    override func didChangeText(in range: NSRange) {
        super.didChangeText(in: range)
    }
    
    // To be called when user input has inserted text.
    override func insertedText(in range: NSRange) {
        super.insertedText(in: range)
    }
    
    // To be called when the selection changes.
    override func didChangeSelectedRange() {
        super.didChangeSelectedRange()
    }
    
    // To be called when the client wants the controller to ensure that a particular range of text should be scheduled to undergo any needed automatic checking.
    override func considerTextChecking(for range: NSRange) {
        super.considerTextChecking(for: range)
    }
    
    // Manually causes checking to be started immediately for a specified range.
    override func checkText(in range: NSRange, types checkingTypes: NSTextCheckingTypes, options: [NSSpellChecker.OptionKey : Any] = [:]) {
        super.checkText(in: range, types: checkingTypes, options: options)
    }
    
    // Methods to be used to implement various menu actions.
    override func checkTextInSelection(_ sender: Any?) {
        fatalError()
    }
    
    override func checkTextInDocument(_ sender: Any?) {
        fatalError()
    }
    
    override func orderFrontSubstitutionsPanel(_ sender: Any?) {
        fatalError()
    }
    
    override func checkSpelling(_ sender: Any?) {
        fatalError()
    }
    
    override func showGuessPanel(_ sender: Any?) {
        fatalError()
    }
    
    override func changeSpelling(_ sender: Any?) {
        fatalError()
    }
    
    override func ignoreSpelling(_ sender: Any?) {
        fatalError()
    }
    
    override func validAnnotations() -> [NSAttributedString.Key] {
        let annotations = super.validAnnotations()
        return annotations
    }
    
}
