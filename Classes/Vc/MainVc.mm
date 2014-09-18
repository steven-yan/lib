/**
 *
 *  MainVc
 *  @author steven
 *  @date   June 9 2014
 *
 **/

#import "MainVc.h"

@implementation MainVc



#pragma mark -
#pragma mark ------------------------------窗体----------------------------------
/*------------------------------------------------------------------------------
 |  窗体
 |
 -----------------------------------------------------------------------------*/
//窗体创建
- (void)onCreate {
    [super onCreate];
    //顶部面板-----------
    //左侧按键
    [self hideTopLeftBtn];
    //标题
    [self changeTopTitle:@"东方健康云"];
    //右侧按键
//    [self hideTopRightBtn];
    //内容面板-----------
    
    //底部面板-----------
    //其他--------------
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
    [self navTo:@"RegisterVc"];
}

- (void)topRightBtnClicked {
    [self navTo:@"LoginVc"];
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)btnClicked:(UIButton *)btn {
    NSInteger index = btn.tag;
    
    switch (index) {
        case 0:
            
            break;
            
        case 1:
            
            break;
            
        case 2:
            [self navTo:@"HealthyCheckCenterVc"];
            break;
            
        case 3:
            break;
            
        case 4:
            [self navTo:@"MyInfoVc"];
            break;
            
        default:
            break;
    }
}



@end
