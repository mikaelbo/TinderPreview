#import <UIKit/UIKit.h>
#import "MBTNDRProfileView.h"

typedef void (^ActionSheetDismissBlock)(NSUInteger index);

@interface MBTNDRActionSheetController : UIViewController

@property (nonatomic, copy) ActionSheetDismissBlock dismissBlock;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIView *buttonsContainer;
@property (nonatomic, strong) MBTNDRProfileView *profileView;
@property (nonatomic) BOOL canTapToDismiss;

+ (instancetype)controllerWithButtonTitles:(NSArray<NSString *> *)titles name:(NSString *)name image:(UIImage *)image;
- (instancetype)initWithButtonTitles:(NSArray<NSString *> *)titles name:(NSString *)name image:(UIImage *)image;

- (void)showInTopViewController;

@end
