/**
 *
 *  RootHealthCenter
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "RootHealthCenter.h"

@implementation RootHealthCenter



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithVc:(BaseLayoutVc *)vc {
    if (self = [super initWithVc:vc frame:vc.contentPanel.bounds]) {
        //页面------
        //控件------
        UITableView *tv = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tv.dataSource = self;
        tv.delegate = self;
        tv.showsVerticalScrollIndicator = NO;
        tv.separatorStyle = UITableViewCellSeparatorStyleNone;
        tv.backgroundColor = [UIColor whiteColor];
        [self addSubview:tv];
        self.ctrlTableView = tv;
        
        //数据------
        self.arrayOfCellData = [[NSMutableArray alloc] init];
        //其他------
    }
    
    return self;
}

- (void)onWillShow {
    [self.nrVc changeTopTitle:@"体检中心"];
    //加载数据
    [self loadData];
}

- (void)onWillHide {
}



#pragma mark -
#pragma mark --------------------------获取和提交数据-----------------------------
/*------------------------------------------------------------------------------
 |  获取和提交数据
 |
 -----------------------------------------------------------------------------*/
- (void)loadData {
    __weak ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://180.166.93.195:8888/peiscenter.PeisCenterPRC.getPeisCenterList.submit"]];
    
    [request setCompletionBlock:^{
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[request.responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
        if (![dic objectForKey:@"error"]) {
//            [self.nrVc showHudWithBottomHint:[dic valueForKey:@"error"]];
        } else {
            [self.arrayOfCellData removeAllObjects];
            
            NSArray *arr = [dic valueForKey:@"list"];
            for (NSDictionary *dic in arr) {
                RootHealthCenterCellData *cd = [[RootHealthCenterCellData alloc] initWithObj:dic];
                [self.arrayOfCellData addObject:cd];
            }
            
            //刷新
            [self.ctrlTableView reloadData];
        }
    }];
    
    [request setFailedBlock:^{
        NSLog(@"获取数据失败");
    }];
    
    [request startAsynchronous];
}


#pragma mark -
#pragma mark ------------------------------方法----------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/



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
    return [RootHealthCenterCell CellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *uniqueIdentifyer = NSStringFromClass([self class]);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:uniqueIdentifyer];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:uniqueIdentifyer];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self createCell:cell];
    }
    
    [self makeCell:cell indexPath:indexPath];
    
    return cell;

}

- (void)createCell:(UITableViewCell *)cell {
    RootHealthCenterCell *c = [[RootHealthCenterCell alloc] initWithVc:self.nrVc];
    c.tag = 100;
    [cell addSubview:c];
}

- (void)makeCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    //容错
    NSInteger index = indexPath.row;
    
    if (index >= self.arrayOfCellData.count) {
        return;
    }
    
    RootHealthCenterCell *c = (RootHealthCenterCell *)[cell viewWithTag:100];
    [c refreshWithCellData:[self.arrayOfCellData objectAtIndex:index]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //容错
    NSInteger index = indexPath.row;
    
    if (index >= self.arrayOfCellData.count) {
        return;
    }
    
    RootHealthCenterCellData *cd = [self.arrayOfCellData objectAtIndex:index];
    [self.nrVc navTo:@"HealthPackageListVc" params:[NSDictionary dictionaryWithObject:cd.centerId forKey:@"centerId"]];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
