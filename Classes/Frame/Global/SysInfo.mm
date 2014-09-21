/**
 *
 *@author steven.yan
 *
 **/

#import "SysInfo.h"



@implementation SysInfo

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
        self.topMarginHeight = 20;
        self.topPanelHeight = 44;
        self.bottomPanelHeight = 49;
        self.bounds = CGRectZero;
        self.isIphone4Tag = NO;
        self.isIphone5Tag = NO;
        self.isIos6Tag = NO;
        
        //ios 版本号
        float version = [[UIDevice currentDevice] systemVersion].floatValue;
        self.iosVersion = version;
        if (version < 7.0) {
            self.isIos6Tag = YES;
            self.topMarginHeight = 0;
        }
        
        //设备信息
        CGRect rect = UIScreen.mainScreen.bounds;
        self.fullWidth = rect.size.width;
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
