/**
 *
 * @author steven.yan
 *
 */
#import "BaseLayoutVc.h"

@implementation BaseLayoutVc
static int kToastFontSize = 14;


/*------------------------------------------------------------------------------
|  页面
|
 ------------------------------------------------------------------------------*/
- (void)_onCreateBegin {
    //控件--------
    //顶部面板------
    //margin view
    UIView *topMarginView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, [SysInfo instance].topMarginHeight)];
    topMarginView.backgroundColor = [UIColor colorWithHexStr:kGeneralColor];
    [self.view addSubview:topMarginView];
    //top panel
    TopPanel *tp = [[TopPanel alloc] init];
    tp.delegate = self;
    self.topPanel = tp;
    [self.view addSubview:tp];
    
    //内容面板------
    UIView *cp = [[UIView alloc] initWithFrame:CGRectMake(0, self.topPanel.bottom, self.view.width, [SysInfo instance].contentHeight)];
    [self.view addSubview:cp];
    self.contentPanel = cp;
    
    //数据加载提示------
    //bg
    UIView *hintBg = [[UIView alloc] initWithFrame:self.contentPanel.bounds];
    [self.view addSubview:hintBg];
    hintBg.hidden = YES;
    self.ctrlLoading = hintBg;
    //label
    UILabel *l = [UILabel labelWithLeft:14 Top:0 Width:70 Height:20 FontSize:16];
    l.text = @"加载中...";
    l.textColor = [UIColor colorWithHexStr:@"#8e8e8e"];
    l.textAlignment = NSTextAlignmentCenter;
    l.centerX = hintBg.width / 2;
    l.centerY = hintBg.height / 2 - 30;
    [hintBg addSubview:l];
    //indicator
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.centerX = hintBg.width / 2;
    indicator.centerY = hintBg.height / 2;
    [hintBg addSubview:indicator];
    self.ctrlIndicator = indicator;
    
    //toast------
    //bg
    UIView *toast = [[UIView alloc] init];
    toast.layer.cornerRadius = 5.0f;
    toast.layer.borderWidth = 1.0f;
    toast.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
    toast.backgroundColor = [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:0.75f];
    [self.contentPanel addSubview:toast];
    self.ctrlToastBg = toast;
    //l
    l = [UILabel labelWithLeft:0 Top:0 Width:self.contentPanel.width - 60 Height:0 FontSize:kToastFontSize];
    l.numberOfLines = 0;
    l.textAlignment = NSTextAlignmentCenter;
    l.textColor = [UIColor whiteColor];
    [toast addSubview:l];
    self.ctrlToastHint = l;
    
    //数据-----------
}



#pragma mark -
#pragma mark ------------------------------顶部面板----------------------------------
/*------------------------------------------------------------------------------
 |  顶部面板
 |
 ------------------------------------------------------------------------------*/
- (void)hideTopPanel {
    if (self.topPanel.hidden == NO) {
        //调整内容面板
        self.contentPanel.height = self.contentPanel.height + self.topPanel.height;
        self.contentPanel.top = self.topPanel.top;
        //隐藏
        self.topPanel.hidden = YES;
    }
}

- (void)showTopPanel {
    if (self.topPanel.hidden == YES) {
        //调整内容面板
        self.contentPanel.height = [SysInfo instance].contentHeight;
        self.contentPanel.top = self.topPanel.bottom;
        //显示
        self.topPanel.hidden = NO;
        [self.topPanel bringToFont];
    }
}

//左侧按键--------
- (void)hideTopLeftBtn {
    self.topPanel.ctrlLeftBtn.hidden = YES;
}
- (void)showTopLeftBtn {
    self.topPanel.ctrlLeftBtn.hidden = NO;
}
- (void)changeTopLeftBtnTitle:(NSString *)title {
    [self.topPanel changeLeftBtnWithTitle:title];
}
-(void)onTopPanelLeftBtnClicked {
    [self topLeftBtnClicked];
}
- (void)topLeftBtnClicked {
}

//标题栏--------
- (void)changeTopTitle:(NSString *)str {
    [self.topPanel changeTitle:str];
}

//右侧按键--------
- (void)hideTopRightBtn {
    self.topPanel.ctrlRightBtn.hidden = YES;
}
- (void)showTopRightBtn {
    self.topPanel.ctrlRightBtn.hidden = NO;
}
- (void)changeTopRightBtnTitle:(NSString *)title {
    [self.topPanel changeRightBtnWithTitle:title];
}
-(void)onTopPanelRightBtnClicked {
    [self topRightBtnClicked];
}
- (void)topRightBtnClicked {
}


#pragma mark -
#pragma mark ----------------------------Loading--------------------------------
/*------------------------------------------------------------------------------
 |  Loading
 |
 -----------------------------------------------------------------------------*/
- (void)startLoading {
    //隐藏
    self.contentPanel.hidden = YES;
    self.ctrlLoading.hidden = NO;
    [self.ctrlIndicator startAnimating];
}

- (void)stopLoading {
    //显示
    self.contentPanel.hidden = NO;
    self.ctrlLoading.hidden = YES;
    [self.ctrlIndicator stopAnimating];
}



#pragma mark -
#pragma mark ----------------------------toast----------------------------------
/*------------------------------------------------------------------------------
 |  toast
 |
 -----------------------------------------------------------------------------*/
//show toast
- (void)showToast:(NSString *)text {
    [self.ctrlToastBg bringToFont];
    CGSize size = [self.ctrlToastHint setDynamicWithStr:text fontSize:kToastFontSize];
    self.ctrlToastBg.width = size.width + 12;
    self.ctrlToastBg.height = size.height + 12;
    self.ctrlToastBg.centerX = self.contentPanel.width / 2;
    self.ctrlToastBg.bottom = self.contentPanel.height - 60;
    
    self.ctrlToastHint.centerX = self.ctrlToastBg.width / 2;
    self.ctrlToastHint.centerY = self.ctrlToastBg.height / 2;
    [self showAnimationToast];
    [self performSelector:@selector(hideToast:) withObject:nil afterDelay:2];
}

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

#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
