/**
 *
 * HealthPackageDetailCell
 * @author steven.yan
 * @date Sep 22 2014
 *
 **/

#import "HealthPackageDetailCellData.h"

@protocol HealthPackageDetailCellDelegate <NSObject>
@optional
@end

@interface HealthPackageDetailCell : UIView

//代理
@property (weak) NSObject<HealthPackageDetailCellDelegate> *delegate;
//页面
@property (weak) BaseVc *nrVc;

//组合名称
@property (nonatomic, strong) UILabel *ctrlGroupName;
//详情
@property (nonatomic, strong) UILabel *ctrlDetail;

//初始化
- (id)initWithVc:(BaseLayoutVc *)vc;
//高度
+ (float)CellHeight;
//刷新
- (void)refreshWithItemData:(HealthPackageDetailCellData *)d;


@end
