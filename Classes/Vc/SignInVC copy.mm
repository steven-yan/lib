/**
 *
 *  SignInVC
 *  @author steven
 *  @date   July 24 2014
 *
 **/

#import "SignInVC.h"
#import "LinkusAppDelegate.h"
#import "CommonDefine.h"

@implementation SignInVC



#pragma mark -
#pragma mark ------------------------------窗体----------------------------------
/*------------------------------------------------------------------------------
 |  窗体
 |
 -----------------------------------------------------------------------------*/
//窗体创建
- (void)onCreate {
    self.view.backgroundColor = [UIColor colorWithHexStr:@"#3ac0e6"];
    
    //顶部面板-----------
    //标题栏
    [self hideTopPanel];
    //内容面板-----------
    //sv
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:self.contentPanel.bounds];
    sv.delegate = self;
    [sv setContentSize:CGSizeMake(self.contentPanel.width, self.contentPanel.height + 1)];
    [self.contentPanel addSubview:sv];
    self.ctrlSv = sv;
    //添加手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [sv addGestureRecognizer:singleTap];
    
    //用户图片-----
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    v.backgroundColor = [UIColor whiteColor];
    v.centerY = 115;
    v.centerX = self.view.centerX;
    v.layer.cornerRadius = v.width / 2;
    [sv addSubview:v];
    //登录图片
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 96, 96)];
    //设置默认背景图
    iv.center = v.center;
    iv.layer.cornerRadius = iv.width / 2;
    iv.layer.masksToBounds = YES;
    [sv addSubview:iv];
    self.ctrlUsrImg = iv;
    
    //账号--------
    UITextField *tfAcc = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 260, 40)];
    tfAcc.delegate = self;
    tfAcc.clearButtonMode = UITextFieldViewModeWhileEditing;
	tfAcc.returnKeyType = UIReturnKeyNext;
	tfAcc.keyboardType = UIKeyboardTypeNumberPad;
    tfAcc.placeholder = @"UID/手机号码";
    [tfAcc setValue:self.topPanel.backgroundColor forKeyPath:@"_placeholderLabel.textColor"];
    tfAcc.font = [UIFont systemFontOfSize:18];
    tfAcc.textAlignment = NSTextAlignmentCenter;
    tfAcc.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    tfAcc.layer.cornerRadius = 20;
    tfAcc.backgroundColor = [UIColor whiteColor];
    tfAcc.top = iv.bottom + 40;
    tfAcc.centerX = iv.centerX;
    [sv addSubview:tfAcc];
    self.ctrlTfAccount = tfAcc;
    
    //密码--------
    UITextField *tf = [[UITextField alloc] initWithFrame:tfAcc.bounds];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
	tf.returnKeyType = UIReturnKeySend;
    tf.placeholder = @"密码";
    [tf setValue:self.topPanel.backgroundColor forKeyPath:@"_placeholderLabel.textColor"];
    tf.secureTextEntry = YES;
    tf.font = [UIFont systemFontOfSize:18];
    tf.textAlignment = NSTextAlignmentCenter;
    tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    tf.layer.cornerRadius = 20;
    tf.backgroundColor = [UIColor whiteColor];
    tf.top = tfAcc.bottom + 15;
    tf.centerX = tfAcc.centerX;
    [sv addSubview:tf];
    self.ctrlTfPasswd = tf;
    
    //登录------
    UIButton *btn = [[UIButton alloc] initWithFrame:tf.bounds];
    [btn addTarget:self action:@selector(loginBtnClicked:)];
    [btn setTitle:@"登录"];
    [btn setTitleHlColor:[UIColor colorWithHexStr:@"#3ac0e6"]];
    [btn setStretchableBgImg:@"btn_signin_normal"];
    [btn setStretchableHlImg:@"btn_signin_pressed"];
    btn.top = tf.bottom + 15;
    btn.centerX = tf.centerX;
    [sv addSubview:btn];
    
    //忘记密码 - 自动登录
    //分隔线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 20)];
    line.backgroundColor = [UIColor whiteColor];
    line.centerX = btn.centerX;
    line.top = btn.bottom + 20;
    [sv addSubview:line];
    
    //忘记密码
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [btn addTarget:self action:@selector(resetPwdBtnClicked:)];
    [btn setTitle:@"忘记密码?"];
    [btn setTitleColor:[UIColor whiteColor]];
    [btn setFont:[UIFont systemFontOfSize:14]];
    [btn setTitleAlignment:NSTextAlignmentLeft];
    btn.centerY = line.centerY;
    btn.right = line.left - 10;
    [sv addSubview:btn];
    //hint iv
    
    //自动登录
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 85, 30)];
    [btn addTarget:self action:@selector(autoSignInBtnClicked:)];
    [btn setTitle:@"自动登录"];
    [btn setTitleColor:[UIColor whiteColor]];
    [btn setFont:[UIFont systemFontOfSize:14]];
    [btn setTitleAlignment:UIControlContentHorizontalAlignmentRight];
    btn.centerY = line.centerY;
    btn.left = line.right + 10;
    [sv addSubview:btn];
    
    iv = [[UIImageView alloc] initWithFrame:CGRectMake(2, 0, 25, 25)];
    [iv setImage:[UIImage imageNamed:@"checkbox_select"]];
    iv.centerY = btn.height / 2;
    [btn addSubview:iv];
    self.ctrlCbImg = iv;
    
    //注册----
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    [btn setTitle:@"还没有账号? 快速手机注册!"];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(signUpBtnClicked:)];
    btn.centerX = self.contentPanel.centerX;
    btn.bottom = self.contentPanel.height - 20;
    [sv addSubview:btn];
    //小细线
    v = [[UIView alloc] initWithFrame:CGRectMake(0, btn.bottom - 2, 26, 1)];
    v.backgroundColor = [UIColor whiteColor];
    v.right = btn.right - 19;
    [sv addSubview:v];
    
    //底部面板-----------
    //其他--------------
    self.autoSignInTag = YES;
	OBSERVE_NOTIFICATION(NN_LOGIN_RESPONSE, loginCallBack:);
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
}

