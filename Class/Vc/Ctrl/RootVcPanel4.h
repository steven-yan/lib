/**
 *
 *@author steven.yan
 *
 */
@protocol RootVcPanel4Delegate <NSObject>
@optional
@end

#import "BaseVC.h"

@interface RootVcPanel4 : UIView <TopPanelDelegate, UITableViewDataSource, UITableViewDelegate>

//代理
@property (weak) NSObject<RootVcPanel4Delegate> *delegate;
//页面
@property (weak) BaseVC *nrVc;

- (id)initWithVc:(BaseVC *)vc;



@end
