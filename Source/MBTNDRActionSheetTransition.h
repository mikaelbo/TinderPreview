#import <UIKit/UIKit.h>

@interface MBTNDRActionSheetTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, getter=isPresenting) BOOL presenting;
@property (nonatomic) CGFloat presentDuration;
@property (nonatomic) CGFloat dismissDuration;

- (instancetype)initWithPresentDuration:(CGFloat)presentDuration dismissDuration:(CGFloat)dismissDuration;

@end
