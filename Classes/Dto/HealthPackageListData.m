/**
 *
 *  HealthPackageData
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "HealthPackageListData.h"

@implementation HealthPackageListData

- (id)initWithObj:(NSDictionary *)obj {
    if (self = [super init]) {
        //默认------------------------------
        //体检中心名字
        self.peisName = kEmptyStr;
        //体检中心地址
        self.peisAddr = kEmptyStr;
        //体检中心电话
        self.peisPhone = kEmptyStr;
        //体检中心传真
        self.peisFax = kEmptyStr;
        //体检中心简介
        self.peisIntro = kEmptyStr;
        
        //转换------------------------------
        if (obj!=nil) {
            
        }
    }
    
	return self;
}



@end
