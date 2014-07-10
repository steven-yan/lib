/**
 *
 * @author steven.yan
 *
 */
#import "BaseVC.h"

@implementation BaseVC



/*------------------------------------------------------------------------------
|  页面
|
 ------------------------------------------------------------------------------*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //页面--------------
    //背景--------
    self.view.backgroundColor = [UIColor colorWithHexStr:@"#efefef"];
    //控件--------
    //顶部面板------
    TopPanel *tp = [[TopPanel alloc] init];
    tp.delegate = self;
    self.topPanel = tp;
    [self.view addSubview:tp];
    
    //内容面板------
    int h = [SysInfo instance].contentHeight;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, self.topPanel.bottom, self.view.width, h)];
    [self.view addSubview:v];
    self.contentPanel = v;
    
    //覆盖方法
    [self onCreateBegin];
    [self onCreate];
    
    //其他------
    //hud----
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.contentPanel];
    [self.contentPanel addSubview:hud];
    self.ctrlHud = hud;
}
- (void) onCreateBegin {
}
- (void) onCreate {
}

//viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    //清理数据
    [self onCleanData];
    
    if (self._navToTag) {
        //解析导航前进参数
        [self onPraseNavToParams:self._tmpNavToParams];
        //清空参数
        self._tmpNavToParams = nil;
    } else if (self._navBackTag) {
        //解析导航返回参数
        [self onPraseNavBackParams:self._tmpNavBackParams];
        //清空参数
        self._tmpNavBackParams = nil;
    }
    
    //覆盖方法
    [self onWillShow];
}
- (void)onCleanData {
}
- (void)onPraseNavToParams:(NSMutableDictionary *)params {
}
- (void)onPraseNavBackParams:(NSMutableDictionary *)params {
}
- (void)onWillShow {
}

// viewDidAppear
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self onShow];
}
- (void)onShow {
}

// viewWillDisappear
- (void)viewWillDisappear:(BOOL)animated {
    [self onWillHide];
}
- (void)onWillHide {
}

// viewDidDisappear
- (void)viewDidDisappear:(BOOL)animated {
    [self onDidHide];

    [super viewDidDisappear:animated];
}
- (void)onDidHide {
    //清空标记
    self._navToTag = NO;
    self._navBackTag = NO;
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
#pragma mark ------------------------------导航----------------------------------
/*------------------------------------------------------------------------------
|  导航
|
 ------------------------------------------------------------------------------*/
//页面导航进入
- (void)navTo:(NSString *)vcKey {
    [self navTo:vcKey params:nil];
}
- (void)navTo:(NSString *)vcKey style:(NavStyle)style {
    [self navTo:vcKey params:nil style:style];
}
- (void)navTo:(NSString *)vcKey params:(NSMutableDictionary *)params {
    [self navTo:vcKey params:params style:NavStyleDefault];
}
- (void)navTo:(NSString *)vcKey params:(NSMutableDictionary *)params style:(NavStyle)style {
    BaseVC *rvc = [[NSClassFromString(vcKey) alloc] init];
    
    NSArray *a = self.navigationController.viewControllers;
    if (a.count == 1) {
        //隐藏tabbar
        rvc.hidesBottomBarWhenPushed = YES;
    }
    
    //设置导航标识
    rvc._navToTag = YES;
    //设置导航参数
    rvc._tmpNavToParams = params;
    
    //导航切换-----------------------
    if (style != NavStyleDefault) {
        if (style!=NavStyleNoEffect) {
            CATransition *transition = [CATransition animation];
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            if (style==NavStyleBottomToTop) {
                transition.duration = 0.4f;
                transition.type = kCATransitionMoveIn;
                transition.subtype = kCATransitionFromTop;
            } else if (style==NavStyleFadeIn) {
                transition.duration = 0.2f;
                transition.type = kCATransitionFade;
            }
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
        }
        [self.navigationController pushViewController:rvc animated:NO];
    } else {
        [self.navigationController pushViewController:rvc animated:YES];
    }
}

//页面导航返回
- (void)navBack {
    [self navBackWithStyle:NavStyleDefault];
}
- (void)navBackWithStyle:(NavStyle)style {
    [self navBackTo:nil style:style];
}
- (void)navBackWithParams:(NSMutableDictionary *)params {
    [self navBackTo:nil params:params];
}
- (void)navBackWithParams:(NSMutableDictionary *)params style:(NavStyle)style {
    [self navBackTo:nil params:params style:style];
}
- (void)navBackTo:(NSString *)vcKey {
    [self navBackTo:vcKey params:nil style:NavStyleDefault];
}
- (void)navBackTo:(NSString *)vcKey style:(NavStyle)style {
    [self navBackTo:vcKey params:nil style:style];
}
- (void)navBackTo:(NSString *)vcKey params:(NSMutableDictionary *)params {
    [self navBackTo:vcKey params:params style:NavStyleDefault];
}
- (void)navBackTo:(NSString *)vcKey params:(NSMutableDictionary *)params style:(NavStyle)style {
    BOOL flag = NO;
    BaseVC *rvc = nil;
    NSArray *a = self.navigationController.viewControllers;
    
    //容错
    if (a.count <= 1) {
        return;
    }
    
    if (vcKey == nil) {
        //返回上一个页面
        rvc = [a objectAtIndex:a.count - 2];
        flag = YES;
    } else {
        for (int i = a.count - 2; i >=0; i--) {
            //遍历页面
            rvc = [a objectAtIndex:i];
            if ([rvc isKindOfClass:NSClassFromString(vcKey)]) {
                flag = YES;
                break;
            }
        }
    }
    
    //页面不存在
    if (flag == NO) {
        return;
    }
    
    //设置导航标识
    rvc._navBackTag = YES;
    
    //设置导航参数
    rvc._tmpNavBackParams = params;
    
    if (style != NavStyleDefault) {
        if (style!=NavStyleNoEffect) {
            CATransition *transition = [CATransition animation];
            transition.delegate = self;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            if (style==NavStyleFadeOut) {
                transition.duration = 0.2f;
                transition.type = kCATransitionFade;
            } else if (style==NavStyleTopToBottom) {
                transition.duration = 0.4f;
                transition.type = kCATransitionReveal;
                transition.subtype = kCATransitionFromBottom;
            }
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
        }
        [self.navigationController popToViewController:rvc animated:NO ];
    } else {
        [self.navigationController popToViewController:rvc animated:YES];
    }
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
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
