/**
 *
 *  @author steven.yan
 *  @date   June 23 2014
 *
 **/
#import "SysInfo.h"
#import "UserInfoDto.h"

@interface Global : NSObject


+ (Global *)instance;

//sysInfo
@property (nonatomic, strong) SysInfo *sysInfo;
//userInfo
@property (nonatomic, strong) UserInfoDto *userInfo;



@end
