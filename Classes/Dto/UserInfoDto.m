/**
 *
 *  UserInfoDto
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "UserInfoDto.h"

@implementation UserInfoDto

//WANGCHENGDING


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
            //loginID 用户昵称
            self.loginID = [obj valueForKey:@"loginID"];
            //userLoginId
            self.userLoginId = [obj valueForKey:@"userLoginId"];
            //userName
            self.userName = [obj valueForKey:@"userName"];
            
            //userPwd
            self.userPwd = [obj valueForKey:@"userPwd"];
            
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
        //loginID 用户昵称
        self.loginID = [ChkUtil handleNil:self.loginID];
        //userLoginId
        self.userLoginId = [ChkUtil handleNil:self.userLoginId];
        //userName
        self.userName = [ChkUtil handleNil:self.userName];
        
        //userPwd
        self.userPwd = [ChkUtil handleNil:self.userPwd];
        
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
        
        if ([ChkUtil isEmptyStr:self.userLoginId]) {
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
- (NSDictionary *)transToObj {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setValue:self.loginID forKey:@"loginID"];
    [dic setValue:self.userLoginId forKey:@"userLoginId"];
    [dic setValue:self.userName forKey:@"userName"];
    [dic setValue:self.userPwd forKey:@"userPwd"];
    [dic setValue:self.mobile forKey:@"mobile"];
    [dic setValue:self.email forKey:@"email"];
    [dic setValue:self.sex forKey:@"sex"];
    [dic setValue:self.marryStatus forKey:@"marryStatus"];
    [dic setValue:self.cardType forKey:@"cardType"];
    [dic setValue:self.cardNumber forKey:@"cardNumber"];
    [dic setValue:self.photoPath forKey:@"photoPath"];
    
    return dic;
}

- (void)save {
    NSDictionary *obj = [self transToObj];
    //存储用户信息
    [Cache.instance storeWithDir:kGlobalDir key:kGlobalKeyUser dic:obj];
}

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
