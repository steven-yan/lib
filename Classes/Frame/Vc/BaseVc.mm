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
    self.view.backgroundColor = [UIColor colorWithHexStr:@"#f1f1f1"];
    
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
    [super viewWillDisappear:animated];
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
    } else {
        for (NSInteger i = a.count - 2; i >=0; i--) {
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
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
