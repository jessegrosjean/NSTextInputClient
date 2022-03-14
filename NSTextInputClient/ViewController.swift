import Cocoa

class ViewController: NSViewController {

    @IBOutlet var textEditor: TextEditor!
    @IBOutlet var debugTextView: NSTextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textEditor.backingStore.delegate = self
    }

}

extension ViewController: NSTextStorageDelegate {
    
    func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
        debugTextView.string = "\(textStorage)"
    }
    
}
