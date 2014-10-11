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
        //转换------------------------------
        if (obj!=nil) {
            //组合名称
            self.groupName = [obj valueForKey:@"itemGroupName"];
            //详情名字
            self.detail = [obj valueForKey:@"items"];
        }
        
        //容错------------------------------
        if ([ChkUtil isEmptyStr:self.groupName]) {
            self.groupName = kEmptyStr;
        }
        if ([ChkUtil isEmptyStr:self.detail]) {
            self.detail = kEmptyStr;
        }
    }
    
	return self;
}

- (void)unitTest {
    self.groupName = @"组合名称";
    self.detail = @"组合详情组合详情组合详情组合详情组合详情组合详情组合详情";
}



@end
