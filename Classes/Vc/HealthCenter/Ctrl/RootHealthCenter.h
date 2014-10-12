/**
 *
 * RootHealthCenter
 * @author steven.yan
 * @date Sep 21 2014
 *
 **/

#import "TabBarContentPanel.h"
#import "RootHealthCenterCellData.h"
#import "RootHealthCenterCell.h"

@protocol RootHealthCenterDelegate <NSObject>
@optional
@end

@interface RootHealthCenter : TabBarContentPanel <UITableViewDataSource, UITableViewDelegate, ASIHTTPRequestDelegate>

//tv
@property (nonatomic, strong) UITableView *ctrlTableView;

//array
@property (nonatomic, strong) NSMutableArray *arrayOfCellData;

- (id)initWithVc:(BaseLayoutVc *)vc;



@end
