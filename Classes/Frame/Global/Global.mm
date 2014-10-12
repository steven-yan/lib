/**
 *
 *@author steven.yan
 *
 **/

#import "Global.h"

@implementation Global



/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
+(instancetype)instance {
    static Global *global = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        global = [[self alloc] init];
    });
    
    return global;
}

//初始化
-(instancetype)init {
    if (self = [super init]) {
        //sysInfo
        self.sysInfo = [SysInfo instance];
        //userInfo
        NSDictionary *obj = [Cache.instance readDicWithDir:kGlobalDir key:kGlobalKeyUser];
        self.userInfo = [[UserInfoDto alloc] initWithObj:obj];
    }
    
    return self;
}



@end
