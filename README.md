Example macOS text editor attempting to interact correctly with macOS text input systems. The goal is to have a good reference for implementing NSTextInputClient and NSTextCheckingClient. The goal is not to create a fully usable text editor.

Progress:

- `NSTextInputClient` - I think working mostly right, but probably not 100% right. Let me know what's wrong and I'll try to fix it.
- `NSTextCheckingClient` - Not working. Right now I'm just trying to get a sequence of insertText with no other actions to do something. So far only callback that ever gets called is `annotatedSubstring`.
