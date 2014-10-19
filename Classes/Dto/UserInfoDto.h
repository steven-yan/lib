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

//loginID 用户昵称
@property (nonatomic, strong) NSString *loginID;
//userLoginId 数据库用户编号
@property (nonatomic, strong) NSString *userLoginId;
//userName
@property (nonatomic, strong) NSString *userName;
//userPwd
@property (nonatomic, strong) NSString *userPwd;
//mobile
@property (nonatomic, strong) NSString *mobile;
//email
@property (nonatomic, strong) NSString *email;
//sex 0 男， 1 女
@property (nonatomic, strong) NSString *sex;
//marryStatus  0 已婚， 1未婚
@property (nonatomic, strong) NSString *marryStatus;
//cardType   0 身份证 1 军官证
@property (nonatomic, strong) NSString *cardType;
//cardNumber
@property (nonatomic, strong) NSString *cardNumber;
//photoPath
@property (nonatomic, strong) NSString *photoPath;

//init
- (id)initWithObj:(NSDictionary *)obj;
- (NSDictionary *)transToObj;
- (void)save;
- (void)clear;



@end
