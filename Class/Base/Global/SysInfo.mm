/**
 *
 *@author steven.yan
 *
 **/

#import "SysInfo.h"

@implementation SysInfo


/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
+(instancetype)instance {
    static SysInfo *sysInfo = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sysInfo = [[self alloc] init];
    });
    
    return sysInfo;
}

//初始化
-(instancetype)init {
    if (self = [super init]) {
        self.topPanelHeight = 44;
        self.bottomPanelHeight = 49;
        self.bounds = CGRectZero;
        self.isIphone4Tag = NO;
        self.isIphone5Tag = NO;
        self.isIos7Tag = NO;
        
        //ios 版本号
        float version = [[UIDevice currentDevice] systemVersion].floatValue;
        self.iosVersion = version;
        if (version >= 7.0) {
            self.isIos7Tag = YES;
        }
        
        //设备信息
        CGRect rect = UIScreen.mainScreen.bounds;
        self.bounds = rect;
        if (rect.size.height < 568) {
            self.isIphone4Tag = YES;
        } else {
            self.isIphone5Tag = YES;
        }
        
        self.contentHeight = rect.size.height - self.topPanelHeight - 20;
    }
    
    return self;
}



@end
