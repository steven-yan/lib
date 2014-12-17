/**
 *
 *  SliderLeftPanel
 *  @author steven
 *  @date July 22 2014
 *
 **/

#import "SliderLeftPanel.h"

@implementation SliderLeftPanel
static int kDefaultContentWidth = 200;
static int kMaxVelocity = 500;
static float kDefaultAlpha = 0.5;



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithVc:(BaseVc *)vc contentWidth:(CGFloat)width {
    if (self = [super initWithFrame:vc.view.bounds]) {
        //页面
        self.nrVc = vc;
        //-
        self.hidden = YES;
        if (width < kDefaultContentWidth) {
            width = kDefaultContentWidth;
        }
        self.right = self.width - width;
        [vc.view addSubview:self];
        
        //控件-------------------
        //Ges
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        pan.delegate = self;
        [vc.view addGestureRecognizer:pan];
        //subView
        UIView *v = [[UIView alloc] initWithFrame:vc.view.bounds];
        v.width = self.width - width;
        v.left = width;
        [self addSubview:v];
        //ges
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [v addGestureRecognizer:tap];
        
        //数据-------------------
        self.contentWidth = width;
        
        //其他-------------------
    }
    
    return self;
}



#pragma mark -
#pragma mark ------------------------------方法----------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/
- (void)show {
    [UIView animateWithDuration:0.2 animations:^{
        [self showWithTag:YES];
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        [self showWithTag:YES];
    }];
}



#pragma mark -
#pragma mark -------------------UIGestureRecognizerDelegate---------------------
/*------------------------------------------------------------------------------
 |  UIGestureRecognizerDelegate
 |
 -----------------------------------------------------------------------------*/
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:self.nrVc.view];
    
    //容错
    if (self.left > 0 || point.x >= self.contentWidth) {
        return NO;
    }
    
    return YES;
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)handlePan:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateChanged) {
        [self touchMoved:pan];
    } else if (pan.state == UIGestureRecognizerStateCancelled ||
               pan.state == UIGestureRecognizerStateEnded ||
               pan.state == UIGestureRecognizerStateFailed) {
        [self touchEnd:pan];
    }
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    if (self.showTag) {
        [UIView animateWithDuration:0.3 animations:^{
            [self showWithTag:NO];
        }];
    }
}

- (void)touchMoved:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:self.nrVc.view];
    
    //容错
    if (self.left > 0 || point.x >= self.contentWidth || (self.showTag && point.x > 0) || (!self.showTag && point.x < 0)) {
        return;
    }
    
    //
    self.hidden = NO;
    self.nrVc.view.alpha =  1 - kDefaultAlpha + (ABS(self.left) / self.contentWidth) * kDefaultAlpha;
//    self.nrVc.view.layer.
    
    if (self.showTag) {
        self.left = point.x;
    } else {
        self.right = self.width - self.contentWidth +  point.x;
    }
}

- (void)touchEnd:(UIPanGestureRecognizer *)pan {
    CGPoint v = [pan velocityInView:self.nrVc.view];
    
    if (ABS(v.x) >= kMaxVelocity) {
        if (v.x > 0) {
            [UIView animateWithDuration:0.15 animations:^{
                [self showWithTag:YES];
            }];
        } else {
            [UIView animateWithDuration:0.15 animations:^{
                [self showWithTag:NO];
            } completion:^(BOOL finished) {
                self.hidden = YES;
            }];
        }
        
        return;
    }
    
    if (self.right - (self.width - self.contentWidth) > self.contentWidth / 2) {
        [UIView animateWithDuration:0.2 animations:^{
            [self showWithTag:YES];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            [self showWithTag:NO];
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    }
}

- (void)showWithTag:(BOOL)showTag {
    if (showTag) {
        self.left = 0;
        self.nrVc.view.alpha = kDefaultAlpha;
        self.showTag = YES;
    } else {
        self.right = 0;
        self.nrVc.view.alpha = 1;
        self.showTag = NO;
    }
}



@end
