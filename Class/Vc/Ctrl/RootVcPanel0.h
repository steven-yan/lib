/**
 *
 *@author steven.yan
 *
 */

@class RootVcPanel0;

@protocol RootVcPanel0Delegate <NSObject>
@optional
@end

#import "BaseVC.h"
#import "ExpertCell.h"

@interface RootVcPanel0 : UIView <TopPanelDelegate, UITableViewDataSource, UITableViewDelegate>

//代理
@property (weak) NSObject<RootVcPanel0Delegate> *delegate;
//页面
@property (weak) BaseVC *nrVc;

//init
- (id)initWithVc:(BaseVC *)vc;



@end
