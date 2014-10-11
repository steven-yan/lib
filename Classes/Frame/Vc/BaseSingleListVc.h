/**
 *
 * @author steven.yan
 *
 */

#import "RefreshPanel.h"

@interface BaseSingleListVc : BaseListVc <UITableViewDataSource, UITableViewDelegate>

//uniqueId
@property (nonatomic, strong) NSString *uniqueCellIdForSingleList;

//下拉刷新面板
@property (nonatomic, strong) RefreshPanel *ctrlDropRefreshPanel;
//上拉刷新面板
@property (nonatomic, strong) RefreshPanel *ctrlRiseRefreshPanel;



@end
