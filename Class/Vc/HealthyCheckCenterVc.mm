/**
 *
 *  HealthyCheckCenterVc
 *  @author steven
 *  @date July 26 2014
 *
 **/

#import "HealthyCheckCenterVc.h"

@implementation HealthyCheckCenterVc



#pragma mark -
#pragma mark ------------------------------窗体----------------------------------
/*------------------------------------------------------------------------------
 |  窗体
 |
 -----------------------------------------------------------------------------*/
//窗体创建
- (void)onCreate {
    //顶部面板-----------
    [self changeTopTitle:@"体检中心"];
    //内容面板-----------
    
    //底部面板-----------
    //其他--------------
    //refresh panel
    [self hideDropPanel];
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
}

//解析导航返回
- (void)onPraseNavBackParams:(NSDictionary *)params {
}

//窗体将要显示------
- (void)onWillShow {
}

//窗体显示
- (void)onShow {
}

//隐藏------
- (void)onWillHide {
}

//导航栏------
- (void)topLeftBtnClicked {
    [self navBack];
}

- (void)topRightBtnClicked {
}

//dropPanel
- (void)dropPanelWhileLoading {
    [self dropPanelFinisnLoading];
}

- (void)risePanelWhileLoading {
}


#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
