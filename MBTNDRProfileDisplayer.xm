#import "MBTNDRProfileDisplayer.h"

@interface MBTNDRProfileDisplayer()

@property (nonatomic, strong) TNDRSlackChatViewController *chatVC;

@end


@implementation MBTNDRProfileDisplayer

+ (instancetype)currentDisplayer {
    static dispatch_once_t onceToken;
    static MBTNDRProfileDisplayer *currentDisplayer;
    dispatch_once(&onceToken, ^{
        currentDisplayer = [[MBTNDRProfileDisplayer alloc] init];
        if ([[%c(TNDRSlackChatViewController) alloc] respondsToSelector:@selector(initWithMatch:cachedMatchImage:animationDelegate:currentUser:)]
            && [%c(TNDRCurrentUser) respondsToSelector:@selector(sharedCurrentUser)]) {
            currentDisplayer.chatVC = [[%c(TNDRSlackChatViewController) alloc] initWithMatch:nil 
                                                                            cachedMatchImage:nil 
                                                                           animationDelegate:nil 
                                                                                 currentUser:[%c(TNDRCurrentUser) sharedCurrentUser]];
        }
    });
    return currentDisplayer;
}

- (BOOL)canShowMatchProfile {
    return [self.chatVC respondsToSelector:@selector(showMatchProfileWithUser:)];
}

- (void)showMatchProfileWithMatch:(TNDRMatch *)match {
    if (![self canShowMatchProfile]) { return; }
    if ([match respondsToSelector:@selector(user)]) {
        [self.chatVC showMatchProfileWithUser:match.user];
    }
}

@end
