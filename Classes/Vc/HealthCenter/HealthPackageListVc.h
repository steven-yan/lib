/**
 *
 *  HealthPackageListVc
 *  @author steven
 *  @date Sep 22 2014
 *
 **/

#import "HealthPackageListData.h"
#import "HealthPackageListCell.h"
#import "CSDatePicker.h"

@interface HealthPackageListVc : BaseSingleListVc <UITableViewDataSource, UITableViewDelegate, HealthPackageListCellDelegate, CSDatePickerDelegate>

@property (nonatomic, strong) UIView *ctrlHeader;
//体检中心名字
@property (nonatomic, strong) UILabel *ctrlPeisName;
//体检中心地址
@property (nonatomic, strong) UILabel *ctrlPeisAddr;
//体检中心电话
@property (nonatomic, strong) UILabel *ctrlPeisPhone;
//体检中心传真
@property (nonatomic, strong) UILabel *ctrlPeisFax;
//体检中心简介
@property (nonatomic, strong) UILabel *ctrlPeisIntro;
//分隔线
@property (nonatomic, strong) UIView *ctrlLine;
//dp
@property (nonatomic, strong) CSDatePicker *ctrlDatePicker;

//params
@property (nonatomic, strong) NSDictionary *params;

//centerId
@property (nonatomic, strong) NSString *centerId;
//array
@property (nonatomic, strong) NSMutableArray *arrayOfCellData;
//selected index
@property (nonatomic) NSInteger selectedIndex;

//modifyTag
@property (nonatomic) bool modifyReservationTag;
//peMasterId
@property (nonatomic, strong) NSString *peMasterId;



@end
