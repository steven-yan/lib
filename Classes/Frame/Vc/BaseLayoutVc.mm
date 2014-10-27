/**
 *
 * @author steven.yan
 *
 */
#import "BaseLayoutVc.h"

@implementation BaseLayoutVc
static int kHintContentOffset = 60;



/*------------------------------------------------------------------------------
|  页面
|
 ------------------------------------------------------------------------------*/
- (void)_onCreateBegin {
    [super _onCreateBegin];
    
    //控件--------
    //顶部面板------
    //margin view
    UIView *topMarginView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, [SysInfo instance].topMarginHeight)];
    topMarginView.backgroundColor = [UIColor generalColor];
    [self.view addSubview:topMarginView];
    //top panel
    TopPanel *tp = [[TopPanel alloc] init];
    tp.delegate = self;
    self.topPanel = tp;
    [self.view addSubview:tp];
    
    //内容面板------
    UIScrollView *cp = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topPanel.bottom, self.view.width, [SysInfo instance].contentHeight)];
    [self.view addSubview:cp];
    self.contentPanel = cp;
    
    //数据加载提示------
    //load bg------
    UIView *hintBg = [[UIView alloc] initWithFrame:self.contentPanel.frame];
    [self.view addSubview:hintBg];
    hintBg.hidden = YES;
    self.ctrlLoading = hintBg;
    //label
    UILabel *l = [UILabel labelWithLeft:14 Top:0 Width:70 Height:20 FontSize:14];
    l.text = @"加载中...";
    l.textColor = [UIColor colorWithHexStr:@"#8e8e8e"];
    l.textAlignment = NSTextAlignmentRight;
    l.centerX = hintBg.width / 2 - 30;
    l.centerY = hintBg.height / 2 - kHintContentOffset;
    [hintBg addSubview:l];
    //indicator
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.centerX = hintBg.width / 2 + 25;
    indicator.centerY = hintBg.height / 2 - kHintContentOffset;
    [hintBg addSubview:indicator];
    self.ctrlIndicator = indicator;
    //error bg----
    hintBg = [[UIView alloc] initWithFrame:hintBg.frame];
    [self.view addSubview:hintBg];
    hintBg.hidden = YES;
    self.ctrlLoadError = hintBg;
    //加载失败按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 14)];
    [btn addTarget:self action:@selector(btnClicked:)];
    [btn setTitle:@"加载失败,点击重新加载"];
    [btn setTitleColor:[UIColor colorWithHexStr:@"#8e8e8e"]];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.centerX = hintBg.width / 2;
    btn.centerY = hintBg.height / 2 - kHintContentOffset;
    [hintBg addSubview:btn];
    self.ctrlLoadError = hintBg;
    
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
- (void)showLoading {
    self.contentPanel.hidden = YES;
    self.ctrlLoading.hidden = NO;
    self.ctrlLoadError.hidden = YES;
    [self.ctrlIndicator startAnimating];
}

- (void)hideLoading {
    self.contentPanel.hidden = NO;
    self.ctrlLoading.hidden = YES;
    self.ctrlLoadError.hidden = YES;
    [self.ctrlIndicator stopAnimating];
}

- (void)showLoadError {
    self.contentPanel.hidden = YES;
    self.ctrlLoading.hidden = YES;
    self.ctrlLoadError.hidden = NO;
}

- (void)btnClicked:(UIButton *)btn {
    [self loadData];
}

- (void)loadData {
}



#pragma mark -
#pragma mark -----------------------http hint-----------------------------------
/*------------------------------------------------------------------------------
 |  toast
 |
 -----------------------------------------------------------------------------*/
- (void)onHttpRequestFailed:(EnHttpRequestFailed)err hint:(NSString *)hint {
    [self showToast:hint];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
//toast
- (void)showToast:(NSString *)text {
    [Toast.instance show:text];
}



@end
