#import "UIFont+MBTNDRFont.h"

@implementation UIFont(MBTNDRFont)

+ (UIFont *)defaultFontOfSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"ProximaNovaSoft-Regular" size:size];
    if (!font) { font = [UIFont fontWithName:@"ProximaNova-Regular" size:size]; }
    return font ? : [UIFont systemFontOfSize:size];
}

+ (UIFont *)boldFontOfSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"ProximaNovaSoft-Bold" size:size];
    if (!font) { font = [UIFont fontWithName:@"ProximaNova-Bold" size:size]; }
    return font ? : [UIFont boldSystemFontOfSize:size];
}

+ (UIFont *)semiBoldFontOfSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"ProximaNovaSoft-Semibold" size:size];
    if (!font) { font = [UIFont fontWithName:@"ProximaNova-Semibold" size:size]; }
    return font ? : [self boldFontOfSize:size];
}

+ (UIFont *)mediumFontOfSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"ProximaNovaSoft-Medium" size:size];
    if (!font) { font = [UIFont fontWithName:@"ProximaNova-Semibold" size:size]; }
    return font ? : [self defaultFontOfSize:size];
}

@end
