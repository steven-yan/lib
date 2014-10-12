/**
 *
 *  CounselInfoVc
 *  @author steven
 *  @date Oct 7 2014
 *
 **/

#import "CounselInfoListVc.h"

@implementation CounselInfoListVc



#pragma mark -
#pragma mark ------------------------------窗体----------------------------------
/*------------------------------------------------------------------------------
 |  窗体
 |
 -----------------------------------------------------------------------------*/
//窗体创建
- (void)onCreate {
    //顶部面板-----------
    [self changeTopTitle:@"信息咨询"];
    [self changeTopRightBtnTitle:@"咨询"];
    //内容面板-----------
    
    //咨询面板
    CounselInfoPanel *ci = [[CounselInfoPanel alloc] initWithVc:self];
    [self.contentPanel addSubview:ci];
    self.ctrlCounselPanel = ci;
    
    //底部面板-----------
    //数据--------------
    self.arrayOfCellData = [[NSMutableArray alloc] init];
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
    //获取历史咨询信息
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
    //打开咨询面板
    [self.ctrlCounselPanel show];
}



#pragma mark -
#pragma mark --------------------------获取和提交数据-----------------------------
/*------------------------------------------------------------------------------
 |  获取和提交数据
 |
 -----------------------------------------------------------------------------*/
- (void)loadData {
    [self httpGet:[AppUtil healthUrl:@"userlogin.UserLoginPRC.getInquiryList.submit"]];
}

- (void)onHttpRequestSuccessObj:(NSDictionary *)obj {
    [self.arrayOfCellData removeAllObjects];
    NSArray *list = [obj valueForKey:@"list"];
    [self.arrayOfCellData addObjectsFromArray:list];
    
    [self.tableView reloadData];
}

//完善参数
- (void)completeQueryParams {
    [self.queryParams setValue:Global.instance.userInfo.userLoginId forKey:@"userLoginId"];
}



#pragma mark -
#pragma mark ---------------------------tableView-------------------------------
/*------------------------------------------------------------------------------
 |  tableView
 |
 -----------------------------------------------------------------------------*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfCellData.count;
}

- (void) createCell:(UITableViewCell *)cell {
    CounselInfoCell *c = [[CounselInfoCell alloc] initWithVc:self];
    c.tag = 100;
    [cell addSubview:c];
}

- (void)makeCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    //容错
    if (row >= self.arrayOfCellData.count) {
        return;
    }
    
    CounselInfoCell *c = (CounselInfoCell *)[cell viewWithTag:100];
    NSDictionary *dic = [self.arrayOfCellData objectAtIndex:row];
    [c refreshWithContent:[dic valueForKey:@"content"] msgId:[dic valueForKey:@"messageId"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //容错
    [self navTo:@"CounselInfoDetailVc"];
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
