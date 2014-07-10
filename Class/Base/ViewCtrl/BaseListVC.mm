/**
 *
 * @author steven.yan
 *
 */

#import "BaseListVC.h"

@implementation BaseListVC



/*------------------------------------------------------------------------------
|  页面
|
 ------------------------------------------------------------------------------*/
- (void) onCreateBegin {
    //顶部面板-----------
    //内容面板-----------
    //调整面板高度
    //tableView
    UITableView *tv = [[UITableView alloc] initWithFrame:self.contentPanel.bounds style:UITableViewStylePlain];
    tv.dataSource = self;
    tv.delegate = self;
    tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    tv.showsVerticalScrollIndicator = NO;
    self.tableView = tv;
    [self.contentPanel addSubview:tv];
    
    //下拉刷新
    RefreshPanel *dp = [[RefreshPanel alloc] initWithVc:self sv:self.tableView isDropPanel:YES];
    dp.delegate = self;
    self.ctrlDropRefreshPanel = dp;
    //上拉刷新
    dp = [[RefreshPanel alloc] initWithVc:self sv:self.tableView isDropPanel:NO];
    dp.delegate = self;
    self.ctrlRiseRefreshPanel = dp;

    //底部面板-----------
    //其他--------------
    self.uniqueCellIdForSingleList = NSStringFromClass([self class]);
}

- (void)onWillShow {
}

- (void)onShow {
}

- (void)onWillHide {
}

- (void)changeBottomPanel {
    self.tableView.height = self.contentPanel.height;
}



#pragma mark -
#pragma mark ----------------------------RefreshPanel------------------------------
/*------------------------------------------------------------------------------
 |  RefreshPanel
 |
 -----------------------------------------------------------------------------*/
- (void)refreshPanelWhileLoading:(RefreshPanel *)p {
    if (p == self.ctrlDropRefreshPanel) {
        [self dropPanelWhileLoading];
    } else {
        [self risePanelWhileLoading];
    }
}

//dropPanel
- (void)dropPanelWhileLoading {
}
- (void)dropPanelFinisnLoading {
    [self.ctrlDropRefreshPanel finishLoading];
}

//risePanel
- (void)risePanelWhileLoading {
}
- (void)risePanelFinishLoading {
    [self.ctrlRiseRefreshPanel finishLoading];
}

- (void)hideDropPanel {
    self.ctrlDropRefreshPanel.hidden = YES;
}

- (void)hideRisePanel {
    self.ctrlRiseRefreshPanel.hidden = YES;
}


#pragma mark -
#pragma mark ----------------------------scrollView------------------------------
/*------------------------------------------------------------------------------
 |  scrollView
 |
 -----------------------------------------------------------------------------*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.ctrlDropRefreshPanel refreshPanelScrollViewDidScroll:scrollView];
    [self.ctrlRiseRefreshPanel refreshPanelScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.ctrlDropRefreshPanel refreshPanelScrollViewDidEndDragging:scrollView];
    [self.ctrlRiseRefreshPanel refreshPanelScrollViewDidEndDragging:scrollView];
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
