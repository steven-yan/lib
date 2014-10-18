/**
 *
 *  HealthReportListCellData
 *  @author steven.yan
 *  @date Otc 14 2014
 *
 **/

@interface HealthReportListCellData : NSObject

//用户名
@property (nonatomic, strong) NSString *userName;
//体检号
@property (nonatomic, strong) NSString *peMasterId;
//预约时间
@property (nonatomic, strong) NSString *peDate;
//体检中心
@property (nonatomic, strong) NSString *peisName;

- (id)initWithObj:(NSDictionary *)obj;



@end
