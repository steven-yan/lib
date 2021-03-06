/**
 *
 * @author steven.yan
 *
 */
#import "BaseVc.h"

@implementation BaseVc



/*------------------------------------------------------------------------------
|  页面
|
 ------------------------------------------------------------------------------*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //页面--------------
    //背景--------
    self.view.backgroundColor = [UIColor whiteColor];
    
    //覆盖方法
    [self _onCreateBegin];
    [self onCreate];
    [self _onCreateEnd];
    
    //数据-----------
    //其他------
}
- (void) _onCreateBegin {
}
- (void) onCreate {
}
- (void)_onCreateEnd {
}

//viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    //清理数据
    [self onCleanData];
    
    //导航前进------
    if (self._navToTag) {
        //解析导航前进参数
        [self onPraseNavToParams:self._tmpNavToParams];
        //清空参数
        self._tmpNavToParams = nil;
        
        //覆盖方法
        [self onWillShow];
    }
    
    //导航返回------
    if (self._navBackTag) {
        //解析导航返回参数
        [self onPraseNavBackParams:self._tmpNavBackParams];
        //清空参数
        self._tmpNavBackParams = nil;
    }
}
- (void)onCleanData {
}
- (void)onPraseNavToParams:(NSDictionary *)params {
}
- (void)onPraseNavBackParams:(NSDictionary *)params {
}
- (void)onWillShow {
}

// viewDidAppear
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self onShow];
    //保存图片----
    self._swipeBackTag = YES;
    [self savePic];
}
- (void)onShow {
}

// viewWillDisappear
- (void)viewWillDisappear:(BOOL)animated {
    [self onWillHide];
    [super viewWillDisappear:animated];
}
- (void)onWillHide {
    //清空标记
    self._navToTag = NO;
    self._navBackTag = NO;
    self._swipeBackTag = NO;
}

// viewDidDisappear
- (void)viewDidDisappear:(BOOL)animated {
    [self onDidHide];
    [super viewDidDisappear:animated];
}
- (void)onDidHide{
    //清空标记
    self._navToTag = NO;
    self._navBackTag = NO;
}

//释放
- (void)dealloc {
    [self onClose];
}
- (void)onClose {
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
- (void)navTo:(NSString *)vcKey params:(NSDictionary *)params {
    [self navTo:vcKey params:params style:NavStyleDefault];
}
- (void)navTo:(NSString *)vcKey params:(NSDictionary *)params style:(NavStyle)style {
    BaseVc *rvc = [[NSClassFromString(vcKey) alloc] init];
    
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
- (void)navBackSwipe {
    [self navBackSwipeWithParams:nil];
}
- (void)navBackSwipeWithParams:(NSDictionary *)params {
    [self navBackTo:nil params:params style:NavStyleNoEffect];
}
- (void)navBackWithParams:(NSDictionary *)params {
    [self navBackTo:nil params:params];
}
- (void)navBackWithParams:(NSDictionary *)params style:(NavStyle)style {
    [self navBackTo:nil params:params style:style];
}
- (void)navBackTo:(NSString *)vcKey {
    [self navBackTo:vcKey params:nil style:NavStyleDefault];
}
- (void)navBackTo:(NSString *)vcKey style:(NavStyle)style {
    [self navBackTo:vcKey params:nil style:style];
}
- (void)navBackTo:(NSString *)vcKey params:(NSDictionary *)params {
    [self navBackTo:vcKey params:params style:NavStyleDefault];
}
- (void)navBackTo:(NSString *)vcKey params:(NSDictionary *)params style:(NavStyle)style {
    BOOL flag = NO;
    BaseVc *rvc = nil;
    NSArray *a = self.navigationController.viewControllers;
    
    //容错
    if (a.count <= 1) {
        return;
    }
    
    if (vcKey == nil) {
        //返回上一个页面
        rvc = [a objectAtIndex:a.count - 2];
        flag = YES;
        //清空图片
        if ([self canSwipeBack]) {
            NavVc *nav = (NavVc *)self.navigationController;
            [nav cleanVcPic:self];
        }
    } else {
        for (NSInteger i = a.count - 2; i >=0; i--) {
            //遍历页面
            rvc = [a objectAtIndex:i];
            if ([rvc isKindOfClass:NSClassFromString(vcKey)]) {
                flag = YES;
                break;
            }
            
            //清空图片
            if ([[a objectAtIndex:i+1] canSwipeBack]) {
                NavVc *nav = (NavVc *)self.navigationController;
                [nav cleanVcPic:rvc];
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
#pragma mark ------------------------------SwipeBack----------------------------------
/*------------------------------------------------------------------------------
 |  SwipeBack
 |
 -----------------------------------------------------------------------------*/
- (void)onSwipeBack {
    if (self._swipeBackTag) {
        [self navBackSwipe];
    }
}
- (BOOL)canSwipeBack {
    return self._swipeBackTag && [self supportSwipeBack];
}
- (BOOL)supportSwipeBack {
    return YES;
}



#pragma mark -
#pragma mark ------------------------------alert----------------------------------
/*------------------------------------------------------------------------------
 |  alert
 |
 -----------------------------------------------------------------------------*/
- (void)alert:(NSString *)msg {
    [self alert:msg tag:0];
}
- (void)alert:(NSString *)msg tag:(NSInteger)tag {
    [self alertWithTitle:@"提示" msg:msg tag:tag];
}
- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg {
    [self alertWithTitle:title msg:msg tag:0];
}
- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg tag:(NSInteger)tag {
    [self alertWithTitle:title cancel:@"取消" msg:msg tag:tag];
}
- (void)alertWithTitle:(NSString *)title cancel:(NSString *)cancel msg:(NSString *)msg tag:(NSInteger)tag {
    [self alertWithTitle:title cancel:cancel msg:msg cmfTitle:@"确认" tag:tag];
}
- (void)alertWithTitle:(NSString *)title cancel:(NSString *)cancel msg:(NSString *)msg cmfTitle:(NSString *)cmfTitle tag:(NSInteger)tag {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancel otherButtonTitles:cmfTitle, nil];
    alert.tag = tag;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self alertView:alertView dismissWithBtnIndex:buttonIndex tag:alertView.tag];
    [self alertView:alertView dismissWithBtnIndex:buttonIndex];
    if (buttonIndex == 1) {
        [self confirmAlert:alertView tag:alertView.tag];
        [self confirmAlert:alertView];
    }
}

- (void)alertView:(UIAlertView *)alertView dismissWithBtnIndex:(NSInteger)index tag:(NSInteger)tag {
}
- (void)alertView:(UIAlertView *)alertView dismissWithBtnIndex:(NSInteger)index {
}
- (void)confirmAlert:(UIAlertView *)alertView tag:(NSInteger)tag {
}
- (void)confirmAlert:(UIAlertView *)alertView {
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)savePic {
    NSArray *list = self.navigationController.viewControllers;
    //保存图片
    if ([self canSwipeBack] && list.count > 1) {
        NavVc *nav = (NavVc *)self.navigationController;
        BaseVc *vc = [self.navigationController.viewControllers objectAtIndex:list.count - 2];
        [nav setVcPic:self view:vc.view];
    }
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
