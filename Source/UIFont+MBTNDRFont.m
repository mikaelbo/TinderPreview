#import "UIFont+MBTNDRFont.h"

@implementation UIFont(MBTNDRFont)

+ (UIFont *)defaultFontOfSize:(CGFloat)size {
	UIFont *font = [UIFont fontWithName:@"ProximaNovaSoft-Regular" size:size];
	return font ? : [UIFont systemFontOfSize:size];
}

+ (UIFont *)boldFontOfSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"ProximaNovaSoft-Bold" size:size];
    return font ? : [UIFont boldFontOfSize:size];
}

+ (UIFont *)semiBoldFontOfSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"ProximaNovaSoft-Semibold" size:size];
    return font ? : [self boldFontOfSize:size];
}

+ (UIFont *)mediumFontOfSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"ProximaNovaSoft-Medium" size:size];
    return font ? : [self defaultFontOfSize:size];
}

@end
