/**
 *
 *  RootExpertRmd
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "TabBarContentPanel.h"
#import "RootExpertRmdCell.H"

@protocol RootExpertRmdDelegate <NSObject>
@optional
@end

@interface RootExpertRmd : TabBarContentPanel <UITableViewDataSource, UITableViewDelegate>

- (id)initWithVc:(BaseLayoutVc *)vc;



@end
