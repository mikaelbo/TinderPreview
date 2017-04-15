#import "UIFont+MBTNDRFont.h"
#import "UIView+MBTNDRActionSheet.h"
#import "MBTNDRClassHeaders.h"
#import "MBTNDRActionSheetController.h"
#import "MBTNDRProfileDisplayer.h"

%hook TNDRMatchCell

- (void)setup {
    %orig;
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(MBTNDR_longPress:)];
    recognizer.minimumPressDuration = 0.25;
    recognizer.delegate = self;
    [self.contentView addGestureRecognizer:recognizer];
}

- (void)layoutSubviews {
    %orig;
    if ([[MBTNDRProfileDisplayer currentDisplayer] canShowMatchProfile] && [self respondsToSelector:@selector(avatarImageView)]) {
        if (!self.avatarImageView.userInteractionEnabled) {
            self.avatarImageView.userInteractionEnabled = YES;
            [self.avatarImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MBTNDR_avatarTap)]];
        }
    }
}

%new 
- (void)MBTNDR_avatarTap {
    TNDRSlidingPagedViewController *rootVC = (TNDRSlidingPagedViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if (![rootVC isKindOfClass:NSClassFromString(@"TNDRSlidingPagedViewController")]) { return; }
    TNDRMatchesViewController *matchesVC = rootVC.matchesViewController;
    if (![matchesVC respondsToSelector:@selector(matchesWithMessagesViewModel)]) { return; }
    TNDRMatchesMessagesViewModel *viewModel = matchesVC.matchesWithMessagesViewModel;
    if (![viewModel respondsToSelector:@selector(matchForIndexPath:)]) { return; }
    NSIndexPath *indexPath = [matchesVC.tableView indexPathForCell:self];
    TNDRMatch *match = [viewModel matchForIndexPath:indexPath];
    if ([match respondsToSelector:@selector(theirGroupOwner)]) {
        if (match.theirGroupOwner) { return; }
    }
    if ([match respondsToSelector:@selector(myGroup)]) {
        if (match.myGroup) { return; }
    }
    [self showCurrentMatchProfile];
}

- (void)showCurrentMatchProfile {
    TNDRSlidingPagedViewController *rootVC = (TNDRSlidingPagedViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if (![rootVC isKindOfClass:NSClassFromString(@"TNDRSlidingPagedViewController")]) { return; }
    TNDRMatchesViewController *matchesVC = rootVC.matchesViewController;
    if (![matchesVC respondsToSelector:@selector(matchesWithMessagesViewModel)] ||
        ![matchesVC respondsToSelector:@selector(tableView)]) { 
        return; 
    }
    TNDRMatchesMessagesViewModel *viewModel = matchesVC.matchesWithMessagesViewModel;
    NSIndexPath *indexPath = [matchesVC.tableView indexPathForCell:self];
    if (![viewModel respondsToSelector:@selector(matchForIndexPath:)]) { return; }
    [[MBTNDRProfileDisplayer currentDisplayer] showMatchProfileWithMatch:[viewModel matchForIndexPath:indexPath]];
}

- (void)reportCurrentMatch {
    TNDRSlidingPagedViewController *rootVC = (TNDRSlidingPagedViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    TNDRMatchesViewController *matchesVC = rootVC.matchesViewController;
    TNDRMatchesMessagesViewModel *viewModel = matchesVC.matchesWithMessagesViewModel;
    NSIndexPath *indexPath = [matchesVC.tableView indexPathForCell:self];
    [matchesVC didRequestToReport:[viewModel matchForIndexPath:indexPath]];
}

- (void)blockCurrentMatch {
    TNDRSlidingPagedViewController *rootVC = (TNDRSlidingPagedViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    TNDRMatchesViewController *matchesVC = rootVC.matchesViewController;
    TNDRMatchesMessagesViewModel *viewModel = matchesVC.matchesWithMessagesViewModel;
    NSIndexPath *indexPath = [matchesVC.tableView indexPathForCell:self];
    [matchesVC didRequestToUnmatch:[viewModel matchForIndexPath:indexPath]];
}

- (void)messageCurrentMatch {
    TNDRSlidingPagedViewController *rootVC = (TNDRSlidingPagedViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    TNDRMatchesViewController *matchesVC = rootVC.matchesViewController;
    [matchesVC tableView:matchesVC.tableView didSelectRowAtIndexPath:[matchesVC.tableView indexPathForCell:self]];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    TNDRSlidingPagedViewController *rootVC = (TNDRSlidingPagedViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if (![rootVC isKindOfClass:NSClassFromString(@"TNDRSlidingPagedViewController")]) { return NO; }
    TNDRMatchesViewController *matchesVC = rootVC.matchesViewController;
    if (![matchesVC respondsToSelector:@selector(matchesWithMessagesViewModel)]) { return NO; }
    TNDRMatchesMessagesViewModel *viewModel = matchesVC.matchesWithMessagesViewModel;
    if (![viewModel respondsToSelector:@selector(matchForIndexPath:)]) { return NO; }
    NSIndexPath *indexPath = [matchesVC.tableView indexPathForCell:self];
    TNDRMatch *match = [viewModel matchForIndexPath:indexPath];
    if ([match respondsToSelector:@selector(theirGroupOwner)]) {
        if (match.theirGroupOwner) { return NO; }
    }
    if ([match respondsToSelector:@selector(myGroup)]) {
        if (match.myGroup) { return NO; }
    }
    return YES;
}

%new
- (void)MBTNDR_longPress:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state != UIGestureRecognizerStateBegan) {  return;  }

    TNDRSlidingPagedViewController *rootVC = (TNDRSlidingPagedViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if (![rootVC isKindOfClass:NSClassFromString(@"TNDRSlidingPagedViewController")]) { return; }
    TNDRMatchesViewController *matchesVC = rootVC.matchesViewController;
    if (![matchesVC respondsToSelector:@selector(matchesWithMessagesViewModel)]) { return; }
    TNDRMatchesMessagesViewModel *viewModel = matchesVC.matchesWithMessagesViewModel;
    if (![viewModel respondsToSelector:@selector(matchForIndexPath:)]) { return; }
    NSIndexPath *indexPath = [matchesVC.tableView indexPathForCell:self];
    TNDRMatch *match = [viewModel matchForIndexPath:indexPath];
    if ([match respondsToSelector:@selector(theirGroupOwner)]) {
        if (match.theirGroupOwner) { return; }
    }
    if ([match respondsToSelector:@selector(myGroup)]) {
        if (match.myGroup) { return; }
    }

    NSMutableArray<NSString *> *titles = [NSMutableArray array];
    if ([matchesVC respondsToSelector:@selector(tableView)] &&
        [[MBTNDRProfileDisplayer currentDisplayer] canShowMatchProfile]) { 
        [titles addObject:@"Show profile"];
    }

    if ([matchesVC respondsToSelector:@selector(tableView)] &&
        [matchesVC respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [titles addObject:@"Message"];
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
