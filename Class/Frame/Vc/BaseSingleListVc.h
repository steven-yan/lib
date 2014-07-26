/**
 *
 * @author steven.yan
 *
 */

#import "RefreshPanel.h"

@interface BaseSingleListVc : BaseListVc <UITableViewDataSource, UITableViewDelegate, RefreshPanelDelegate, UIScrollViewDelegate>

//uniqueId
@property (nonatomic, strong) NSString *uniqueCellIdForSingleList;


//下拉刷新面板
@property (nonatomic, strong) RefreshPanel *ctrlDropRefreshPanel;
//上拉刷新面板
@property (nonatomic, strong) RefreshPanel *ctrlRiseRefreshPanel;


//
- (void) createCell:(UITableViewCell *)cell;
- (void)makeCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

//RefreshPanel------
- (void)hideDropPanel;
- (void)hideRisePanel;
//dropPanel
- (void)dropPanelWhileLoading;
- (void)dropPanelFinisnLoading;

//risePanel
- (void)risePanelWhileLoading;
- (void)risePanelFinishLoading;



@end
