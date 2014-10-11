/**
 *
 *  HealthPackageDetailVc
 *  @author steven
 *  @date Sep 22 2014
 *
 **/

#import "HealthPackageDetailVc.h"

@implementation HealthPackageDetailVc



#pragma mark -
#pragma mark ------------------------------窗体----------------------------------
/*------------------------------------------------------------------------------
 |  窗体
 |
 -----------------------------------------------------------------------------*/
//窗体创建
- (void)onCreate {
    //顶部面板-----------
    [self changeTopTitle:@"套餐详情"];
    [self changeTopRightBtnTitle:@"预定"];
    //内容面板-----------
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentPanel.width, 20)];
    [self.contentPanel addSubview:v];
    self.ctrlHeader = v;
    //价格
    UILabel *l = [UILabel labelWithLeft:15 Top:10 Width:self.contentPanel.width - 20 Height:14 FontSize:12];
    [v addSubview:l];
    self.ctrlPrice = l;
    //描述
    l = [UILabel labelWithLeft:15 Top:l.bottom + 2 Width:self.contentPanel.width - 20 Height:14 FontSize:12];
    l.numberOfLines = 0;
    [v addSubview:l];
    self.ctrlDesp = l;
    //分隔线
    UIView *line = [UIView lineWithWidth:self.contentPanel.width];
    [v addSubview:line];
    self.ctrlLine = line;
    
    //底部面板-----------
    //其他--------------
    self.arrayOfItemGroup = [[NSMutableArray alloc] init];
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
    self.packageId = [params valueForKey:@"packageId"];
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
    [self httpGet:[AppUtil healthUrl:@"itempackage.ItemPackagePRC.getItemPackageDetail.submit"]];
}

- (void)onHttpRequestSuccessObj:(NSDictionary *)obj {
    NSString *title = [obj valueForKey:@"itemPackageName"];
    if ([ChkUtil isEmptyStr:title] == NO) {
        [self changeTopTitle:title];
    }
    NSString *price = [obj valueForKey:@"price"];
    if ([ChkUtil isEmptyStr:price]) {
        price = kEmptyStr;
    }
    NSString *des = [obj valueForKey:@"description"];
    if ([ChkUtil isEmptyStr:des]) {
        des = kEmptyStr;
    }
    //刷新
    [self refreshWithPrice:price detail:des];
    
    //数据
    NSArray *arr = [obj valueForKey:@"itemGroupList"];
    for (NSDictionary *obj in arr) {
        HealthPackageDetailCellData *cd = [[HealthPackageDetailCellData alloc] initWithObj:obj];
        [self.arrayOfItemGroup addObject:cd];
    }
    
    //刷新
    [self.tableView reloadData];
}

- (void)completeQueryParams {
    [self.queryParams setValue:self.packageId forKey:@"itemPackageId"];
}



#pragma mark -
#pragma mark ------------------------------tableView----------------------------------
/*------------------------------------------------------------------------------
 |  tableView
 |
 -----------------------------------------------------------------------------*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfItemGroup.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HealthPackageDetailCellData *cd = [self.arrayOfItemGroup objectAtIndex:indexPath.row];
    return [HealthPackageDetailCell CellHeight:cd.detail];
}

- (void) createCell:(UITableViewCell *)cell {
    HealthPackageDetailCell *cd = [[HealthPackageDetailCell alloc] initWithVc:self];
    cd.tag = 100;
    [cell addSubview:cd];
}

- (void)makeCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    //容错
    if (row >= self.arrayOfItemGroup.count) {
        return;
    }
    
    HealthPackageDetailCell *c = (HealthPackageDetailCell *)[cell viewWithTag:100];
    HealthPackageDetailCellData *cd = [self.arrayOfItemGroup objectAtIndex:row];
    [c refreshWithItemData:cd];
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)refreshWithPrice:(NSString *)price detail:(NSString *)detail {
    self.ctrlPrice.text = [@"价格: " stringByAppendingString:price];
    CGSize size = [self.ctrlDesp setDynamicWithStr:[@"描述: " stringByAppendingString:detail] fontSize:12];
    self.ctrlHeader.height = self.ctrlDesp.top + size.height + 10;
    self.ctrlLine.bottom = self.ctrlHeader.height;
    self.ctrlHeader.height = self.ctrlLine.bottom;
    // tableView.tableHeaderView  高度不会随着ctrlHeader变化 所以要重新赋值
    self.tableView.tableHeaderView = self.ctrlHeader;
}



@end
