/**
 *
 *  HealthPackageDetailVc
 *  @author steven
 *  @date Sep 22 2014
 *
 **/

#import "HealthPackageDetailCellData.h"
#import "HealthPackageDetailCell.h"
#import "CSDatePicker.h"

@interface HealthPackageDetailVc : BaseSingleListVc <UITableViewDataSource, UITableViewDelegate, CSDatePickerDelegate>

@property (nonatomic, strong) UIView *ctrlHeader;
//名字
@property (nonatomic, strong) UILabel *ctrlName;
//价格
@property (nonatomic, strong) UILabel *ctrlPrice;
//描述
@property (nonatomic, strong) UILabel *ctrlDesp;
//分隔线
@property (nonatomic, strong) UIView *ctrlLine;
//dp
@property (nonatomic, strong) CSDatePicker *ctrlDatePicker;

//centerId
@property (nonatomic, strong) NSString *centerId;
//packageId
@property (nonatomic, strong) NSString *packageId;
//array
@property (nonatomic, strong) NSMutableArray *arrayOfItemGroup;



@end
