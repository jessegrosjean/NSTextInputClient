#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextEditorBase : NSView <NSTextCheckingClient>

@property NSTextInputTraitType autocorrectionType;
@property NSTextInputTraitType spellCheckingType;
@property NSTextInputTraitType grammarCheckingType;
@property NSTextInputTraitType smartQuotesType;
@property NSTextInputTraitType smartDashesType;
@property NSTextInputTraitType smartInsertDeleteType;
@property NSTextInputTraitType textReplacementType;
@property NSTextInputTraitType dataDetectionType;
@property NSTextInputTraitType linkDetectionType;
@property NSTextInputTraitType textCompletionType;

- (NSUInteger)characterIndexForPoint:(NSPoint)point;

@end

NS_ASSUME_NONNULL_END
