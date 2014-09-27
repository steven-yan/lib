/**
 *
 *  RootUserCenter
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "TabBarContentPanel.h"

@protocol RootUserCenterDelegate <NSObject>
@optional
@end

@interface RootUserCenter : TabBarContentPanel <UITableViewDataSource, UITableViewDelegate>

//tv
@property (nonatomic, strong) UITableView *ctrlTableView;
//state
@property (nonatomic) EN_LOGIN_STATE_T userState;

//init
- (id)initWithVc:(BaseLayoutVc *)vc;



@end
