#import "TextEditorBase.h"

@implementation TextEditorBase

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        _backingStore = [[NSTextStorage alloc] init];
    }
    return self;
}

/* The receiver inserts string replacing the content specified by replacementRange. string can be either an NSString or NSAttributedString instance.
 */
- (void)insertText:(id)string replacementRange:(NSRange)replacementRange {
    [self doesNotRecognizeSelector:_cmd];
}

/* The receiver invokes the action specified by selector.
 */
- (void)doCommandBySelector:(SEL)selector {
    [super doCommandBySelector:selector];
}

/* The receiver inserts string replacing the content specified by replacementRange. string can be either an NSString or NSAttributedString instance. selectedRange specifies the selection inside the string being inserted; hence, the location is relative to the beginning of string. When string is an NSString, the receiver is expected to render the marked text with distinguishing appearance (i.e. NSTextView renders with -markedTextAttributes).
 */
- (void)setMarkedText:(id)string selectedRange:(NSRange)selectedRange replacementRange:(NSRange)replacementRange {
    [self doesNotRecognizeSelector:_cmd];
}

/* The receiver unmarks the marked text. If no marked text, the invocation of this method has no effect.
 */
- (void)unmarkText {
    [self doesNotRecognizeSelector:_cmd];
}

/* Returns the selection range. The valid location is from 0 to the document length.
 */
- (NSRange)selectedRange {
    [self doesNotRecognizeSelector:_cmd];
    return NSMakeRange(0, 0);
}

/* Returns the marked range. Returns {NSNotFound, 0} if no marked range.
 */
- (NSRange)markedRange {
    [self doesNotRecognizeSelector:_cmd];
    return NSMakeRange(0, 0);
}

/* Returns whether or not the receiver has marked text.
 */
- (BOOL)hasMarkedText {
    [self doesNotRecognizeSelector:_cmd];
    return NO;
}

/* Returns attributed string specified by range. It may return nil. If non-nil return value and actualRange is non-NULL, it contains the actual range for the return value. The range can be adjusted from various reasons (i.e. adjust to grapheme cluster boundary, performance optimization, etc).
 */
