#import "MBTNDRClassHeaders.h"
#import <objc/runtime.h>

@implementation UITableViewCell(GestureRecognizer)

- (void)MBTNDR_setLongPressRecognizer:(UILongPressGestureRecognizer *)recognizer {
    objc_setAssociatedObject(self, @selector(MBTNDR_longPressRecognizer), recognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILongPressGestureRecognizer *)MBTNDR_longPressRecognizer {
    return objc_getAssociatedObject(self, @selector(MBTNDR_longPressRecognizer));
}

@end
