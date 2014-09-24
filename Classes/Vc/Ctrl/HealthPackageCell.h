/**
 *
 * HealthPackageCell
 * @author steven.yan
 * @date Sep 21 2014
 *
 **/

#import "HealthPackageListCellData.h"

@protocol HealthPackageCellDelegate <NSObject>
@optional
@end

@interface HealthPackageCell : UIView

//代理
@property (weak) NSObject<HealthPackageCellDelegate> *delegate;
//页面
@property (weak) BaseVc *nrVc;

//名字
@property (nonatomic, strong) UILabel *ctrlName;
//价格
@property (nonatomic, strong) UILabel *ctrlPrice;

//初始化
- (id)initWithVc:(BaseLayoutVc *)vc;
//高度
+ (float)CellHeight;
//刷新
- (void)refreshWithItemData:(HealthPackageListCellData *)d;


@end
