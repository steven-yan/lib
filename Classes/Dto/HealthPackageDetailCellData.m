/**
 *
 *  HealthPackageDetailCellData
 *  @author steven.yan
 *  @date Sep 22 2014
 *
 **/

#import "HealthPackageDetailCellData.h"

@implementation HealthPackageDetailCellData

- (id)initWithObj:(NSDictionary *)obj {
    if (self = [super init]) {
        //默认------------------------------
        //组合名称
        self.groupName = kEmptyStr;
        //详情名字
        self.detail = kEmptyStr;
        
        //转换------------------------------
        if (obj!=nil) {
            
        }
        
        //测试
        [self unitTest];
    }
    
	return self;
}

- (void)unitTest {
    self.groupName = @"组合名称";
    self.detail = @"组合详情组合详情组合详情组合详情组合详情组合详情组合详情";
}

@end
