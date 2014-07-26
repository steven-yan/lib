/**
 *
 * @author steven.yan
 *
 */

#import "BaseSectionListVc.h"

@implementation BaseSectionListVc



/*------------------------------------------------------------------------------
|  页面
|
 ------------------------------------------------------------------------------*/
- (void) _onCreateBegin {
    self._tableSectionTag = YES;
    [super _onCreateBegin];
    //顶部面板-----------
    //内容面板-----------
    //底部面板-----------
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ss"];
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
