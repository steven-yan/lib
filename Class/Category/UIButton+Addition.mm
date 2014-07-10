/**
 *
 * @author steven
 *
 */

#import "UIButton+Addition.h"

@implementation UIButton (Addition)


- (void)addTarget:(id)target action:(SEL)action{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setFrame:(CGRect)frame imgName:(NSString *)imgName {
    self.frame = frame;
    [self setBgImg:imgName];
}

- (void)setBgImg:(NSString *)imgName{
    [self setBgImg:imgName forState:UIControlStateNormal];
}

- (void)setStretchableBgImg:(NSString *)imgName{
    [self setBgImgWithImg:[UIImage stretchableImageNamed:imgName]];
}



- (void)setBgImgHl:(NSString *)imgName{
    [self setBgImg:imgName forState:UIControlStateSelected];
}

- (void)setBgImg:(NSString *)imgName forState:(UIControlState)state{
    [self setBackgroundImage:[UIImage imageNamed:imgName] forState:state];
}

- (void)setBgImgWithImg:(UIImage *)img{
    [self setBackgroundImage:img forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title{
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)color{
    [self setTitleColor:color forState:UIControlStateNormal];
}


@end