- (nullable NSAttributedString *)attributedSubstringForProposedRange:(NSRange)range actualRange:(nullable NSRangePointer)actualRange {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

/* Returns an array of attribute names recognized by the receiver.
 */
- (NSArray<NSAttributedStringKey> *)validAttributesForMarkedText {
    return [NSArray array];
}

/* Returns the first logical rectangular area for range. The return value is in the screen coordinate. The size value can be negative if the text flows to the left. If non-NULL, actuallRange contains the character range corresponding to the returned area.
 */
- (NSRect)firstRectForCharacterRange:(NSRange)range actualRange:(nullable NSRangePointer)actualRange {
    [self doesNotRecognizeSelector:_cmd];
    return NSMakeRect(0, 0, 0, 0);
}

/* Returns the index for character that is nearest to point. point is in the screen coordinate system.
 */
- (NSUInteger)characterIndexForPoint:(NSPoint)point {
    [self doesNotRecognizeSelector:_cmd];
    return 0;
}

/* These methods suppose that ranges of text in the document may have attached to them certain annotations relevant for text checking, represented by dictionaries with various keys, such as NSSpellingStateAttributeName for ranges of text marked as misspelled. They allow an NSTextCheckingController instance to set and retrieve these annotations, and to perform other actions required for text checking.  The keys and values in these annotation dictionaries will always be strings.
 */

/* In all of these methods, the standard range adjustment policy is as follows:  if the specified range lies only partially within the bounds of the document, the receiver is responsible for adjusting the range so as to limit it to the bounds of the document. If the specified range is {NSNotFound, 0}, then the receiver should replace it with the entire range of the document. Otherwise, if none of the range lies within the bounds of the document, then these methods should have no effect, and return nil where appropriate. The beginning and end of the document are not considered as lying outside of the bounds of the document, and zero-length ranges are acceptable (although in some cases they may have no effect).
 */

/* Returns annotated string specified by range. The range should be adjusted according to the standard range adjustment policy, and in addition for this method alone it should be adjusted to begin and end on paragraph boundaries (with possible exceptions for paragraphs exceeding some maximum length). If the range lies within the bounds of the document but is of zero length, it should be adjusted to include the enclosing paragraph. This method should return nil if none of the range lies within the bounds of the document, but if only a zero-length portion of the adjusted range lies within the bounds of the document, as may happen with an empty document or at the end of the document, then an empty attributed string should be returned rather than nil. If the return value is non-nil and actualRange is non-NULL, then actualRange returns the actual adjusted range used.
 */
- (nullable NSAttributedString *)annotatedSubstringForProposedRange:(NSRange)range actualRange:(nullable NSRangePointer)actualRange {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

/* The receiver replaces any existing annotations on the specified range with the provided annotations. The range should be adjusted according to the standard range adjustment policy. Has no effect if the adjusted range has zero length.
 */
- (void)setAnnotations:(NSDictionary<NSAttributedStringKey, NSString *> *)annotations range:(NSRange)range {
    NSRange validRange = [self validateTextCheckingRange:range];
    
    if (validRange.location == NSNotFound) {
        return;
    }
    NSLog(@"setAnnotations(%@)", annotations);
    [self.backingStore setAttributes:annotations range:validRange];
}

/* The receiver adds the specified annotation to the specified range. The range should be adjusted according to the standard range adjustment policy. Has no effect if the adjusted range has zero length.
 */
- (void)addAnnotations:(NSDictionary<NSAttributedStringKey, NSString *> *)annotations range:(NSRange)range {
    [self doesNotRecognizeSelector:_cmd];
}

/* The receiver removes the specified annotation from the specified range. The range should be adjusted according to the standard range adjustment policy. Has no effect if the adjusted range has zero length.
 */
- (void)removeAnnotation:(NSAttributedStringKey)annotationName range:(NSRange)range {
    [self doesNotRecognizeSelector:_cmd];
}

/* The receiver replaces the text in the specified range with the corrected text from annotatedString, or inserts it if the range has zero length, and replaces existing annotations (if any) with those in annotatedString. The range should be adjusted according to the standard range adjustment policy.
 */
- (void)replaceCharactersInRange:(NSRange)range withAnnotatedString:(NSAttributedString *)annotatedString {
    [self doesNotRecognizeSelector:_cmd];
}

/* The receiver selects the text in the specified range and where appropriate scrolls so that it is at least partially visible. A zero-length selection corresponds to an insertion point. The range should be adjusted according to the standard range adjustment policy.
 */
- (void)selectAndShowRange:(NSRange)range {
    [self doesNotRecognizeSelector:_cmd];
}

/* Returns the view displaying the first logical area for range, and the corresponding rect in view coordinates. The range should be adjusted according to the standard range adjustment policy. May return nil if the range is not being displayed, or if none of the range lies within the bounds of the document. A zero-length selection corresponds to an insertion point, and this should return an appropriate view and rect if the adjusted range is of zero length, provided it lies within the bounds of the document (including at the end of the document) and is being displayed. If the return value is non-nil and actualRange is non-NULL, then actualRange returns the range of text displayed in the returned rect.
 */
- (nullable NSView *)viewForRange:(NSRange)range firstRect:(nullable NSRectPointer)firstRect actualRange:(nullable NSRangePointer)actualRange {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

/* Returns the appropriate candidate list touch bar item for displaying touch bar candidates, if any.
 */
- (nullable NSCandidateListTouchBarItem *)candidateListTouchBarItem {
    return nil;
}

- (NSRange)validateTextCheckingRange:(NSRange)range {
    NSRange documentRange = NSMakeRange(0, self.backingStore.length);
    
    if (range.location == NSNotFound) {
        range = documentRange;
    }
    
    if (range.location > documentRange.length) {
        return NSMakeRange(NSNotFound, 0);
    }
    
    NSInteger maxRange = NSMaxRange(range);
    if (maxRange > documentRange.length) {
        range.length = documentRange.length - range.location;
    }
    
    return range;
}

@end
