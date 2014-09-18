/**
 *
 *@author steven.yan
 *
 */

#import "SysInfo.h"

@class BaseLayoutVc;
@class BottomPanel;

@protocol BottomPanelDelegate <NSObject>
- (void)BottomPanelClicked:(BottomPanel *)sender index:(NSInteger)index;
@optional
@end

@interface BottomPanel : UIView

//代理
@property (weak) NSObject<BottomPanelDelegate> *delegate;
//nrVc
@property (weak) BaseLayoutVc *nrVc;

//图片列表
@property (nonatomic, strong) NSMutableArray *imgViewList;
@property (nonatomic, strong) NSMutableArray *nameLabelList;
@property (nonatomic, strong) NSArray *normalImgList;
@property (nonatomic, strong) NSArray *highImgList;


//个数
@property (nonatomic) NSInteger itemNum;
//视图索引
@property int selectedIndex;

//init
- (id)initWithVc:(BaseVc *)vc
   normalImgList:(NSArray *)normalImgList
     highImgList:(NSArray *)highImgList
       titleList:(NSArray *)titleList;

- (void)setIndex:(int)idx;


@end
