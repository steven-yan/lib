/**
 *
 * @author steven.yan
 *
 */
#import "BaseSingleListVc.h"

@implementation BaseSingleListVc



/*------------------------------------------------------------------------------
|  页面
|
 ------------------------------------------------------------------------------*/
- (void) _onCreateBegin {
    self._tableSectionTag = NO;
    [super _onCreateBegin];
    //顶部面板-----------
    //内容面板-----------
    //底部面板-----------
    //数据-----------
    //其他--------------
    self.uniqueCellIdForSingleList = NSStringFromClass([self class]);
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.uniqueCellIdForSingleList];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.uniqueCellIdForSingleList];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self createCell:cell];
    }
    
    [self makeCell:cell indexPath:indexPath];
    
    return cell;
}

- (void) createCell:(UITableViewCell *)cell {
}
- (void)makeCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
