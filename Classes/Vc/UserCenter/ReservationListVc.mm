/**
 *
 *  ReservationListVc
 *  @author steven
 *  @date Otc 7 2014
 *
 **/

#import "ReservationListVc.h"

@implementation ReservationListVc



#pragma mark -
#pragma mark ------------------------------窗体----------------------------------
/*------------------------------------------------------------------------------
 |  窗体
 |
 -----------------------------------------------------------------------------*/
//窗体创建
- (void)onCreate {
    //顶部面板-----------
    [self changeTopTitle:@"我的预约"];
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
    //数据--------------
    self.arrayOfCellData = [[NSMutableArray alloc] init];
    //其他--------------
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
}

//解析导航返回
- (void)onPraseNavBackParams:(NSDictionary *)params {
    [self loadData];
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
    [self httpGet:[AppUtil fillUrl:@"userlogin.UserLoginPRC.getReservationList.submit"]];
}

- (void)onHttpRequestSuccessObj:(NSDictionary *)obj {
    [self hideLoading];
    
    [self.arrayOfCellData removeAllObjects];
    NSArray *list = [obj valueForKey:@"list"];
    if (list.count>0) {
        for (NSDictionary *dic in list) {
            ReservationListCellData *cd = [[ReservationListCellData alloc] initWithObj:dic];
            [self.arrayOfCellData addObject:cd];
        }
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ReservationListCell CellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfCellData.count;
}

- (void) createCell:(UITableViewCell *)cell {
    ReservationListCell *c = [[ReservationListCell alloc] initWithVc:self];
    c.tag = 100;
    [cell addSubview:c];
}

- (void)makeCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    //容错
    if (row >= self.arrayOfCellData.count) {
        return;
    }
    
    ReservationListCell *c = (ReservationListCell *)[cell viewWithTag:100];
    ReservationListCellData *cd = [self.arrayOfCellData objectAtIndex:row];
    [c refreshWithCellData:cd];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    //容错
    if (row >= self.arrayOfCellData.count) {
        return;
    }
    
    ReservationListCellData *cd = [self.arrayOfCellData objectAtIndex:row];
    [self navTo:@"ReservationDetailVc" params:[NSDictionary dictionaryWithObjectsAndKeys:cd.peMasterId, @"peMasterId", cd.status, @"status", nil]];
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
