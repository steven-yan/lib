/**
 *
 *@author steven.yan
 *
 */
@protocol RootVcPanel2Delegate <NSObject>
@optional
@end

#import "BaseVC.h"
#import "SearchPanel.h"

@interface RootVcPanel2 : UIView <TopPanelDelegate, UITableViewDataSource, UITableViewDelegate>

//代理
@property (weak) NSObject<RootVcPanel2Delegate> *delegate;
//页面
@property (weak) BaseVC *nrVc;

@property (nonatomic, strong) SearchPanel *ctrlSearchPanel;

//init
- (id)initWithVc:(BaseVC *)vc;



@end
