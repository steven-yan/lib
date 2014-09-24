/**
 *
 *  HealthPackageListVc
 *  @author steven
 *  @date Sep 22 2014
 *
 **/

#import "HealthPackageListVc.h"

@implementation HealthPackageListVc



#pragma mark -
#pragma mark ------------------------------窗体----------------------------------
/*------------------------------------------------------------------------------
 |  窗体
 |
 -----------------------------------------------------------------------------*/
//窗体创建
- (void)onCreate {
    //顶部面板-----------
    [self changeTopTitle:@"套餐列表"];
    [self hideTopRightBtn];
    //内容面板-----------
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentPanel.width, 80)];
//    v.backgroundColor = [];
    self.ctrlHeader = v;
    //体检中心地址
    UILabel *l = [UILabel labelWithLeft:10 Top:10 Width:self.contentPanel.width - 20 Height:14 FontSize:12];
    [v addSubview:l];
    self.ctrlPeisAddr = l;
    //体检中心电话
    l = [UILabel labelWithLeft:10 Top:l.bottom + 2 Width:self.contentPanel.width - 20 Height:14 FontSize:12];
    [v addSubview:l];
    self.ctrlPeisPhone = l;
    //体检中心传真
    l = [UILabel labelWithLeft:10 Top:l.bottom + 2 Width:self.contentPanel.width - 20 Height:14 FontSize:12];
    [v addSubview:l];
    self.ctrlPeisFax = l;
    //体检中心简介
    l = [UILabel labelWithLeft:10 Top:l.bottom + 2 Width:self.contentPanel.width - 20 Height:14 FontSize:12];
    l.numberOfLines = 0;
    [v addSubview:l];
    self.ctrlPeisIntro = l;
    //分隔线
    UIView *line = [UIView lineWithWidth:self.contentPanel.width];
    [v addSubview:line];
    self.ctrlLine = line;
    
    //底部面板-----------
    //数据------
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
    __weak ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://180.166.93.195:8888/peiscenter.PeisCenterPRC.getPeisCenterDetail.submit?peisCenterId=2"]];
    
    [request setCompletionBlock:^{
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[request.responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
        if (![dic objectForKey:@"error"]) {
            [self showHudWithBottomHint:[dic valueForKey:@"error"]];
        } else {
            [self.arrayOfCellData removeAllObjects];
            
            NSArray *arr = [dic valueForKey:@"list"];
            for (NSDictionary *dic in arr) {
                HealthPackageListCellData *cd = [[HealthPackageListCellData alloc] initWithObj:dic];
                [self.arrayOfCellData addObject:cd];
            }
            
            //刷新
            [self.tableView reloadData];
        }
    }];
    
    [request setFailedBlock:^{
        NSLog(@"%@", [request responseString]);
    }];
    
    [request startAsynchronous];
    
    //http://180.166.93.195:8888/peiscenter.PeisCenterPRC.getPeisCenterList.submit
    //    严玺  14:27:49
    //http://180.166.93.195:8888/peiscenter.PeisCenterPRC.getPeisCenterDetail.submit?peisCenterId=2
}



#pragma mark -
#pragma mark ------------------------------tableView----------------------------------
/*------------------------------------------------------------------------------
 |  tableView
 |
 -----------------------------------------------------------------------------*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [HealthPackageCell CellHeight];
}

- (void) createCell:(UITableViewCell *)cell {
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    HealthPackageCell *cd = [[HealthPackageCell alloc] initWithVc:self];
    cd.tag = 100;
    [cell addSubview:cd];
}

- (void)makeCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    //容错
    
    HealthPackageCell *cd = (HealthPackageCell *)[cell viewWithTag:100];
    [cd refreshWithItemData:[[HealthPackageListCellData alloc] initWithObj:nil]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self navTo:@"HealthPackageDetailVc"];
}


#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)refreshWithAddr:(NSString *)addr phone:(NSString *)phone fax:(NSString *)fax intro:(NSString *)intro {
    self.ctrlPeisAddr.text = [@"地址: " stringByAppendingString:addr];
    self.ctrlPeisPhone.text = [@"电话: " stringByAppendingString:phone];
    self.ctrlPeisFax.text = [@"传真: " stringByAppendingString:fax];
    CGSize size = [self.ctrlPeisIntro setDynamicHeightWithStr:[@"简介: " stringByAppendingString:intro]  fontSize:12];
    self.ctrlHeader.height = self.ctrlPeisIntro.top + size.height + 10;
    self.ctrlLine.bottom = self.ctrlHeader.height;
    self.ctrlHeader.height = self.ctrlLine.bottom;
    // tableView.tableHeaderView  高度不会随着ctrlHeader变化 所以要重新赋值
    self.tableView.tableHeaderView = self.ctrlHeader;
}



@end
