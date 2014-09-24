/**
 *
 * @author steven
 *
 */

@interface UILabel (Addition)

+ (UILabel *)labelWithLeft:(CGFloat)left Top:(CGFloat)top Width:(CGFloat)width Height:(CGFloat)height FontSize:(CGFloat)size;
//动态高度
+ (CGSize)dynamicHeightWithStr:(NSString *)str width:(CGFloat)width fontSize:(int)fontSize;
- (CGSize)setDynamicHeightWithStr:(NSString *)str fontSize:(int)fontSize;



@end
