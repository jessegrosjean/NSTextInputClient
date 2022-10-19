#import "TextEditorBase+TextCheckingClient.h"

@implementation TextEditorBase (TextCheckingClient)

#pragma mark - NSTextInputClient

- (void)insertText:(nonnull id)string replacementRange:(NSRange)replacementRange {
    [self doesNotRecognizeSelector:_cmd];
}

//- (void)doCommandBySelector:(SEL)selector;

- (void)setMarkedText:(nonnull id)string selectedRange:(NSRange)selectedRange replacementRange:(NSRange)replacementRange {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)unmarkText {
    [self doesNotRecognizeSelector:_cmd];
}

- (NSRange)selectedRange {
    [self doesNotRecognizeSelector:_cmd];
    return NSMakeRange(0, 0);
}

- (NSRange)markedRange {
    [self doesNotRecognizeSelector:_cmd];
    return NSMakeRange(0, 0);
}

- (BOOL)hasMarkedText {
    [self doesNotRecognizeSelector:_cmd];
    return NO;
}

- (nullable NSAttributedString *)attributedSubstringForProposedRange:(NSRange)range actualRange:(nullable NSRangePointer)actualRange {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (nonnull NSArray<NSAttributedStringKey> *)validAttributesForMarkedText {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSRect)firstRectForCharacterRange:(NSRange)range actualRange:(nullable NSRangePointer)actualRange {
    [self doesNotRecognizeSelector:_cmd];
    return NSMakeRect(0, 0, 0, 0);
}

- (NSUInteger)characterIndexForPoint:(NSPoint)point {
    [self doesNotRecognizeSelector:_cmd];
    return NSNotFound;
}

/*
- (NSAttributedString *)attributedString;
- (CGFloat)fractionOfDistanceThroughGlyphForPoint:(NSPoint)point;
- (CGFloat)baselineDeltaForCharacterAtIndex:(NSUInteger)anIndex;
- (NSInteger)windowLevel;
- (BOOL)drawsVerticallyForCharacterAtIndex:(NSUInteger)charIndex API_AVAILABLE(macos(10.6));
*/

#pragma mark - NSTextCheckingClient

- (nullable NSAttributedString *)annotatedSubstringForProposedRange:(NSRange)range actualRange:(nullable NSRangePointer)actualRange {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (void)setAnnotations:(nonnull NSDictionary<NSAttributedStringKey,NSString *> *)annotations range:(NSRange)range {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)addAnnotations:(nonnull NSDictionary<NSAttributedStringKey,NSString *> *)annotations range:(NSRange)range {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)removeAnnotation:(nonnull NSAttributedStringKey)annotationName range:(NSRange)range {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)replaceCharactersInRange:(NSRange)range withAnnotatedString:(nonnull NSAttributedString *)annotatedString {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)selectAndShowRange:(NSRange)range {
    [self doesNotRecognizeSelector:_cmd];
}

- (nullable NSView *)viewForRange:(NSRange)range firstRect:(nullable NSRectPointer)firstRect actualRange:(nullable NSRangePointer)actualRange {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (nullable NSCandidateListTouchBarItem *)candidateListTouchBarItem {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end
