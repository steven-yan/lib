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



@end
