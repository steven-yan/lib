/**
 *
 *@author steven.yan
 *@date Sep 21 2014
 *
 **/

@class BaseLayoutVc;
@class TabBarContentPanel;

@protocol TabBarContentPanelDelegate <NSObject>
@optional
@end

@interface TabBarContentPanel : BaseHttpView
//代理
@property (weak) NSObject<TabBarContentPanelDelegate> *delegate;
//nrVc
@property (weak) BaseLayoutVc *nrVc;

- (id)initWithVc:(BaseLayoutVc *)vc frame:(CGRect)frame;
- (void)onWillShow;
- (void)onWillHide;



@end
