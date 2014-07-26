/**
 *
 *@author steven.yan
 *
 */
@protocol RootVcPanel3Delegate <NSObject>
@optional
@end

#import "BaseVC.h"

@interface RootVcPanel3 : UIView

//代理
@property (weak) NSObject<RootVcPanel3Delegate> *delegate;
//页面
@property (weak) BaseVC *nrVc;


- (id)initWithVc:(BaseVC *)vc;



@end
