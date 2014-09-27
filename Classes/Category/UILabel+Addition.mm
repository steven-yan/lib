/**
 *
 * @author steven
 *
 */

#import "UILabel+Addition.h"

@implementation UILabel (Addition)

+ (UILabel *)labelWithLeft:(CGFloat)left Top:(CGFloat)top Width:(CGFloat)width Height:(CGFloat)height FontSize:(CGFloat)size {
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(left, top, width, height)];
    l.font = [UIFont systemFontOfSize:size];
    l.backgroundColor = [UIColor clearColor];
    
    return l;
}

+ (CGSize)dynamicHeightWithStr:(NSString *)str width:(CGFloat)width fontSize:(int)fontSize {
    CGSize textSize = CGSizeZero;
    if ([str respondsToSelector:@selector(sizeWithFont:constrainedToSize:lineBreakMode:)]) {
        textSize = [str sizeWithFont:[UIFont systemFontOfSize:fontSize]
                   constrainedToSize:CGSizeMake(width, MAXFLOAT)
                       lineBreakMode:NSLineBreakByWordWrapping];
    } else if ([str respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        textSize = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:[UIFont systemFontOfSize:fontSize].fontDescriptor.fontAttributes
                                     context:nil].size;
        //修正尺寸
        textSize.width += 16;
        textSize.height += 4.2;
    }
    
    return textSize;
}

- (CGSize)setDynamicWithStr:(NSString *)str fontSize:(int)fontSize {
    CGSize textSize = [UILabel dynamicHeightWithStr:str width:self.width fontSize:fontSize];
    
    self.text = str;
    self.height = textSize.height;
    
    return textSize;
}



@end
