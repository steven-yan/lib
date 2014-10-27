/**
 *
 * @author steven
 *
 */

#import "UIImage+Addition.h"

@implementation UIImage (Addition)

+(UIImage *)stretchableImageNamed:(NSString *)name {
    UIImage *img = [self imageNamed:name];
    img = [img stretchableImageWithLeftCapWidth:floorf(img.size.width/2)
                                   topCapHeight:floorf(img.size.height/2)];
    return img;
}



+ (UIImage *)scaleImg:(UIImage *)img toSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}



@end
