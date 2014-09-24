/**
 *
 *  HealthPackageListCellData
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

@interface HealthPackageListCellData : NSObject

//套餐id
@property (nonatomic, strong) NSString *packageId;
//套餐名字
@property (nonatomic, strong) NSString *packageName;
//套餐价格
@property (nonatomic, strong) NSString *price;

- (id)initWithObj:(NSDictionary *)obj;



@end
