/**
 *
 *  Toast
 *  @author steven.yan
 *  @date Otc 25 2014
 *
 **/

#import "Toast.h"

@implementation Toast
static int kToastFontSize = 14;



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
+(instancetype)instance {
    static Toast *toast = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        toast = [[self alloc] init];
    });
    
    return toast;
}

//初始化
-(instancetype)init {
    if (self = [super init]) {
        //toast------
        //bg
        UIView *toast = [[UIView alloc] init];
        toast.layer.cornerRadius = 5.0f;
        toast.layer.borderWidth = 1.0f;
        toast.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
        toast.backgroundColor = [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:0.75f];
        //add to key window
        UIWindow *win = [UIApplication sharedApplication].keyWindow;
        [win addSubview:toast];
        self.ctrlToastBg = toast;
        //l
        UILabel *l = [UILabel labelWithLeft:0 Top:0 Width:SysInfo.instance.fullWidth - 60 Height:0 FontSize:kToastFontSize];
        l.numberOfLines = 0;
        l.textAlignment = NSTextAlignmentCenter;
        l.textColor = [UIColor whiteColor];
        [toast addSubview:l];
        self.ctrlToastHint = l;
    }
    
    return self;
}



#pragma mark -
#pragma mark ------------------------------方法----------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/
//show
- (void)show:(NSString *)text {
    CGSize size = [self.ctrlToastHint setDynamicWithStr:text fontSize:kToastFontSize];
    self.ctrlToastBg.width = size.width + 12;
    self.ctrlToastBg.height = size.height + 12;
    self.ctrlToastBg.centerX = SysInfo.instance.fullWidth / 2;
    self.ctrlToastBg.bottom = SysInfo.instance.bounds.size.height - 60;
    
    self.ctrlToastHint.centerX = self.ctrlToastBg.width / 2;
    self.ctrlToastHint.centerY = self.ctrlToastBg.height / 2;
    [self showAnimationToast];
    [self performSelector:@selector(hideToast:) withObject:nil afterDelay:2];
    [self.ctrlToastBg bringToFont];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
//hide toast
- (void)hideToast:(id)toast {
    [self hideAnimationToast];
}

- (void)showAnimationToast {
    self.ctrlToastBg.alpha = 0;
    [UIView beginAnimations:@"showAnimationToast" context:nil];
    self.ctrlToastBg.alpha = 1.0f;
    [UIView setAnimationDelay:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView commitAnimations];
}

- (void)hideAnimationToast {
    [UIView beginAnimations:@"showAnimationToast" context:nil];
    self.ctrlToastBg.alpha = 0;
    [UIView setAnimationDelay:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView commitAnimations];
}



@end
