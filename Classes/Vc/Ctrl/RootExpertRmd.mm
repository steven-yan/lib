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
        //数据------
        //其他------
    }
    
    return self;
}

- (void)onWillShow {
    [self.nrVc changeTopTitle:@"专家推荐"];
}

- (void)onWillHide {
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
    return 10;
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
    RootExpertRmdCell *c = (RootExpertRmdCell *)[cell viewWithTag:100];
    [c refreshWithCellData:[[RootExpertRmdCellData alloc] initWithObj:nil]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.nrVc navTo:@"ExpertDetailVc"];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
