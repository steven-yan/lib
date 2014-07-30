/**
 *
 *  RegisterVc
 *  @author steven
 *  @date July 23 2014
 *
 **/

#import "RegisterVc.h"

@implementation RegisterVc
static int kLeftMargin = 15;



#pragma mark -
#pragma mark ------------------------------窗体----------------------------------
/*------------------------------------------------------------------------------
 |  窗体
 |
 -----------------------------------------------------------------------------*/
//窗体创建
- (void)onCreate {
    //顶部面板-----------
    //标题栏
    [self changeTopTitle:@"注册"];
    //隐藏左侧按键
    [self hideTopRightBtn];
    
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
    
    //用户名----------
    //邮箱----------
    //外框
    UIButton *v = [[UIButton alloc] initWithFrame:CGRectMake(kLeftMargin, 24, self.view.width - kLeftMargin *  2, 40)];
    v.backgroundColor = [UIColor whiteColor];
    v.layer.cornerRadius = 6;
    [sv addSubview:v];
    //tf
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, v.width - 10, 20)];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.returnKeyType = UIReturnKeyNext;
    tf.font = [UIFont systemFontOfSize:18];
    tf.placeholder = @"用户名";
    [v addSubview:tf];
    self.ctrlTfAccount = tf;
    
    //外框 使用UIButton 防止误操作
    v = [[UIButton alloc] initWithFrame:CGRectMake(kLeftMargin, v.bottom + 24, self.view.width - kLeftMargin *  2, 40)];
    v.backgroundColor = [UIColor whiteColor];
    v.layer.cornerRadius = 6;
    [sv addSubview:v];
    //tf
    tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, v.width - 120, 20)];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.returnKeyType = UIReturnKeyNext;
	tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.font = [UIFont systemFontOfSize:18];
    tf.placeholder = @"手机号码";
    [v addSubview:tf];
    self.ctrlTfPhNum = tf;
    //短信验证按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 28)];
    btn.left = tf.right - 0;
    btn.centerY = tf.centerY;
	btn.layer.cornerRadius = 3;
    btn.backgroundColor = [UIColor colorWithHexStr:@"#0394e7"];
    [btn setTitle:@"短信验证码" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(valCodeBtnClicked:)];
    [v addSubview:btn];
    self.ctrlCdBtn = btn;
    
    //邮箱----------
    //外框
    v = [[UIButton alloc] initWithFrame:CGRectMake(kLeftMargin, v.bottom + 24, self.view.width - kLeftMargin *  2, 40)];
    v.backgroundColor = [UIColor whiteColor];
    v.layer.cornerRadius = 6;
    [sv addSubview:v];
    //tf
    tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, v.width - 10, 20)];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.returnKeyType = UIReturnKeyNext;
	tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.font = [UIFont systemFontOfSize:18];
    tf.placeholder = @"短信验证码";
    [v addSubview:tf];
    self.ctrlTfSMSCode = tf;
    
    //密码----------
    //外框 使用button 防止误操作
    v = [[UIButton alloc] initWithFrame:CGRectMake(kLeftMargin, v.bottom + 24, self.view.width - kLeftMargin *  2, 40)];
    v.backgroundColor = [UIColor whiteColor];
    v.layer.cornerRadius = 6;
    [sv addSubview:v];
    //tf
    tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, v.width - 10, 20)];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
	tf.returnKeyType = UIReturnKeyNext;
    tf.font = [UIFont systemFontOfSize:18];
    tf.secureTextEntry = YES;
    tf.placeholder = @"密码";
    [v addSubview:tf];
    self.ctrlTfPasswd = tf;
    
    //确认密码----------
    //外框
    v = [[UIButton alloc] initWithFrame:CGRectMake(kLeftMargin, v.bottom + 24, self.view.width - kLeftMargin *  2, 40)];
    v.backgroundColor = [UIColor whiteColor];
    v.layer.cornerRadius = 6;
    [sv addSubview:v];
    //tf
    tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, v.width - 10, 20)];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
	tf.returnKeyType = UIReturnKeySend;
    tf.font = [UIFont systemFontOfSize:18];
    tf.secureTextEntry = YES;
    tf.placeholder = @"确认密码";
    [v addSubview:tf];
    self.ctrlTfCmfPasswd = tf;
    
    //注册
    btn = [[UIButton alloc] initWithFrame:v.bounds];
    [btn setTitle:@"注册" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(registerBtnClicked:)];
    btn.layer.cornerRadius = 6;
    btn.backgroundColor = [UIColor colorWithHexStr:@"#0394e7"];
    btn.top = v.bottom + 30;
    btn.left = v.left;
    [sv addSubview:btn];
    
    //底部面板-----------
    //其他--------------
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
}

//解析导航返回
- (void)onPraseNavBackParams:(NSDictionary *)params {
}

//窗体将要显示
- (void)onWillShow {
}

//窗体显示
- (void)onShow {
}


//------导航栏
- (void)topLeftBtnClicked {
    [self navBack];
}

- (void)topRightBtnClicked {
}

- (void)onWillHide {
    //取消计时器
    [self.ctrlTimer invalidate];
}



