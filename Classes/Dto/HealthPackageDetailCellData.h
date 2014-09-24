/**
 *
 *  HealthPackageDetailCellData
 *  @author steven.yan
 *  @date Sep 22 2014
 *
 **/

@interface HealthPackageDetailCellData : NSObject

//组合名称
@property (nonatomic, strong) NSString *groupName;
//详情名字
@property (nonatomic, strong) NSString *detail;

- (id)initWithObj:(NSMutableDictionary *)obj;



@end
