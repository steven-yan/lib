/**
 *
 *@author steven.yan
 *
 **/

@class BaseLayoutVc;
@class TabBarBottomPanel;

@protocol TabBarBottomPanelDelegate <NSObject>
- (void)tabBarBottomPanelClicked:(TabBarBottomPanel *)sender index:(NSInteger)index;
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

//个数
@property (nonatomic) NSInteger itemNum;
//选中索引
@property NSInteger selectedIndex;

//init
- (id)initWithImgList:(NSArray *)imgList
      selectedImgList:(NSArray *)selectedImgList
            titleList:(NSArray *)titleList;
//
- (void)setImgList:(NSArray *)normalImgTitleList
   selectedImgList:(NSArray *)selectedImgTitleList
         titleList:(NSArray *)titleList;



@end
