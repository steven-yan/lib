/**
 *
 *  HealthPackageDetailVc
 *  @author steven
 *  @date Sep 22 2014
 *
 **/

#import "HealthPackageDetailCellData.h"
#import "HealthPackageDetailCell.h"

@interface HealthPackageDetailVc : BaseSingleListVc <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *ctrlHeader;
//价格
@property (nonatomic, strong) UILabel *ctrlPrice;
//描述
@property (nonatomic, strong) UILabel *ctrlDesp;
//分隔线
@property (nonatomic, strong) UIView *ctrlLine;



@end
