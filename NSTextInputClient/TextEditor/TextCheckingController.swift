import OSLog

let checkingControllerLog = OSLog(subsystem: "com.hogbaysoftware.TextCheckingController", category: "checking").enabled(true)

class TextCheckingController: NSTextCheckingController {
    
    override func validAnnotations() -> [NSAttributedString.Key] {
        let annotations = super.validAnnotations()
        return annotations
    }
    
}
