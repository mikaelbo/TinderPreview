#import "MBTNDRProfileView.h"
#import "UIFont+MBTNDRFont.h"

@implementation MBTNDRProfileView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureView];
    }
    return self;
}

- (void)configureView {
    self.userInteractionEnabled = NO;
    [self createProfileImageView];
    [self createNameLabel];
    self.nameLabel.alpha = 0;
    self.profileImageView.alpha = 0;
}

- (void)createProfileImageView {
    CGFloat size = 120;
    CGFloat screenHeight = self.bounds.size.height;
    CGFloat imageViewY = 39;
    
    // Extremely dynamic screen based layout ;)
    if (screenHeight <= 480) {
        imageViewY = 39;
    } else if (screenHeight <= 568) {
        imageViewY = 77;
    } else if (screenHeight <= 667) {
        imageViewY = 89;
    } else {
        imageViewY = 135;
        size = 150;
    }
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - size) / 2, imageViewY, size, size)];
    self.profileImageView.layer.cornerRadius = size / 2;
    self.profileImageView.layer.masksToBounds = YES;
    self.profileImageView.layer.borderWidth = 5;
    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self addSubview:self.profileImageView];
}

- (void)createNameLabel {
    CGFloat wantedY = self.profileImageView.frame.origin.y + self.profileImageView.frame.size.height + 12;
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, wantedY, self.frame.size.width, 30)];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont boldFontOfSize:26];
    [self addSubview:self.nameLabel];
}

- (void)animateViews {
    self.profileImageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.nameLabel.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.nameLabel.alpha = 1;
    self.profileImageView.alpha = 1;
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^(void) {
        self.profileImageView.transform = CGAffineTransformIdentity;
        self.nameLabel.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)animateDismiss {
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^(void) {
        self.profileImageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.nameLabel.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.profileImageView.alpha = 0;
        self.nameLabel.alpha = 0;
    } completion:nil];
}

@end
