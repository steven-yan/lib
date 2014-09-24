/**
 *
 *@author steven.yan
 *
 **/
#import "TabBarContentPanel.h"

@class BaseLayoutVc;
@class TabBarBottomPanel;

@protocol TabBarBottomPanelDelegate <NSObject>
//- (void)tabBarBottomPanelClicked:(TabBarBottomPanel *)sender index:(NSInteger)index;
@optional
@end

@interface TabBarBottomPanel : UIView

//代理
@property (weak) NSObject<TabBarBottomPanelDelegate> *delegate;
//nrVc
@property (weak) BaseLayoutVc *nrVc;

//按钮列表
@property (nonatomic, strong) NSMutableArray *arrayOfBtn;
//默认图片列表
@property (nonatomic, strong) NSMutableArray *arrayOfNormalImg;
//高亮图片列表
@property (nonatomic, strong) NSMutableArray *arrayOfSelectedImg;
//高亮图片列表
@property (nonatomic, strong) NSMutableArray *arrayOfTabBarContent;

//个数
@property (nonatomic) NSInteger itemNum;
//上次选中的索引
@property NSInteger selectedIndex;

//初始化
- (id)initWithVc:(BaseLayoutVc *)vc;
//设置 底部面板
- (void)setImgList:(NSArray *)normalImgTitleList
   selectedImgList:(NSArray *)selectedImgTitleList
         titleList:(NSArray *)titleList;
//设置 内容面板
- (void)setContentPanel:(NSArray *)tabBarContentPanelList;


@end
