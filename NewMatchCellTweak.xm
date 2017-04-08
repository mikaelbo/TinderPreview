#import "UIFont+MBTNDRFont.h"
#import "UIView+MBTNDRActionSheet.h"
#import "MBTNDRClassHeaders.h"
#import "MBTNDRActionSheetController.h"
#import "MBTNDRProfileDisplayer.h"

%hook TNDRNewMatchCollectionViewCell

- (void)setup {
    %orig;
    if ([self.match respondsToSelector:@selector(theirGroupOwner)]) {
        if (self.match.theirGroupOwner) { return; }
    }
    if ([self.match respondsToSelector:@selector(myGroup)]) {
        if (self.match.myGroup) { return; }
    }
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(MBTNDR_longPress:)];
    recognizer.minimumPressDuration = 0.25;
    [self.avatarImageView addGestureRecognizer:recognizer];
    self.avatarImageView.userInteractionEnabled = YES;
}

- (void)showCurrentMatchProfile {
    [[MBTNDRProfileDisplayer currentDisplayer] showMatchProfileWithMatch:self.match];
}

- (void)reportCurrentMatch {
    TNDRSlidingPagedViewController *rootVC = (TNDRSlidingPagedViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC.matchesViewController didRequestToReport:self.match];
}

- (void)blockCurrentMatch {
    TNDRSlidingPagedViewController *rootVC = (TNDRSlidingPagedViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC.matchesViewController didRequestToUnmatch:self.match];
}

- (void)messageCurrentMatch {
    TNDRSlidingPagedViewController *rootVC = (TNDRSlidingPagedViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    TNDRNewMatchesViewController *newMatchesVC = rootVC.matchesViewController.matchesCollectionViewController;
    [newMatchesVC collectionView:newMatchesVC.collectionView didSelectItemAtIndexPath:[newMatchesVC.collectionView indexPathForCell:self]];
}

%new
- (void)MBTNDR_longPress:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state != UIGestureRecognizerStateBegan) {  return;  }

    TNDRSlidingPagedViewController *rootVC = (TNDRSlidingPagedViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if (![rootVC isKindOfClass:NSClassFromString(@"TNDRSlidingPagedViewController")]) { return; }
    TNDRMatchesViewController *matchesVC = rootVC.matchesViewController;

    NSMutableArray<NSString *> *titles = [NSMutableArray array];

    if ([[MBTNDRProfileDisplayer currentDisplayer] canShowMatchProfile]) { 
        [titles addObject:@"Show profile"];
    }

    if ([matchesVC respondsToSelector:@selector(matchesCollectionViewController)]) {
        TNDRNewMatchesViewController *collectionVC = matchesVC.matchesCollectionViewController;
        if ([collectionVC respondsToSelector:@selector(collectionView)] &&
            [collectionVC respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
            [titles addObject:@"Message"];
        }
    }

    if ([matchesVC respondsToSelector:@selector(didRequestToReport:)]) { 
        [titles addObject:@"Report"];
    }
    
    if ([matchesVC respondsToSelector:@selector(didRequestToUnmatch:)]) { 
        [titles addObject:@"Unmatch"];
    }

    if (titles.count > 0) {
        NSString *name = [self respondsToSelector:@selector(nameLabel)] ? self.nameLabel.text : nil;
        MBTNDRActionSheetController *controller = [MBTNDRActionSheetController controllerWithButtonTitles:titles
                                                                                                   name:name
                                                                                                  image:self.avatarImageView.image];
        controller.canTapToDismiss = YES;
        __weak __typeof(self) weakSelf = self;
        controller.dismissBlock = ^void (NSUInteger index) {
            switch (index) {
                case 1: [weakSelf blockCurrentMatch]; break;
                case 2: [weakSelf reportCurrentMatch]; break;
                case 3: [weakSelf messageCurrentMatch]; break;
                case 4: [weakSelf showCurrentMatchProfile]; break;
                default: break;
            }
        };
        [controller showInTopViewController];
    }
}

%end
