/**
 *
 * @author steven.yan
 *
 */

@interface BaseListVc : BaseLayoutVc <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

//tableView
@property (nonatomic, strong) UITableView *tableView;
//是否是分段表格
@property (nonatomic) BOOL _tableSectionTag;



@end
