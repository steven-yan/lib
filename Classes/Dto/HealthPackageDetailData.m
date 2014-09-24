/**
 *
 *  HealthPackageDetailData
 *  @author steven.yan
 *  @date Sep 22 2014
 *
 **/

#import "HealthPackageDetailData.h"

@implementation HealthPackageDetailData

- (id)initWithObj:(NSMutableDictionary *)obj {
    if (self = [super init]) {
        //默认------------------------------
        //套餐名字
        self.packageName = kEmptyStr;
        //价格
        self.price = kEmptyStr;
        //描述
        self.description = kEmptyStr;
        
        //转换------------------------------
        if (obj!=nil) {
            
        }
    }
    
	return self;
}



@end
