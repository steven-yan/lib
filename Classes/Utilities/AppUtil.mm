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

+ (void)appStoreRate {
    if (SysInfo.instance.isIos6Tag) {
        [AppUtil openUrl:kAppRateUrl];
    } else {
        [AppUtil openUrl:kAppDetailUrl];
    }
}

+ (void)appStoreUpdate {
    [AppUtil openUrl:kAppDetailUrl];
}

+ (void)openUrl:(NSString *)url {
    [[UIApplication sharedApplication]  openURL:[NSURL URLWithString:url]];
}



@end
