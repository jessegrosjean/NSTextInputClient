Example macOS text editor attempting to interact correctly with macOS text input systems. The goal is to have a good reference for implementing NSTextInputClient and NSTextCheckingClient. The goal is not to create a fully usable text editor.

Progress:

- `NSTextInputClient` - I think working mostly right, but probably not 100% right. Let me know what's wrong and I'll try to fix it.

- `NSTextCheckingClient` - Making some progress, but still needs work. Generally trying to implement this in Swift. Seem to be some cases where it's requried to provide an objective-c implementation. For example if I don't implement `setAnnotations:range:` in Objective-c then I get crashes.
