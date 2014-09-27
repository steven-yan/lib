/**
 *
 * @author steven
 *
 */

@implementation UIView (Layout)

-(void)setStyleForSection{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 8;
    self.clipsToBounds = YES;
}

-(void)bringToFont{
    if (self.superview!=nil) {
        [self.superview bringSubviewToFront:self];
    }
}

-(void)sendToBack{
    if (self.superview!=nil) {
        [self.superview sendSubviewToBack:self];
    }
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat) right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat) bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


- (CGFloat)width {
  return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
  CGRect frame = self.frame;
  frame.size.width = width;
  self.frame = frame;
}

- (CGFloat)height {
  return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
  CGRect frame = self.frame;
  frame.size.height = height;
  self.frame = frame;
}

- (CGPoint)origin {
  return self.frame.origin;
}


- (void)setOrigin:(CGPoint)origin {
  CGRect frame = self.frame;
  frame.origin = origin;
  self.frame = frame;
}

- (CGSize)size {
  return self.frame.size;
}

- (void)setSize:(CGSize)size {
  CGRect frame = self.frame;
  frame.size = size;
  self.frame = frame;
}



@end


@implementation UIView (BackGround)

- (void)setBgColorWithImage:(NSString *)name {
    UIColor *bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:name]];
    self.backgroundColor = bgColor;
}

@end

@implementation UIView (Line)
+ (instancetype)lineWithWidth:(CGFloat)width {
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1)];
    v.backgroundColor = [UIColor colorWithHexStr:@"#cccccc"];
    return v;
}
@end
