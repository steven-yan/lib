/**
 *
 *  CounselInfoDetailVc
 *  @author steven
 *  @date Otc 7 2014
 *
 **/

#import "CounselInfoDetailVc.h"

@implementation CounselInfoDetailVc



#pragma mark -
#pragma mark ------------------------------窗体----------------------------------
/*------------------------------------------------------------------------------
 |  窗体
 |
 -----------------------------------------------------------------------------*/
//窗体创建
- (void)onCreate {
    //顶部面板-----------
    [self changeTopTitle:@"咨询详情"];
    [self hideTopRightBtn];
    
    //内容面板-----------
    UILabel *l = [UILabel labelWithLeft:10 Top:10 Width:self.contentPanel.width Height:20 FontSize:14];
    l.numberOfLines = 0;
    [self.contentPanel addSubview:l];
    self.ctrlLabel = l;
    
    //底部面板-----------
    //其他--------------
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
    self.messageId = [params valueForKey:@"messageId"];
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
    [self httpGet:[AppUtil healthUrl:@"userlogin.UserLoginPRC.getInquiryDetail.submit"]];
}

- (void)onHttpRequestSuccessObj:(NSDictionary *)obj {
    NSArray *list = [obj valueForKey:@"list"];
    NSDictionary *dic = [list objectAtIndex:0];
    [self.ctrlLabel setDynamicWithStr:[NSString stringWithFormat:@"时间:  %@\n\n%@", [dic valueForKey:@"sendTime"], [dic valueForKey:@"content"]] fontSize:14];
}

//完善参数
- (void)completeQueryParams {
    [self.queryParams setValue:self.messageId forKey:@"messageId"];
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
