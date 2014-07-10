/**
 *
 * @author steven.yan
 *
 */
#import "BaseVC.h"
#import "RefreshPanel.h"
#import "SysInfo.h"

@interface BaseListVC : BaseVC <UITableViewDataSource, UITableViewDelegate, refreshPanelDelegate, UIScrollViewDelegate>

//tableView
@property (nonatomic, strong) UITableView *tableView;
//uniqueId
@property (nonatomic, strong) NSString *uniqueCellIdForSingleList;

//下拉刷新面板
@property (nonatomic, strong) RefreshPanel *ctrlDropRefreshPanel;
//上拉刷新面板
@property (nonatomic, strong) RefreshPanel *ctrlRiseRefreshPanel;



- (void) createCell:(UITableViewCell *)cell;
- (void)makeCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

//RefreshPanel------
//dropPanel
- (void)dropPanelWhileLoading;
- (void)dropPanelFinisnLoading;

//risePanel
- (void)risePanelWhileLoading;
- (void)risePanelFinishLoading;



@end
