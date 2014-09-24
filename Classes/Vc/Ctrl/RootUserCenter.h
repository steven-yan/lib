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

@interface RootUserCenter : TabBarContentPanel

- (id)initWithVc:(BaseLayoutVc *)vc;


@end
