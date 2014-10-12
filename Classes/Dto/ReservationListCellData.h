/**
 *
 *  ReservationListCellData
 *  @author steven.yan
 *  @date Otc 12 2014
 *
 **/

@interface ReservationListCellData : NSObject

//体检号
@property (nonatomic, strong) NSString *peMasterId;
//预约时间
@property (nonatomic, strong) NSString *peDate;
//体检中心
@property (nonatomic, strong) NSString *peisName;
//套餐名称
@property (nonatomic, strong) NSString *packageName;
//状态
@property (nonatomic, strong) NSString *statusText;

- (id)initWithObj:(NSDictionary *)obj;



@end
