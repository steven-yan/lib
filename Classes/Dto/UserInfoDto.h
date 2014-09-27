/**
 *
 *  UserInfoDto
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

@interface UserInfoDto : NSObject
typedef enum {
    LOGIN_STATE_NONE = 100,
    LOGIN_STATE_NORMAL,
    LOGIN_STATE_AUTH,
} EN_LOGIN_STATE_T;

@property (nonatomic) EN_LOGIN_STATE_T userState;

//init
- (id)initWithObj:(NSDictionary *)obj;


@end
