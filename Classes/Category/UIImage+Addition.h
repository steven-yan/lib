/**
 *
 * @author steven
 *
 */

@interface UIImage (Addition)


+(UIImage *)stretchableImageNamed:(NSString *)name;
+ (UIImage *)scaleImg:(UIImage *)img toSize:(CGSize)size;
+ (UIImage *)imageForView:(UIView *)v;



@end
