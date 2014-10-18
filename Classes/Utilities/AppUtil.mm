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
    return [kHealthHostName stringByAppendingString:res];
}



@end
