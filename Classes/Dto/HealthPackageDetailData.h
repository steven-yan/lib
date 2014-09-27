/**
 *
 *  HealthPackageDetailData
 *  @author steven.yan
 *  @date Sep 22 2014
 *
 **/

#import "HealthPackageDetailCellData.h"

@interface HealthPackageDetailData : NSObject

//套餐名字
@property (nonatomic, strong) NSString *packageName;
//价格
@property (nonatomic, strong) NSString *price;
//描述
@property (nonatomic, strong) NSString *desp;
//套餐列表
@property (nonatomic, strong) NSMutableArray *arrayOfCellData;

- (id)initWithObj:(NSDictionary *)obj;



@end