#pragma mark -
#pragma mark ------scrollView delegate------
/*------------------------------------------------------------------------------
 |  scrollView
 |
 -----------------------------------------------------------------------------*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self hideKeyBoard];
}



#pragma mark -
#pragma mark ------textField delegate------
/*------------------------------------------------------------------------------
 |  textField
 |
 -----------------------------------------------------------------------------*/
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    //重置view
    if (textField == self.ctrlTfPasswd) {
        [self.ctrlSv setContentOffset:CGPointMake(0, 145)];
    } else if (textField == self.ctrlTfCmfPasswd) {
        [self.ctrlSv setContentOffset:CGPointMake(0, 145)];
    }
    
    [UIView commitAnimations];
    
    [textField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.ctrlTfPhNum) {
        [self.ctrlTfSMSCode becomeFirstResponder];
    } else if (textField == self.ctrlTfSMSCode) {
        [self.ctrlTfAccount becomeFirstResponder];
    } else if (textField == self.ctrlTfAccount) {
        [self.ctrlTfPasswd becomeFirstResponder];
    } else if (textField == self.ctrlTfPasswd) {
        [self.ctrlTfCmfPasswd becomeFirstResponder];
    } else {
        if ([self chkUsrInfo]) {
            [self usrRegister];
        }
    }
    
    return YES;
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)valCodeBtnClicked:(UIButton *) btn {
//	if (countDown < REQUEST_SMSCODE_TIMEOUT) return;
//	
//	NSString *phoneNum = self.ctrlTfPhNum.text;
//    
//    //检测手机号------
//    if ([ChkUtil isEmptyStr:phoneNum]) {
//        [self showHudWithHint:@"手机号不能为空"];
//        return;
//    }
//    //手机号匹配
//    if ([IDValidate isValidateMobile:phoneNum] == NO) {
//        [self showHudWithHint:@"手机号格式不正确"];
//        return;
//    }
//	
//    //初始化倒计时
//	self.ctrlCdBtn.backgroundColor = [UIColor grayColor];
//	[self.ctrlCdBtn setTitle:[NSString stringWithFormat:@"%d", --countDown]];
//    
//    //计时器
//    self.ctrlTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeScheduled:) userInfo:nil repeats:YES];
//	
//	[self requestSMSCode];
}

- (void)timeScheduled:(NSTimer *)timer {
//    if (countDown <= 1) {
//        //显示倒计时按钮
//		self.ctrlCdBtn.backgroundColor = [UIColor colorWithHexStr:@"#0394e7"];
//		[self.ctrlCdBtn setTitle:@"短信验证码"];
//        //取消定时器
//        countDown = REQUEST_SMSCODE_TIMEOUT;
//        [timer invalidate];
//    } else {
//        //刷新计时器显示
//        [self.ctrlCdBtn setTitle:[NSString stringWithFormat:@"%d", --countDown]];
//    }
}

- (void)registerBtnClicked:(UIButton *) btn {
    if ([self chkUsrInfo] == YES) {
        [self usrRegister];
    }
}

- (void)handleSingleTap:(UIGestureRecognizer *)singleTap {
    //动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    //恢复面板
    [self.ctrlSv setContentOffset:CGPointMake(0, 0)];
    //隐藏键盘
    [self hideKeyBoard];
    [UIView commitAnimations];
}

- (BOOL)chkUsrInfo {
//    NSString *phoneNum = self.ctrlTfPhNum.text;
//	NSString *smsCode = self.ctrlTfSMSCode.text;
//    NSString *email = self.ctrlTfAccount.text;
//    NSString *passWd = self.ctrlTfPasswd.text;
//    NSString *cmfPassWd = self.ctrlTfCmfPasswd.text;
    
    //hideKeyBoard
    [self hideKeyBoard];
    
    //检测手机号------
//    if ([ChkUtil isEmptyStr:phoneNum]) {
//        [self showHudWithBottomHint:@"手机号不能为空"];
//        return NO;
//    }
//    
//    //手机号匹配
//    if ([IDValidate isValidateMobile:phoneNum] == NO) {
//        [self showHudWithBottomHint:@"手机号格式不正确"];
//        return NO;
//    }
//	
//	if ([ChkUtil isEmptyStr:smsCode]) {
//        [self showHudWithBottomHint:@"短信验证码不能为空"];
//        return NO;
//    }
//    
//    //检测邮箱-------
//    if ([ChkUtil isEmptyStr:email]) {
//        if ([IDValidate isValidateEmail:email] == NO) {
//            [self showHudWithBottomHint:@"邮箱格式不正确"];
//        }
//    }
//    
//    //检测密码-------
//    if ([passWd isEqualToString:cmfPassWd] == NO) {
//        [self showHudWithBottomHint:@"两次密码不一致"];
//        return NO;
//    }
//    
//    if ([IDValidate isValidatePassword:passWd] == NO) {
//        [self showHudWithBottomHint:@"密码格式错误，应该由字母、数字及*&@组成，至少6位长"];
//        return NO;
//    }
    
    return YES;
}

