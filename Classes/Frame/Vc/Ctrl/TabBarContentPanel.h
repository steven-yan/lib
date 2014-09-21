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

@interface TabBarContentPanel : UIView

//代理
@property (weak) NSObject<TabBarContentPanelDelegate> *delegate;
//nrVc
@property (weak) BaseLayoutVc *nrVc;



@end