//解析导航返回
- (void)onPraseNavBackParams:(NSDictionary *)params {
}

//窗体将要显示
- (void)onWillShow {
    //加载数据
    NSString *str = [UserInfo instance].usrMobile;
    NSString *pwd = [UserInfo instance].usrPassword;
    self.ctrlTfAccount.text = str;
    self.ctrlTfPasswd.text = pwd;
    
    //自动登录
    [self setAutoSignInHint];
    
    //头像
    UIImage *img = [LINKUSKIT getMyPhoto];
    if (img != nil) {
        [self.ctrlUsrImg setImage:img];
    } else {
        [self.ctrlUsrImg setImage:[UIImage imageNamed:@"user_avatar"]];
    }
}

//窗体显示
- (void)onShow {
}

//导航栏------
- (void)topLeftBtnClicked {
    [self navBack];
}

- (void)topRightBtnClicked {
}

- (void) dealloc {
    //删除通知
    REMOVE_NOTIFICATION;
}



#pragma mark -
#pragma mark ------------------------scrollView delegate---------------------------
/*---------------------------------------------------------------------------------
 |  scrollView
 |
 ---------------------------------------------------------------------------------*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self hideKeyBoard];
}



#pragma mark -
#pragma mark --------------------------textField delegate---------------------------
/*----------------------------------------------------------------------------------
 |  textField
 |
 ---------------------------------------------------------------------------------*/
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [self.ctrlSv setContentOffset:CGPointMake(0, 120)];
    [UIView commitAnimations];
    
    [textField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.ctrlTfAccount) {
        [self.ctrlTfPasswd becomeFirstResponder];
    } else {
        //登录
        [self login];
    }
    
    return YES;
}



#pragma mark -
#pragma mark --------------------------------网络callback--------------------------
/*-------------------------------------------------------------------------------
 |  网络callback
 |
 ------------------------------------------------------------------------------*/
- (void)loginCallBack:(NSNotification *)notify {
    NSString *state = [notify.object valueForKey:@"state"];
    
    if ([state boolValue]) {
        [self navBackTo:@"HomeVC" style:NavStyleTopToBottom];
    }
    
    //不自动登录
    if (self.autoSignInTag == NO) {
        [[UserInfo instance] cleanInfo];
    }
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)autoSignInBtnClicked:(UIButton *)btn {
    self.autoSignInTag = !self.autoSignInTag;
    [self setAutoSignInHint];
}

- (void)setAutoSignInHint {
    if (self.autoSignInTag) {
        [self.ctrlCbImg setImage:[UIImage imageNamed:@"checkbox_select"]];
    } else {
        [self.ctrlCbImg setImage:[UIImage imageNamed:@"checkbox_unselect"]];
    }
}

- (void)loginBtnClicked:(UIButton *)btn {
    //重置
    [self reset];
    //登录
    [self login];
}

- (void)resetPwdBtnClicked:(UIButton *)btn {
	[self navTo:@"ResetPwdVC"];
}

- (void)signUpBtnClicked:(UIButton *)btn {
    [self navTo:@"SignUpVC"];
}

- (void)handleSingleTap:(UIGestureRecognizer *)singleTap {
    //重置面板
    [self reset];
}

- (void)hideKeyBoard {
    //账号
    [self.ctrlTfAccount resignFirstResponder];
    //密码
    [self.ctrlTfPasswd resignFirstResponder];
}

- (BOOL)chkUsrInfo {
    NSString *account = self.ctrlTfAccount.text;
    NSString *passwd = self.ctrlTfPasswd.text;
    
    //hideKeyBoard
    [self hideKeyBoard];
    
    //检测账号------
    if ([ChkUtil isEmptyStr:account]) {
        [self showHudWithBottomHint:@"账号不能为空"];
        return NO;
    }
    //匹配账号
    if (![account linkus_isValidUID] &&
        ![account linkus_isValidMobile]) {
        [self showHudWithBottomHint:@"账号格式错误"];
        return NO;
    }
    
    //检测密码
    if ([ChkUtil isEmptyStr:passwd]) {
        [self showHudWithBottomHint:@"密码不能为空"];
        return NO;
    }
    
    return YES;
}

- (void)login {
	if ([self chkUsrInfo]) {
        //重置面板
        [self reset];
        
        NSString* account = self.ctrlTfAccount.text;
        NSString* password = self.ctrlTfPasswd.text;
        
        if ([account linkus_isValidMobile]) {
            [[UserInfo instance] setUsrMobile:account];
        } else {
            [[UserInfo instance] setUsrId:account];
        }
        [[UserInfo instance] setUsrPassword:password];
        
        account = [[UserInfo instance] getMyAccount];
        [LINKUSKIT connectLStreamWithAccount:account andPassword:password];
    }
}

//重置面板
- (void)reset {
    //动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    //恢复面板
    [self.ctrlSv setContentOffset:CGPointMake(0, 0)];
    //隐藏键盘
    [self hideKeyBoard];
    [UIView commitAnimations];
}



@end