- (void)usrRegister
{
    [self showHudWithMsg:@"注册中..."];
	
//	NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", URL_PREFIX, URL_REGISTER]];
//	__weak ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
//	[request addRequestHeader:@"User-Agent" value:@"SmartCollar by foolbear"];
//	[request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
//	[request setRequestMethod:@"POST"];
//	
//	NSString* mobile_number = self.ctrlTfPhNum.text;
//	NSString *smsCode = self.ctrlTfSMSCode.text;
//	NSString* email = self.ctrlTfAccount.text;
//	NSString* password = self.ctrlTfPasswd.text;
//	
//	NSData* password_data = [password dataUsingEncoding:NSUTF8StringEncoding];
//	NSString* password_md5 = [[password_data xmpp_md5Digest] xmpp_hexStringValue];
//	
//	NSDictionary *dictonary = [[NSMutableDictionary alloc] init];
//	[dictonary setValue:mobile_number forKey:@"mobile"];
//	[dictonary setValue:smsCode forKey:@"smscode"];
//	[dictonary setValue:email forKey:@"email"];
//	[dictonary setValue:password_md5 forKey:@"password"];
//	[dictonary setValue:password_md5 forKey:@"re_password"];
//	
//	SBJsonWriter *writer = [[SBJsonWriter alloc] init];
//	NSMutableData *data = [NSMutableData dataWithData:[writer dataWithObject:dictonary]];
//	[request setPostBody:data];
//	
//	[request setCompletionBlock:^{
//		NSString* response = [request responseString];
//		NSDictionary* dic = [[[SBJsonParser alloc]init] objectWithString:response];
//		NSString* error = [dic objectForKey:@"err"];
//		NSString* msg = [dic objectForKey:@"msg"];
//		NSLog(@"register response: %@, error=%@, msg=%@", response, error, msg);
//		if ([error intValue] == 0) {
//            [self showHudWithBottomHint:@"注册成功"];
//
//			[[UserInfo instance] setUsrMobile:mobile_number];
//			[[UserInfo instance] setUsrEmail:email];
//			[[UserInfo instance] setUsrPassword:password];
//			
//			// goto Main VC
//            //显示主界面
//            APPDELEGATE;
//            appDelegate.tabBarVc.selectedIndex = 0;
//			dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
//			dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//				[self dismissViewControllerAnimated:YES completion:nil];
//			});
//			
//			NSString* account = [[UserInfo instance] getMyAccount];
//			[appDelegate connectWithAccount:account];
//            
//		} else {
//            [self showHudWithBottomHint:@"注册失败"];
//		}
//	}];
//	[request setFailedBlock:^{
//		NSError* error = [request error];
//		NSLog(@"register error: %@", error);
//        [self showHudWithBottomHint:@"注册失败"];
//	}];
//	
//	[request startAsynchronous];
}

- (void)requestSMSCode
{
//	NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", URL_PREFIX, URL_REGISTER_SMSCODE]];
//	__weak ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
//	[request addRequestHeader:@"User-Agent" value:@"SmartCollar by foolbear"];
//	[request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
//	[request setRequestMethod:@"POST"];
//	
//	NSString* mobile_number = self.ctrlTfPhNum.text;
//	NSData* mobile_data = [mobile_number dataUsingEncoding:NSUTF8StringEncoding]; if (!mobile_data) return;
//	NSData* des = [CryptUtil desEncrypt:mobile_data withKey:ENCRYPT_KEY_SMSCODE]; if (!des) return;
//	NSString* base64 = [des xmpp_base64Encoded];
//	if (!base64 || [base64 length] == 0) return;
//	
//	NSDictionary *dictonary = [[NSMutableDictionary alloc] init];
//	[dictonary setValue:base64 forKey:@"mobile"];
//	
//	SBJsonWriter *writer = [[SBJsonWriter alloc] init];
//	NSMutableData *data = [NSMutableData dataWithData:[writer dataWithObject:dictonary]];
//	[request setPostBody:data];
//	
//	[request setCompletionBlock:^{
//		NSString* response = [request responseString];
//		NSDictionary* dic = [[[SBJsonParser alloc]init] objectWithString:response];
//		NSString* error = [dic objectForKey:@"err"];
//		NSString* msg = [dic objectForKey:@"msg"];
//		NSLog(@"sms code response: %@, error=%@, msg=%@", response, error, msg);
//		if ([error intValue] == 0) {
//			// succ
//		} else {
//            [self showHudWithBottomHint:@"获得短信验证码失败"];
//		}
//	}];
//	[request setFailedBlock:^{
//		NSError* error = [request error];
//		NSLog(@"request sms code error: %@", error);
//	}];
//	
//	[request startAsynchronous];
}

- (void)hideKeyBoard {
    //手机号
    [self.ctrlTfPhNum resignFirstResponder];
    //SMS Code
	[self.ctrlTfSMSCode resignFirstResponder];
    //邮箱
    [self.ctrlTfAccount resignFirstResponder];
    //密码
    [self.ctrlTfPasswd resignFirstResponder];
    //确认密码
    [self.ctrlTfCmfPasswd resignFirstResponder];
}

@end
