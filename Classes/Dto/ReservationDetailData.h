/**
 *
 *  ReservationDetailData
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

@interface ReservationDetailData : NSObject

//体检号
@property (nonatomic, strong) NSString *peMasterId;
//体检中心名称
@property (nonatomic, strong) NSString *peisName;
//地址
@property (nonatomic, strong) NSString *address;
//电话
@property (nonatomic, strong) NSString *tel;
//套餐名称
@property (nonatomic, strong) NSString *packageName;
//套餐详情
@property (nonatomic, strong) NSString *packageDetail;
//预约时间
@property (nonatomic, strong) NSString *peDate;
//预约状态
@property (nonatomic, strong) NSString *statusText;
//预约状态代码
@property (nonatomic, strong) NSString *status;

//init
- (id)initWithObj:(NSDictionary *)obj;



@end
