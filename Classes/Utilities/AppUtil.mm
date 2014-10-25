/**
 *
 *  AppUtil
 *  @author steven.yan
 *  @date Otc 10 2014
 *
 **/
#import "AppUtil.h"

@implementation AppUtil

+ (NSString *)fillUrl:(NSString *)res {
    return [kAppHost stringByAppendingString:res];
}

+ (NSString *)appVersion {
    return kAppVersion;
}

+ (void)appRate {
    if (SysInfo.instance.isIos6Tag) {
        [[UIApplication sharedApplication]  openURL:[NSURL URLWithString:kAppRateUrl]];
    } else {
        [[UIApplication sharedApplication]  openURL:[NSURL URLWithString:kAppDetailUrl]];
    }
}



@end
