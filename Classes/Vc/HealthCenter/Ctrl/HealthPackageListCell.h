/**
 *
 * HealthPackageCell
 * @author steven.yan
 * @date Sep 21 2014
 *
 **/

#import "HealthPackageListCellData.h"

@protocol HealthPackageListCellDelegate <NSObject>
@optional
@end

@interface HealthPackageListCell : UIView

//代理
@property (weak) NSObject<HealthPackageListCellDelegate> *delegate;
//页面
@property (weak) BaseLayoutVc *nrVc;

//名字
@property (nonatomic, strong) UILabel *ctrlName;
//价格
@property (nonatomic, strong) UILabel *ctrlPrice;

//data
@property (nonatomic, strong) HealthPackageListCellData *data;

//初始化
- (id)initWithVc:(BaseLayoutVc *)vc;
//高度
+ (float)CellHeight;
//刷新
- (void)refreshWithItemData:(HealthPackageListCellData *)d;


@end
