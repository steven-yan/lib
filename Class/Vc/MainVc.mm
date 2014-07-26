/**
 *
 *  TemplateVC 页面模板
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
//    [self hideTopLeftBtn];
    //标题
    [self changeTopTitle:@"东方健康云"];
    //右侧按键
//    [self hideTopRightBtn];
    //内容面板-----------
    //按钮
    UIButton *btn0 = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 115, 130)];
    btn0.tag = 0;
    [btn0 setBgImg:@"main_0"];
    [self.contentPanel addSubview:btn0];
    [btn0 addTarget:self action:@selector(btnClicked:)];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 115, 130)];
    btn1.left = btn0.right + 10;
    btn1.tag = 1;
    [btn1 setBgImg:@"main_1"];
    [self.contentPanel addSubview:btn1];
    [btn1 addTarget:self action:@selector(btnClicked:)];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 115, 130)];
    btn2.top = btn0.bottom + 20;
    btn2.tag = 2;
    [btn2 setBgImg:@"main_2"];
    [self.contentPanel addSubview:btn2];
    [btn2 addTarget:self action:@selector(btnClicked:)];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 115, 130)];
    btn3.left = btn1.left;
    btn3.top = btn2.top;
    btn3.tag = 3;
    [btn3 setBgImg:@"main_3"];
    [self.contentPanel addSubview:btn3];
    [btn3 addTarget:self action:@selector(btnClicked:)];

    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    btn4.top = btn3.bottom + 20;
    btn4.centerX = btn3.centerX;
    btn4.tag = 4;
    [btn4 setTitle:@"个人信息"];
    [btn4 addTarget:self action:@selector(btnClicked:)];
    [self.contentPanel addSubview:btn4];
    
    //背景
    [self.contentPanel setBgColorWithImage:@"main_bg"];
    
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
    int index = btn.tag;
    
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
