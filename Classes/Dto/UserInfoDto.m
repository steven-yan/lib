/**
 *
 *  UserInfoDto
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "UserInfoDto.h"

@implementation UserInfoDto



#pragma mark -
#pragma mark ------------------------------初始---------------------------------
/*------------------------------------------------------------------------------
 |  初始
 |
 -----------------------------------------------------------------------------*/
- (id)initWithObj:(NSDictionary *)obj {
    if (self = [super init]) {
        //转换------------------------------
        if (obj!=nil) {
            //userLoginId
            self.userLoginId = [obj valueForKey:@"userLoginId"];
            //userName
            self.userName = [obj valueForKey:@"userName"];
            //mobile
            self.mobile = [obj valueForKey:@"mobile"];
            //email
            self.email = [obj valueForKey:@"email"];
            //sex
            self.sex = [obj valueForKey:@"sex"];
            //marryStatus
            self.marryStatus = [obj valueForKey:@"marryStatus"];
            //cardType
            self.cardType = [obj valueForKey:@"cardType"];
            //cardNumber
            self.cardNumber = [obj valueForKey:@"cardNumber"];
            //photoPath
            self.photoPath = [obj valueForKey:@"photoPath"];
        }
        
        //容错------------------------------
        //userLoginId
        self.userLoginId = [ChkUtil handleNil:self.userLoginId];
        //userName
        self.userName = [ChkUtil handleNil:self.userName];
        //mobile
        self.mobile = [ChkUtil handleNil:self.mobile];
        //email
        self.email = [ChkUtil handleNil:self.email];
        //sex
        self.sex = [ChkUtil handleNil:self.sex];
        //marryStatus
        self.marryStatus = [ChkUtil handleNil:self.marryStatus];
        //cardType
        self.cardType = [ChkUtil handleNil:self.cardType];
        //cardNumber
        self.cardNumber = [ChkUtil handleNil:self.cardNumber];
        //photoPath
        self.photoPath = [ChkUtil handleNil:self.photoPath];
        
        if ([ChkUtil isEmptyStr:self.userName]) {
            self.userState = LOGIN_STATE_NONE;
        } else if ([ChkUtil isEmptyStr:self.cardNumber]) {
            self.userState = LOGIN_STATE_NORMAL;
        } else {
            self.userState = LOGIN_STATE_AUTH;
        }
    }
    
	return self;
}



#pragma mark -
#pragma mark ------------------------------方法---------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/
- (void)clear {
    //userName
    self.userName = kEmptyStr;
    //mobile
    self.mobile = kEmptyStr;
    //email
    self.email = kEmptyStr;
    //sex
    self.sex = kEmptyStr;
    //marryStatus
    self.marryStatus = kEmptyStr;
    //cardType
    self.cardType = kEmptyStr;
    //cardNumber
    self.cardNumber = kEmptyStr;
    //photoPath
    self.photoPath = kEmptyStr;
    
    self.userState = LOGIN_STATE_NONE;
}



#pragma mark -
#pragma mark ------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/


@end
