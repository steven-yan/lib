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
    //无信息提示
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [iv setImage:[UIImage imageNamed:@"depression_face"]];
    iv.hidden = YES;
    iv.centerX = self.contentPanel.width / 2;
    iv.centerY = self.contentPanel.height / 2 - 60;
    [self.contentPanel addSubview:iv];
    self.ctrlIv = iv;
    
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
    [self showLoading];
    [self httpGet:[AppUtil fillUrl:@"pemaster.PEMasterPRC.myReportList.submit"]];
}

- (void)onHttpRequestSuccessObj:(NSDictionary *)obj {
    //hide
    [self hideLoading];
    
    [self.arrayOfCellData removeAllObjects];
    
    NSArray *list = [obj valueForKey:@"list"];
    if (list.count>0) {
        for (NSDictionary *obj in list) {
            HealthReportListCellData *cd = [[HealthReportListCellData alloc] initWithObj:obj];
            [self.arrayOfCellData addObject:cd];
        }
        [self.tableView reloadData];
        self.ctrlIv.hidden = YES;
    } else {
        [self showToast:@"暂时没有信息"];
        self.ctrlIv.hidden = NO;
    }
    
    [self.tableView reloadData];
}

- (void)onHttpRequestFailed:(EnHttpRequestFailed)err hint:(NSString *)hint tag:(NSInteger)tag {
    [self hideLoading];
    [self showLoadError];
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
