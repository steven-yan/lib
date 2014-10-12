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

//userLoginId
@property (nonatomic, strong) NSString *userLoginId;
//userName
@property (nonatomic, strong) NSString *userName;
//mobile
@property (nonatomic, strong) NSString *mobile;
//email
@property (nonatomic, strong) NSString *email;
//sex
@property (nonatomic, strong) NSString *sex;
//marryStatus
@property (nonatomic, strong) NSString *marryStatus;
//cardType
@property (nonatomic, strong) NSString *cardType;
//cardNumber
@property (nonatomic, strong) NSString *cardNumber;
//photoPath
@property (nonatomic, strong) NSString *photoPath;

//init
- (id)initWithObj:(NSDictionary *)obj;
- (void)clear;



@end
