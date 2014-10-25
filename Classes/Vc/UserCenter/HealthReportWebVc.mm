/**
 *
 *  HealthReportWebVc
 *  @author steven
 *  @date Sep 28 2014
 *
 **/

#import "HealthReportWebVc.h"

@implementation HealthReportWebVc



#pragma mark -
#pragma mark ------------------------------窗体----------------------------------
/*------------------------------------------------------------------------------
 |  窗体
 |
 -----------------------------------------------------------------------------*/
//窗体创建
- (void)onCreate {
    //顶部面板-----------
    [self changeTopTitle:@"详情"];
    [self hideTopRightBtn];
    
    //内容面板-----------
    UIWebView *v = [[UIWebView alloc] initWithFrame:self.contentPanel.bounds];
    [self.contentPanel addSubview:v];
    self.ctrlWebView = v;
    
    //底部面板-----------
    //其他--------------
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
    self.peMasterId = [params valueForKey:@"peMasterId"];
}

//解析导航返回
- (void)onPraseNavBackParams:(NSDictionary *)params {
}

//窗体将要显示------
- (void)onWillShow {
    [self loadData];
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



#pragma mark -
#pragma mark --------------------------获取和提交数据-----------------------------
/*------------------------------------------------------------------------------
 |  获取和提交数据
 |
 -----------------------------------------------------------------------------*/
- (void)loadData {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?peMasterId=%@", kAppHost, @"jsp/pemaster/MyReportDetail.jsp", self.peMasterId]]];
    [self.ctrlWebView loadRequest:request];
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
