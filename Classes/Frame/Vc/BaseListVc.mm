/**
 *
 * @author steven.yan
 *
 */

#import "BaseListVc.h"

@implementation BaseListVc



/*------------------------------------------------------------------------------
|  页面
|
 ------------------------------------------------------------------------------*/
- (void) _onCreateBegin {
    [super _onCreateBegin];
    
    //顶部面板-----------
    //内容面板-----------
    //调整面板高度
    //tableView
    UITableView *tv = nil;
    if (self._tableSectionTag == NO) {
        tv = [[UITableView alloc] initWithFrame:self.contentPanel.bounds];
    } else {
        tv = [[UITableView alloc] initWithFrame:self.contentPanel.bounds style:UITableViewStyleGrouped];
    }
    tv.dataSource = self;
    tv.delegate = self;
    tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    tv.showsVerticalScrollIndicator = NO;
    self.tableView = tv;
    [self.contentPanel addSubview:tv];
    
    //底部面板-----------
    //数据-----------
    //其他--------------
}

- (void)onWillShow {
}

- (void)onShow {
}

- (void)onWillHide {
}



#pragma mark -
#pragma mark ------------------------------tableView----------------------------------
/*------------------------------------------------------------------------------
 |  tableView
 |
 -----------------------------------------------------------------------------*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
