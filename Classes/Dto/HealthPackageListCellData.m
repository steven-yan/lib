/**
 *
 *  HealthPackageListCellData
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "HealthPackageListCellData.h"

@implementation HealthPackageListCellData

- (id)initWithObj:(NSDictionary *)obj {
    if (self = [super init]) {
        //默认------------------------------
        //套餐id
        self.packageId = kEmptyStr;
        //套餐名字
        self.packageName = kEmptyStr;
        //套餐价格
        self.price = kEmptyStr;;
        
        //转换------------------------------
        if (obj!=nil) {
            //套餐id
            self.packageId = [obj valueForKey:@"itemPackageId"];
            //套餐名字
            self.packageName = [obj valueForKey:@"itemPackageName"];
            //套餐价格
            self.price = [obj valueForKey:@"price"];;
        }
        
        //测试
//        [self unitTest];
    }
    
    
	return self;
}

- (void)unitTest {
    self.packageId = @"100";
    self.packageName = @"packageName";
    self.price = @"88";
}



@end
