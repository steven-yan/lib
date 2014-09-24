/**
 *
 *  HealthPackageData
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "HealthPackageListCellData.h"

@interface HealthPackageListData : NSObject

//peisName:””,
//address:””,
//tel:””,
//fax:””,
//introduction:””,

//体检中心名字
@property (nonatomic, strong) NSString *peisName;
//体检中心地址
@property (nonatomic, strong) NSString *peisAddr;
//体检中心电话
@property (nonatomic, strong) NSString *peisPhone;
//体检中心传真
@property (nonatomic, strong) NSString *peisFax;
//体检中心简介
@property (nonatomic, strong) NSString *peisIntro;
//套餐列表
@property (nonatomic, strong) NSMutableArray *arrayOfCellData;

- (id)initWithObj:(NSMutableDictionary *)obj;



@end
