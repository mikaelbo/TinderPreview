#import "MBTNDRActionSheetController.h"
#import "MBTNDRActionSheetTransition.h"
#import "UIFont+MBTNDRFont.h"


//#define TINT_COLOR [UIColor colorWithRed:253 / 255.0 green:80 / 255.0 blue:104 / 255.0 alpha:1]
#define TINT_COLOR [UIColor colorWithRed:28 / 255.0 green:126 / 255.0 blue:240 / 255.0 alpha:1]
#define BUTTON_INSET 8
#define BUTTON_HEIGHT 48


@interface MBTNDRActionSheetController () <UIViewControllerTransitioningDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) MBTNDRActionSheetTransition *transition;
@property (nonatomic, strong) NSArray *buttonTitles;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *image;

@end


@implementation MBTNDRActionSheetController

+ (instancetype)controllerWithButtonTitles:(NSArray<NSString *> *)titles name:(NSString *)name image:(UIImage *)image {
    return [[self alloc] initWithButtonTitles:titles name:name image:image];
}

- (instancetype)initWithButtonTitles:(NSArray<NSString *> *)titles name:(NSString *)name image:(UIImage *)image {
    if (self = [super init]) {
        _buttonTitles = titles;
        _name = name;
        _image = image;
        [self configureTransitionining];
    }
    return self;
}

- (void)configureTransitionining {
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tapRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapRecognizer];
    [self createCancelButton];
    [self createOtherButtons];
    [self createProfileView];
}

- (void)createCancelButton {
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake(BUTTON_INSET,
                                         self.view.frame.size.height - BUTTON_HEIGHT - 7,
                                         self.view.frame.size.width - BUTTON_INSET * 2,
                                         BUTTON_HEIGHT);
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.cancelButton setBackgroundImage:[self resizableImageWithColor:TINT_COLOR] forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:TINT_COLOR forState:UIControlStateHighlighted];
    [self.cancelButton setBackgroundImage:[self resizableImageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    self.cancelButton.layer.cornerRadius = 4;
    self.cancelButton.layer.masksToBounds = YES;
    self.cancelButton.tag = 0;
    self.cancelButton.titleLabel.font = [UIFont mediumFontOfSize:21];
    [self.cancelButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
}

- (void)createOtherButtons {
    self.buttonsContainer = [[UIView alloc] initWithFrame:self.view.bounds];
    CGFloat containerHeight = self.buttonTitles.count * BUTTON_HEIGHT;
    self.buttonsContainer.frame = CGRectMake(BUTTON_INSET,
                                             self.cancelButton.frame.origin.y - 10 - containerHeight,
                                             self.view.bounds.size.width - BUTTON_INSET * 2,
                                             containerHeight);
    NSUInteger count = self.buttonTitles.count;
    [self.buttonTitles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = count - idx;
        CGFloat y = idx * BUTTON_HEIGHT + idx;
        button.frame = CGRectMake(0, y, self.buttonsContainer.bounds.size.width, BUTTON_HEIGHT);
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:TINT_COLOR forState:UIControlStateNormal];
        [button setBackgroundImage:[self resizableImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[self resizableImageWithColor:TINT_COLOR] forState:UIControlStateHighlighted];
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont mediumFontOfSize:21];
        [self.buttonsContainer addSubview:button];
    }];
    self.buttonsContainer.backgroundColor = [UIColor clearColor];
    self.buttonsContainer.layer.cornerRadius = 4;
    self.buttonsContainer.layer.masksToBounds = YES;
    [self.view addSubview:self.buttonsContainer];
}

- (void)createProfileView {
    self.profileView = [[MBTNDRProfileView alloc] initWithFrame:self.view.bounds];
    self.profileView.nameLabel.text = self.name;
    self.profileView.profileImageView.image = self.image;
    [self.view addSubview:self.profileView];
}

- (void)buttonTapped:(UIButton *)button {
    [self dismissWithIndex:button.tag];
}

- (void)dismissWithIndex:(NSUInteger)index {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.dismissBlock) {
            self.dismissBlock(index);
        }
    }];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.canTapToDismiss;
}

- (void)viewTapped {
    [self dismissWithIndex:0];
}

- (void)showInTopViewController {
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.transition.presenting = YES;
    return self.transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.transition.presenting = NO;
    return self.transition;
}

#pragma mark - Image 

- (UIImage *)resizableImageWithColor:(UIColor *)color {
    UIGraphicsBeginImageContext(CGSizeMake(1.f, 1.f));
    [color setFill];
    UIRectFill(CGRectMake(0.f, 0.f, 1.f, 1.f));
    UIImage *image = [UIGraphicsGetImageFromCurrentImageContext() resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Getters

- (MBTNDRActionSheetTransition *)transition {
    return _transition ? : (_transition = [[MBTNDRActionSheetTransition alloc] init]);
}

@end
