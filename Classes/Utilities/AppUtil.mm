/**
 *
 *  AppUtil
 *  @author steven.yan
 *  @date Otc 10 2014
 *
 **/
#import "AppUtil.h"

@implementation AppUtil

+ (NSString *)healthUrl:(NSString *)res {
    if (kAppDebugTag) {
    } else {
    }
    return [kHealthHostName stringByAppendingString:res];
}



@end