/**
 *
 *@author steven.yan
 *
 */

@class HealthyCheckCenterCell;

@protocol HealthyCheckCenterCellDelegate <NSObject>
@optional
@end

@interface HealthyCheckCenterCell : UIView

//代理
@property (weak) NSObject<HealthyCheckCenterCellDelegate> *delegate;
//页面
@property (weak) BaseVc *nrVc;

//iv
@property (nonatomic, strong) UIImageView *ctrlIv;
//label
@property (nonatomic, strong) UILabel *ctrlLabel;
//online hint
@property (nonatomic, strong) UIImageView *ctrlOnlineHint;

//初始化
- (id)initWithVc:(BaseVc *)vc;
//高度
+ (float)CellHeight;
//刷新
- (void)refreshWithImg:(UIImage *)img name:(NSString *)name onlineTag:(BOOL)onLineTag;



@end
