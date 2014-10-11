/**
 *
 *  HealthPackageListVc
 *  @author steven
 *  @date Sep 22 2014
 *
 **/

#import "HealthPackageListData.h"
#import "HealthPackageListCell.h"

@interface HealthPackageListVc : BaseSingleListVc <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *ctrlHeader;
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

@property (nonatomic, strong) NSString *centerId;

//array
@property (nonatomic, strong) NSMutableArray *arrayOfCellData;



@end
