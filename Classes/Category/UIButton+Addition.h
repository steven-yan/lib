/**
 *
 * @author steven
 *
 */

@interface UIButton (Addition)


- (void)addTarget:(id)target action:(SEL)action;
- (void)setFrame:(CGRect)frame imgName:(NSString *)imgName;
- (void)setBgImg:(NSString *)imgName;
- (void)setStretchableBgImg:(NSString *)imgName;
- (void)setBgImgHl:(NSString *)imgName;
- (void)setBgImgWithImg:(UIImage *)img;
- (void)setTitle:(NSString *)title;
- (void)setTitleColor:(UIColor *)color;


@end

@interface UIButton (Style)

//cell btn
+ (UIButton *)btnCellWithTitle:(NSString *)title;
+ (UIButton *)btnCellWithTitle:(NSString *)title height:(CGFloat)height;

- (void)setStyleGray;
- (void)setStyleGreen;



@end
