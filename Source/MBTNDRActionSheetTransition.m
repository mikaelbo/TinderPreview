#import "MBTNDRActionSheetTransition.h"
#import "MBTNDRActionSheetController.h"

@interface MBTNDRActionSheetTransition()

@property (nonatomic, strong) UIView *backgroundView;

@end


@implementation MBTNDRActionSheetTransition

- (instancetype)initWithPresentDuration:(CGFloat)presentDuration dismissDuration:(CGFloat)dismissDuration {
    if (self = [super init]) {
        _presentDuration = presentDuration;
        _dismissDuration = dismissDuration;
    }
    return self;
}

- (instancetype)init {
    return [self initWithPresentDuration:0.35 dismissDuration:0.2];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.isPresenting ? self.presentDuration : self.dismissDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.isPresenting) {
        [self animatePresentationWithContext:transitionContext];
    } else {
        [self animateDismissalWithContext:transitionContext];
    }
}

- (void)animatePresentationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    MBTNDRActionSheetController *controller = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.backgroundView.alpha = 0;
    self.backgroundView.frame = containerView.bounds;
    containerView.backgroundColor = [UIColor clearColor];
    [containerView addSubview:self.backgroundView];
    [containerView addSubview:controller.view];
    CGFloat duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundView.alpha = 1;
    }];
    
    CGRect buttonsContainerFrame = controller.buttonsContainer.frame;
    CGRect newButtonsContainerFrame = buttonsContainerFrame;
    newButtonsContainerFrame.origin.y = containerView.bounds.size.height + 20;
    
    CGRect cancelButtonFrame = controller.cancelButton.frame;
    CGRect newCancelButtonFrame = cancelButtonFrame;
    newCancelButtonFrame.origin.y = newButtonsContainerFrame.origin.y + newButtonsContainerFrame.size.height;
    
    controller.buttonsContainer.frame = newButtonsContainerFrame;
    controller.cancelButton.frame = newCancelButtonFrame;
    [controller.profileView animateViews];
    
    [UIView animateWithDuration:duration delay:0.08 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        controller.cancelButton.frame = cancelButtonFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        controller.buttonsContainer.frame = buttonsContainerFrame;
    } completion:nil];
    
}

- (void)animateDismissalWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    MBTNDRActionSheetController *controller = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGFloat duration = [self transitionDuration:transitionContext];
    UIView *containerView = [transitionContext containerView];
    
    CGRect newButtonsContainerFrame = controller.buttonsContainer.frame;
    newButtonsContainerFrame.origin.y = containerView.bounds.size.height;
    
    CGRect newCancelButtonFrame = controller.cancelButton.frame;
    newCancelButtonFrame.origin.y = newButtonsContainerFrame.origin.y + newButtonsContainerFrame.size.height + 10;
    [controller.profileView animateDismiss];
    
    [UIView animateWithDuration:duration animations:^{
        self.backgroundView.alpha = 0;
    }];
    [UIView animateWithDuration:duration animations:^{
        controller.buttonsContainer.frame = newButtonsContainerFrame;
        controller.cancelButton.frame = newCancelButtonFrame;
    } completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
        [controller.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6f];
    }
    return _backgroundView;
}

@end
