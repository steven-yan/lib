/**
 *
 *  RootExpertRmd
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "RootExpertRmd.h"

@implementation RootExpertRmd



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
    [self.nrVc changeTopTitle:@"专家推荐"];
    //加载数据
    [self loadData];
}

- (void)onWillHide {
}



#pragma mark --------------------------获取和提交数据-----------------------------
/*------------------------------------------------------------------------------
 |  获取和提交数据
 |
 -----------------------------------------------------------------------------*/
- (void)loadData {
    [self httpGet:[AppUtil healthUrl:@"news.NewsPRC.getDoctorList.submit"]];
}

- (void)onHttpRequestSuccess:(NSString *)response {
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    if (![dic objectForKey:@"error"]) {
    } else {
        [self.arrayOfCellData removeAllObjects];
        NSArray *arr = [dic valueForKey:@"list"];
        for (NSDictionary *dic in arr) {
            RootExpertRmdCellData *cd = [[RootExpertRmdCellData alloc] initWithObj:dic];
            [self.arrayOfCellData addObject:cd];
        }
        
        //刷新
        [self.ctrlTableView reloadData];
    }
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
    return [RootExpertRmdCell CellHeight];
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
    RootExpertRmdCell *c = [[RootExpertRmdCell alloc] initWithVc:self.nrVc];
    c.tag = 100;
    [cell addSubview:c];
}

- (void)makeCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    //容错
    if (row >= self.arrayOfCellData.count) {
        return;
    }
    
    RootExpertRmdCell *c = (RootExpertRmdCell *)[cell viewWithTag:100];
    RootExpertRmdCellData *cd = [self.arrayOfCellData objectAtIndex:row];
    [c refreshWithCellData:cd];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    //容错
    if (row >= self.arrayOfCellData.count) {
        return;
    }
    
    RootExpertRmdCellData *cd = [self.arrayOfCellData objectAtIndex:row];
    
    [self.nrVc navTo:@"ExpertDetailVc" params:[NSDictionary dictionaryWithObject:cd.expertId forKey:@"expertId"]];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
