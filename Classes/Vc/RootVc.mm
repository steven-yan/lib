/**
 *
 *  RootVc
 *  @author steven
 *  @date July 10 2014
 *
 **/

#import "RootVc.h"

@implementation RootVc



#pragma mark -
#pragma mark ------------------------------窗体----------------------------------
/*------------------------------------------------------------------------------
 |  窗体
 |
 -----------------------------------------------------------------------------*/
//窗体创建
- (void)onCreate {
    //顶部面板-----------
    [self hideTopLeftBtn];
    [self hideTopRightBtn];
    //内容面板-----------
    TabBarBottomPanel *tb = [[TabBarBottomPanel alloc] initWithVc:self];
    [tb setImgList:@[@"btn_air_hospital_normal", @"btn_user_center_normal", @"btn_user_center_normal"] selectedImgList:@[@"btn_air_hospital_selected", @"btn_user_center_selected",  @"btn_user_center_selected"] titleList:@[@"体检中心", @"专家推荐", @"个人中心"]];
    RootHealthCenter *hc = [[RootHealthCenter alloc] initWithVc:self];
    RootExpertRmd *rc = [[RootExpertRmd alloc] initWithVc:self];
    RootUserCenter *uc = [[RootUserCenter alloc] initWithVc:self];
    [tb setContentPanel:@[hc, rc, uc]];
    tb.delegate = self;
    tb.bottom = self.contentPanel.height;
    [self.contentPanel addSubview:tb];
    self.ctrlTabBar = tb;
    
    //其他--------------
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
}

//解析导航返回
- (void)onPraseNavBackParams:(NSDictionary *)params {
}

//窗体将要显示
- (void)onWillShow {
}

//窗体显示
- (void)onShow {
}

//隐藏
- (void)onWillHide {
}

//导航栏
- (void)topLeftBtnClicked {
    [self navBack];
}

- (void)topRightBtnClicked {
}



#pragma mark -
#pragma mark -------------------------------tabBar---------------------------------
/*------------------------------------------------------------------------------
 |  tabBar
 |
 -----------------------------------------------------------------------------*/
- (void)tabBarBottomPanelClicked:(TabBarBottomPanel *)tabBar index:(NSInteger)index {
    
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
