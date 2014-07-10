/**
 *
 *@author steven.yan
 *
 */

#import "BaseVC.h"
#import "SysInfo.h"

@class BottomPanel;

@protocol BottomPanelDelegate <NSObject>
- (void)BottomPanelClicked:(BottomPanel *)sender index:(int)index;
@optional
@end

@interface BottomPanel : UIView

//代理
@property (weak) NSObject<BottomPanelDelegate> *delegate;
//nrVc
@property (weak) BaseVC *nrVc;

//图片列表
@property (nonatomic, strong) NSMutableArray *imgViewList;
@property (nonatomic, strong) NSArray *normalImgList;
@property (nonatomic, strong) NSArray *highImgList;

//个数
@property (nonatomic) int itemNum;
//视图索引
@property int selectedIndex;

//init
- (id)initWithVc:(BaseVC *)vc
   normalImgList:(NSArray *)normalImgList
     highImgList:(NSArray *)highImgList
       titleList:(NSArray *)titleList;



@end
