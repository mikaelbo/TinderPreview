#import <Foundation/Foundation.h>
#import "MBTNDRClassHeaders.h"

@interface MBTNDRProfileDisplayer : NSObject

+ (instancetype)currentDisplayer;

- (BOOL)canShowMatchProfile;
- (void)showMatchProfileWithMatch:(TNDRMatch *)match;

@end
