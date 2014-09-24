/**
 *
 *  RootUserCenter
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "RootUserCenter.h"

@implementation RootUserCenter



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
        //数据------
        //其他------
    }
    
    return self;
}

- (void)onWillShow {
    [self.nrVc changeTopTitle:@"个人中心"];
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
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;//[ExpertCell CellHeight:@"详细信息:   张三曾在撒旦法士大夫士大夫士大夫士大夫士大夫士大夫士大夫第三方"];
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
//    ExpertCell *c = [[ExpertCell alloc] initWithVc:self.nrVc];
//    c.tag = 100;
//    [cell addSubview:c];
}

- (void)makeCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
//    ExpertCell *c = (ExpertCell *)[cell viewWithTag:100];
//    [c refreshWithImg:nil msg:@"专家信息:   张三曾在撒旦法士大夫士大夫士大夫士大夫士大夫士大夫士大夫第三方" name:@"张三"];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
