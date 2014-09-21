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
        //sys info
        self.sysInfo = [SysInfo instance];
    }
    
    return self;
}



@end
