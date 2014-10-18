/**
 *
 *  HealthReportListVc
 *  @author steven
 *  @date Sep 28 2014
 *
 **/

#import "HealthReportListVc.h"

@implementation HealthReportListVc



#pragma mark -
#pragma mark ------------------------------窗体----------------------------------
/*------------------------------------------------------------------------------
 |  窗体
 |
 -----------------------------------------------------------------------------*/
//窗体创建
- (void)onCreate {
    //顶部面板-----------
    [self changeTopTitle:@"体检报告"];
    [self hideTopRightBtn];
    //内容面板-----------
    
    //底部面板-----------
    //其他--------------
    self.arrayOfCellData = [[NSMutableArray alloc] init];
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
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
    [self httpGet:[AppUtil healthUrl:@"pemaster.PEMasterPRC.myReportList.submit"]];
}

- (void)onHttpRequestSuccessObj:(NSDictionary *)obj {
    [self.arrayOfCellData removeAllObjects];
    
    NSArray *list = [obj valueForKey:@"list"];
    for (NSDictionary *obj in list) {
        HealthReportListCellData *cd = [[HealthReportListCellData alloc] initWithObj:obj];
        [self.arrayOfCellData addObject:cd];
    }
    
    [self.tableView reloadData];
}

//完善参数
- (void)completeQueryParams {
    [self.queryParams setValue:Global.instance.userInfo.userLoginId forKey:@"userLoginId"];
}



#pragma mark -
#pragma mark ------------------------------tableView----------------------------------
/*------------------------------------------------------------------------------
 |  tableView
 |
 -----------------------------------------------------------------------------*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfCellData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [HealthReportListCell CellHeight];
}

- (void) createCell:(UITableViewCell *)cell {
    HealthReportListCell *c = [[HealthReportListCell alloc] initWithVc:self];
    c.tag = 100;
    [cell addSubview:c];
}

- (void)makeCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    //容错
    if (row >= self.arrayOfCellData.count) {
        return;
    }
    
    HealthReportListCell *c = (HealthReportListCell *)[cell viewWithTag:100];
    HealthReportListCellData *cd = [self.arrayOfCellData objectAtIndex:row];
    //刷新
    [c refreshWithCellData:cd];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    //容错
    if (row >= self.arrayOfCellData.count) {
        return;
    }
    
    HealthReportListCellData *cd = [self.arrayOfCellData objectAtIndex:row];
    [self navTo:@"HealthReportWebVc" params:[NSDictionary dictionaryWithObject:cd.peMasterId forKey:@"peMasterId"]];
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
