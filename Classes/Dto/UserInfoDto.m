/**
 *
 *  UserInfoDto
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "UserInfoDto.h"

@implementation UserInfoDto

- (id)initWithObj:(NSDictionary *)obj {
    if (self = [super init]) {
        //默认----------------
        self.userState = LOGIN_STATE_NONE;
    }
    
	return self;
}



@end
