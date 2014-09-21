/**
 *
 *@author steven.yan
 *@date June 4 2014
 *
 **/

#import "BaseVC.h"

@class RefreshPanel;

@protocol RefreshPanelDelegate <NSObject>
@optional
- (void)refreshPanelWhileLoading:(RefreshPanel *)p;
@end

@interface RefreshPanel : UIView

//代理
@property (weak) NSObject<RefreshPanelDelegate> *delegate;
//页面
@property (weak) BaseVc *nrVc;
//sv
@property (weak) UIScrollView *nrSv;

//动画图片控件
@property (nonatomic,retain)  UIImageView *ctrlArrow;
//指示器
@property (nonatomic,retain)  UIActivityIndicatorView *ctrlIndicator;
//提示标签
@property (nonatomic,retain)  UILabel *ctrlHintLabel;

//是否是下拉刷新
@property BOOL isDropTag;
//是否需要刷新
@property BOOL needRefreshTag;
//是否加载中
@property BOOL isLoadingTag;

- (id)initWithVc:(BaseVc *)vc sv:(UIScrollView *)sv isDropPanel:(BOOL)isDropTag;
-(void)finishLoading;
-(void)onWillHide;



@end
