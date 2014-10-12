/**
 *
 *  RootExpertRmd
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "TabBarContentPanel.h"
#import "RootExpertRmdCellData.h"
#import "RootExpertRmdCell.H"

@protocol RootExpertRmdDelegate <NSObject>
@optional
@end

@interface RootExpertRmd : TabBarContentPanel <UITableViewDataSource, UITableViewDelegate>

//tv
@property (nonatomic, strong) UITableView *ctrlTableView;

//array
@property (nonatomic, strong) NSMutableArray *arrayOfCellData;

- (id)initWithVc:(BaseLayoutVc *)vc;



@end
