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


@implementation UIButton (CellBtn)

+ (UIButton *)btnCellWithTitle:(NSString *)title {
    return [UIButton btnCellWithTitle:title height:40];
}

+ (UIButton *)btnCellWithTitle:(NSString *)title height:(CGFloat)height {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Global.instance.sysInfo.fullWidth - 20, height)];
    //title
    UILabel *l = [UILabel labelWithLeft:30 Top:0 Width:btn.width Height:btn.height FontSize:16];
    l.centerY = height / 2;
    l.text = title;
    [btn addSubview:l];
    //img
    [btn setImage:[UIImage imageNamed:@"ic_list"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.width - btn.imageView.width - 20, 0, 0)];
    
    return btn;
}


@end
