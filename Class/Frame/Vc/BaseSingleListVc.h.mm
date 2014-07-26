/**
 *
 * @author steven.yan
 *
 */

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
    //下拉刷新
    RefreshPanel *rp = [[RefreshPanel alloc] initWithVc:self sv:self.tableView isDropPanel:YES];
    rp.delegate = self;
    self.ctrlDropRefreshPanel = rp;
    //上拉刷新
    rp = [[RefreshPanel alloc] initWithVc:self sv:self.tableView isDropPanel:NO];
    rp.delegate = self;
    self.ctrlRiseRefreshPanel = rp;
    
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



#pragma mark -
#pragma mark ----------------------------RefreshPanel------------------------------
/*------------------------------------------------------------------------------
 |  RefreshPanel
 |
 -----------------------------------------------------------------------------*/
- (void)RefreshPanelWhileLoading:(RefreshPanel *)p {
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

//hide
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
