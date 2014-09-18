/**
 * 
 *@author steven.yan
 *
 */

#import "RootVcPanel0.h"

@implementation RootVcPanel0



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithVc:(BaseLayoutVc *)vc {
    if (self = [super initWithFrame:CGRectMake(0, 0, vc.view.width, vc.view.height - [SysInfo instance].bottomPanelHeight)]) {
        //页面
        self.nrVc = vc;
        //-
        
        //控件-------------------
        //顶部面板
        TopPanel *tp = [[TopPanel alloc] init];
        tp.ctrlLeftBtn.hidden = YES;
        tp.ctrlRightBtn.hidden = YES;
        [tp changeTitle:@"专家推荐"];
        [self addSubview:tp];
        
        //tableView
        UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, tp.bottom, self.width, vc.contentPanel.height - [SysInfo instance].bottomPanelHeight) style:UITableViewStylePlain];
        tv.backgroundView = nil;
        tv.backgroundColor = [UIColor clearColor];
        tv.dataSource = self;
        tv.delegate = self;
        tv.separatorStyle = UITableViewCellSeparatorStyleNone;
        tv.showsVerticalScrollIndicator = NO;
        [self addSubview:tv];
        
        //数据-------------------
    }
    
    return self;
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
    return [ExpertCell CellHeight:@"详细信息:   张三曾在撒旦法士大夫士大夫士大夫士大夫士大夫士大夫士大夫第三方"];
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
    ExpertCell *c = [[ExpertCell alloc] initWithVc:self.nrVc];
    c.tag = 100;
    [cell addSubview:c];
}

- (void)makeCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    ExpertCell *c = (ExpertCell *)[cell viewWithTag:100];
    [c refreshWithImg:nil msg:@"专家信息:   张三曾在撒旦法士大夫士大夫士大夫士大夫士大夫士大夫士大夫第三方" name:@"张三"];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
