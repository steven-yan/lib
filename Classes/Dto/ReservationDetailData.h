/**
 *
 *  HealthPackageData
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

@interface ReservationDetailData : NSObject

//体检中心名称
@property (nonatomic, strong) NSString *peisName;
//地址
@property (nonatomic, strong) NSString *addr;
//电话
@property (nonatomic, strong) NSString *phone;
//套餐名称
@property (nonatomic, strong) NSString *packageName;
//套餐详情
@property (nonatomic, strong) NSString *packageDetail;
//预约时间
@property (nonatomic, strong) NSString *date;
//预约状态
@property (nonatomic, strong) NSString *status;

- (id)initWithObj:(NSDictionary *)obj;



@end
