/**
 *
 * @author steven.yan
 *
 */
#import "BaseLayoutVc.h"

@implementation BaseLayoutVc



/*------------------------------------------------------------------------------
|  页面
|
 ------------------------------------------------------------------------------*/
- (void)_onCreateBegin {
    //控件--------
    //顶部面板------
    //margin view
    UIView *topMarginView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, [SysInfo instance].topMarginHeight)];
    topMarginView.backgroundColor = [UIColor colorWithHexStr:@"#d0efa5"];
    [self.view addSubview:topMarginView];
    //top panel
    TopPanel *tp = [[TopPanel alloc] init];
    tp.delegate = self;
    self.topPanel = tp;
    [self.view addSubview:tp];
    
    //内容面板------
    UIView *cv = [[UIView alloc] initWithFrame:CGRectMake(0, self.topPanel.bottom, self.view.width, [SysInfo instance].contentHeight)];
    [self.view addSubview:cv];
    self.contentPanel = cv;
    
    //其他--------
    //hud----
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.contentPanel];
    [self.contentPanel addSubview:hud];
    self.ctrlHud = hud;
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
#pragma mark ------------------------------HUD----------------------------------
/*------------------------------------------------------------------------------
 |  HUD
 |
 -----------------------------------------------------------------------------*/
//msg------
- (void)showHudLoading {
    [self showHudWithMsg:@"加载中..."];
}

- (void)showHudWithMsg:(NSString *)msg {
    //view正中心偏移
    float offset = (self.view.height - self.contentPanel.height) / 2;
    
    //防止hint已经显示
    [self dismissHud];
    
    self.ctrlHud.margin = 10.f;
	self.ctrlHud.yOffset = -offset;
    self.ctrlHud.labelFont = [UIFont systemFontOfSize:16];
    self.ctrlHud.labelText = msg;
    [self.ctrlHud show:YES];
}

- (void)dismissHud {
    [self.ctrlHud hide:YES];
}

//toast------
- (void)showHudWithHint:(NSString *)hint {
//    [OMGToast showWithText:hint duration:1.0];
}

- (void)showHudWithBottomHint:(NSString *)hint {
//    [OMGToast showWithText:hint bottomOffset:60 duration:1.0];
}

- (void)showHudWithHint:(NSString *)hint yoffset:(float)yoffset {
//    [OMGToast showWithText:hint topOffset:yoffset duration:1.0];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
