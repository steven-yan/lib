/**
 *
 *  NavVc
 *  @author steven
 *  @date Otc 22 2014
 *
 **/

#import "NavVc.h"

@implementation NavVc
static char objectKey = 0;
static int kMaxHoldWidth = SysInfo.instance.fullWidth * 0.66;
static int kMaxVelocity = 500;
static float kDefaultAlpha = 0.6;



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self == [super init]) {
        //控件-------------------
        //Ges
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        pan.delegate = self;
        [self.view addGestureRecognizer:pan];
        //snap
        self.ctrlSnap = nil;
    }
}



#pragma mark -
#pragma mark ------------------------------方法----------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/
//保存图片
- (void)setVcPic:(BaseVc *)vc view:(UIView *)v {
    if ([self getVcPic:vc] == nil) {
        //设置图片
        UIImage *img = [UIImage imageForView:v];
        objc_setAssociatedObject(vc, &objectKey, img, OBJC_ASSOCIATION_RETAIN);
    }
}

//获取图片
- (UIImage *)getVcPic:(BaseVc *)vc {
    return objc_getAssociatedObject(vc, &objectKey);
}

//清空图片
- (void)cleanVcPic:(BaseVc *)vc {
    objc_setAssociatedObject(vc, &objectKey, nil, OBJC_ASSOCIATION_RETAIN);
}



#pragma mark -
#pragma mark -------------------UIGestureRecognizerDelegate---------------------
/*------------------------------------------------------------------------------
 |  UIGestureRecognizerDelegate
 |
 -----------------------------------------------------------------------------*/
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    UIViewController *v = (UIViewController *)[self topViewController];
    
    //容错
    if ([v isKindOfClass:NSClassFromString(@"BaseVc")] == NO || self.viewControllers.count <= 1 || SysInfo.instance.isIpadTag) {
        return NO;
    }
    
    return [(BaseVc *)v canSwipeBack];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)handlePan:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateBegan) {
        [self.view endEditing:YES];
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        [self touchMoved:pan];
    } else if (pan.state == UIGestureRecognizerStateCancelled ||
               pan.state == UIGestureRecognizerStateEnded ||
               pan.state == UIGestureRecognizerStateFailed) {
        [self touchEnd:pan];
    }
}

- (void)touchMoved:(UIPanGestureRecognizer *)pan {
    CGPoint p = [pan translationInView:[pan.view superview]];
    
    //容错
    if (p.x + pan.view.left <= 0) {
        return;
    }
    
    pan.view.centerX = pan.view.centerX + p.x;
    [pan setTranslation:CGPointZero inView:[pan.view superview]];
    
    if (self.ctrlSnap == nil) {
        UIImageView *snap = [[UIImageView alloc] initWithFrame:self.view.bounds];
        CALayer *mask = [CALayer layer];
        mask.frame = snap.bounds;
        snap.layer.mask = mask;
        snap.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin| UIViewAutoresizingFlexibleHeight;
        if (SysInfo.instance.isIos6Tag) {
            snap.top = 20;
            snap.height -= 20;
        }
        
        self.ctrlSnap.right = self.ctrlSnap.width-kMaxHoldWidth;
        self.ctrlSnap.layer.mask.backgroundColor = [UIColor colorWithWhite:1 alpha:kDefaultAlpha].CGColor;
        [self.view.superview insertSubview:snap belowSubview:self.view];
        self.ctrlSnap = snap;
    }
    
    BaseVc *vc = (BaseVc *)[self topViewController];
    self.ctrlSnap.image = [self getVcPic:vc];
    self.ctrlSnap.hidden = NO;
    
    self.ctrlSnap.right = pan.view.left*(kMaxHoldWidth/pan.view.width) + self.ctrlSnap.width-kMaxHoldWidth;
    float r = pan.view.left/pan.view.width * 0.8;
    self.ctrlSnap.layer.mask.backgroundColor = [UIColor colorWithWhite:1 alpha:kDefaultAlpha+r].CGColor;
}

- (void)touchEnd:(UIPanGestureRecognizer *)pan {
    //velocity
    CGPoint velocity = [pan velocityInView:[pan.view superview]];
    
    if (self.view.left <= 0 || ( self.view.left < 120 && velocity.x < kMaxVelocity)) {
        [UIView animateWithDuration:0.2 animations:^{
            pan.view.centerX = pan.view.width/2;
            self.ctrlSnap.right = self.ctrlSnap.width-kMaxHoldWidth;
            self.ctrlSnap.layer.mask.backgroundColor = [UIColor colorWithWhite:1 alpha:kDefaultAlpha].CGColor;
        } completion:^(BOOL finished) {
            [self handlePop:NO];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.view.left = self.view.width;
            self.ctrlSnap.left = 0;
            self.ctrlSnap.layer.mask.backgroundColor = [UIColor colorWithWhite:1 alpha:1].CGColor;
        } completion:^(BOOL finished) {
            [self handlePop:YES];
        }];
    }
}

- (void)handlePop:(bool)popTag {
    if (popTag) {
        BaseVc *vc = (BaseVc *)[self topViewController];
        [vc onSwipeBack];
        [self cleanVcPic:vc];
    }
    
    self.view.centerX = self.view.width/2;
    self.ctrlSnap.right = self.ctrlSnap.width-kMaxHoldWidth;
    self.ctrlSnap.layer.mask.backgroundColor = [UIColor colorWithWhite:1 alpha:1].CGColor;
    self.ctrlSnap.hidden = YES;
}



@end
