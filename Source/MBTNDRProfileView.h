#import <UIKit/UIKit.h>

@interface MBTNDRProfileView : UIView

@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UILabel *nameLabel;

- (void)animateViews;
- (void)animateDismiss;

@end
