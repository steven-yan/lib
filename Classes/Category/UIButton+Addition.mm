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


@implementation UIButton (Style)

+ (UIButton *)btnCellWithTitle:(NSString *)title image:(NSString *)image {
    return [UIButton btnCellWithTitle:title image:image height:40];
}

+ (UIButton *)btnCellWithTitle:(NSString *)title image:(NSString *)image height:(CGFloat)height {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Global.instance.sysInfo.fullWidth - 20, height)];
    //image
    UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, 20, 20)];
    [v setImage:[UIImage imageNamed:image]];
    v.centerY = height/2;
    [btn addSubview:v];
    //title
    UILabel *l = [UILabel labelWithLeft:35 Top:0 Width:btn.width Height:btn.height FontSize:16];
    l.text = title;
    l.centerY = height/2;
    [btn addSubview:l];
    //img
    [btn setImage:[UIImage imageNamed:@"ic_list"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.width - btn.imageView.width - 20, 0, 0)];
    
    return btn;
}

- (void)setStyleGray {
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    [self setTitleColor:[UIColor grayColor]];
    [self setNormalBtnStyle];
}

- (void)setStyleGreen {
    self.backgroundColor =[UIColor generalColor];
    [self setNormalBtnStyle];
}

- (void)setNormalBtnStyle {
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.layer.cornerRadius = 4;
}



@end
