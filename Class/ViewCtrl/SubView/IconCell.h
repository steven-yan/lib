/**
 *
 *@author steven.yan
 *
 */
@protocol IconCellDelegate <NSObject>
- (void)onIconCellSelected:(NSMutableDictionary *)params;
@optional
@end

#import "BaseVC.h"
#import "SmartCollarAppDelegate.h"
#import "NotificationNameDefine.h"

@interface IconCell : UIView

//代理
@property (weak) NSObject<IconCellDelegate> *delegate;
//页面
@property (weak) BaseVC *nrVc;

//背景列表
@property (nonatomic, strong) NSMutableArray *bgList;
//图片列表
@property (nonatomic, strong) NSMutableArray *imgList;
//名字列表
@property (nonatomic, strong) NSMutableArray *nameList;
//jid列表
@property (nonatomic, strong) NSMutableArray *jidList;

//test------
//label列表
@property (nonatomic, strong) NSMutableArray *imgHintList;


//元素个数
@property int elementNum;

//初始化
- (id)initWithVc:(BaseVC *)vc;
//高度
+ (float)CellHeight;
//刷新
- (void)refreshWithNameList:(NSMutableArray *)nameList
                    jidList:(NSMutableArray *)jidList;



@end
