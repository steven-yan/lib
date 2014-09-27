/**
 *
 * @author steven.yan
 *
 */

#import "ResetPwdVC.h"
#import <LinkusKit/LinkusKit.h>
#import "UserInfo.h"
#import "commonDefine.h"

@implementation ResetPwdVC
static int kLeftMargin = 15;
static int countDown = REQUEST_SMSCODE_TIMEOUT;



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
    [self changeTopTitle:@"忘记密码"];
    //隐藏左侧按键
    [self hideTopRightBtn];
    
    //内容面板-----------
    //添加手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.contentPanel addGestureRecognizer:singleTap];
    //用户名----------
    //tf
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(kLeftMargin, 10, self.contentPanel.width - kLeftMargin, 20)];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.returnKeyType = UIReturnKeyNext;
	tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.font = [UIFont systemFontOfSize:18];
    tf.placeholder = @"UID/手机号码";
    [tf setValue:[UIColor colorWithHexStr:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [tf setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    [self.contentPanel addSubview:tf];
    self.ctrlTfAccount = tf;
    
    //短信验证按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 30)];
    [btn setTitle:@"验证码"];
    [btn setTitleColor:[UIColor colorWithHexStr:@"#7f7f7f"]];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor colorWithHexStr:@"#7f7f7f"].CGColor;
	btn.layer.cornerRadius = 6;
    [btn addTarget:self action:@selector(valCodeBtnClicked:)];
    btn.right = tf.right - 10;
    btn.centerY = tf.centerY;
    [self.contentPanel addSubview:btn];
    self.ctrlCdBtn = btn;
    
    //分隔线
    UIView *line = [UIView lineWithWidth:tf.width];
    line.left = kLeftMargin;
    line.top = tf.bottom + 10;
    [self.contentPanel addSubview:line];

    //短信验证码----------
    //tf
    tf = [[UITextField alloc] initWithFrame:CGRectMake(kLeftMargin, line.bottom + 10, tf.width, 20)];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.returnKeyType = UIReturnKeyNext;
	tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.font = [UIFont systemFontOfSize:18];
    tf.placeholder = @"短信验证码";
    [tf setValue:[UIColor colorWithHexStr:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [tf setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    [self.contentPanel addSubview:tf];
    self.ctrlTfSMSCode = tf;
    //分隔线
    line = [[UIView alloc] initWithFrame:CGRectMake(kLeftMargin, tf.bottom + 10, tf.width, 1)];
    line.backgroundColor = [UIColor colorWithHexStr:@"#cccccc"];
    [self.contentPanel addSubview:line];

    //密码----------
    //tf
    tf = [[UITextField alloc] initWithFrame:CGRectMake(kLeftMargin, line.bottom + 10, tf.width, 20)];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
	tf.returnKeyType = UIReturnKeyNext;
    tf.font = [UIFont systemFontOfSize:18];
    tf.secureTextEntry = YES;
    tf.placeholder = @"新密码";
    [tf setValue:[UIColor colorWithHexStr:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [tf setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    [self.contentPanel addSubview:tf];
    self.ctrlTfPasswd = tf;
    //分隔线
    line = [[UIView alloc] initWithFrame:CGRectMake(kLeftMargin, tf.bottom + 10, tf.width, 1)];
    line.backgroundColor = [UIColor colorWithHexStr:@"#cccccc"];
    [self.contentPanel addSubview:line];
    
    //确认密码----------
    //tf
    tf = [[UITextField alloc] initWithFrame:CGRectMake(kLeftMargin, line.bottom + 10, tf.width, 20)];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
	tf.returnKeyType = UIReturnKeySend;
    tf.font = [UIFont systemFontOfSize:18];
    tf.secureTextEntry = YES;
    tf.placeholder = @"确认密码";
    [tf setValue:[UIColor colorWithHexStr:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [tf setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    [self.contentPanel addSubview:tf];
    self.ctrlTfCmfPasswd = tf;
    //分隔线
    line = [[UIView alloc] initWithFrame:CGRectMake(kLeftMargin, tf.bottom + 10, tf.width, 1)];
    line.backgroundColor = [UIColor colorWithHexStr:@"#cccccc"];
    [self.contentPanel addSubview:line];
    
    //注册
    btn = [[UIButton alloc] initWithFrame:CGRectMake(10, line.bottom + 25, self.contentPanel.width - 20, 40)];
    [btn setTitle:@"重置密码" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(resetPwdBtnClicked:)];
    btn.layer.cornerRadius = 6;
    btn.backgroundColor = [UIColor colorWithHexStr:@"#3ac0e6"];
    [self.contentPanel addSubview:btn];
    
    //底部面板-----------
    //其他--------------
    [self.topPanel bringToFont];
    [self.topMargin bringToFont];
    self.ctrlTfAccount.width -= 70;
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
}

//解析导航返回
- (void)onPraseNavBackParams:(NSDictionary *)params {
}

//窗体将要显示
- (void)onWillShow {
    //初始化countDown
    countDown = REQUEST_SMSCODE_TIMEOUT;
}

//窗体显示
- (void)onShow {
    [self.ctrlTfAccount becomeFirstResponder];
}

//导航栏------
- (void)topLeftBtnClicked {
    [self navBack];
}

- (void)topRightBtnClicked {
}

- (void)onWillHide {
    //取消计时器
    [self.ctrlTimer invalidate];
    [self hideKeyBoard];
}



#pragma mark -
#pragma mark ------textField delegate------
/*------------------------------------------------------------------------------
 |  textField
 |
 -----------------------------------------------------------------------------*/
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.ctrlTfAccount) {
    } else if (textField == self.ctrlTfSMSCode) {
    } else if (textField == self.ctrlTfPasswd) {
        [self setContentUp:YES];
    } else {
        [self setContentUp:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.ctrlTfAccount) {
        [self.ctrlTfSMSCode becomeFirstResponder];
    } else if (textField == self.ctrlTfSMSCode) {
        [self.ctrlTfPasswd becomeFirstResponder];
    } else if (textField == self.ctrlTfPasswd) {
        [self.ctrlTfCmfPasswd becomeFirstResponder];
    } else {
        if ([self chkUsrInfo]) {
            [self resetPassword];
        }
    }
    
    return YES;
}



#pragma mark -
#pragma mark -----------------LinkusDataRequestDelegate-------------------------
/*------------------------------------------------------------------------------
 |  LinkusDataRequestDelegate
 |
 -----------------------------------------------------------------------------*/
- (void)onResetPasswordSuccessForAccount:(NSString*)account andPassword:(NSString*)password {
	[UserInfo.instance setUsrPassword:password];
	[self showHudWithBottomHint:@"重置成功"];
	[self navBack];
}

- (void)onResetPasswordFailed:(NSString*)error forAccount:(NSString*)account {
	[self showHudWithBottomHint:[NSString stringWithFormat:@"重置失败: %@", error]];
}


- (void)onRequestSmsCodeSuccessForMobile:(NSString*)mobile {
	[self showHudWithBottomHint:@"请检查手机短信"];
}

- (void)onRequestSmsCodeFailed:(NSString*)error forMobile:(NSString*)mobile {
	[self showHudWithBottomHint:[NSString stringWithFormat:@"获得短信验证码失败: %@", error]];
	[self cancelCountingDown];
}



#pragma mark -
#pragma mark --------------------------其他--------------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)handleSingleTap:(UIGestureRecognizer *)singleTap {
    //重置面板
    [self reset];
}

- (void)reset {
    //隐藏面板
    [self hideKeyBoard];
    //恢复面板
    [self setContentUp:NO];
}

//3.5寸面板上移
- (void)setContentUp:(BOOL)upTag {
    if (SysInfo.instance.isIphone4Tag) {
        if (upTag && self.contentUpTag == NO) {
            [UIView animateWithDuration:0.2 animations:^{
                self.contentPanel.top -= 40;
            } completion:^(BOOL finished){
                self.contentUpTag = YES;
            }];
        } else if (upTag == NO && self.contentUpTag== YES) {
            [UIView animateWithDuration:0.2 animations:^{
                self.contentPanel.top += 40;
            } completion:^(BOOL finished){
                self.contentUpTag = NO;
            }];
        }
    }
}

- (void)valCodeBtnClicked:(UIButton *) btn {
    //重置面板
    [self reset];
	if (countDown < REQUEST_SMSCODE_TIMEOUT) return;
	
	[self hideKeyBoard];
	
	NSString *phoneNum = self.ctrlTfAccount.text;
    
    //检测手机号------
    if ([ChkUtil isEmptyStr:phoneNum]) {
        [self showHudWithBottomHint:@"手机号不能为空"];
        return;
    }
    
    //手机号匹配
    if ([phoneNum linkus_isValidMobile] == NO) {
        [self showHudWithBottomHint:@"手机号格式不正确"];
        return;
    }
	
    //初始化倒计时
	[self.ctrlCdBtn setTitle:[NSString stringWithFormat:@"%d", --countDown]];
    
    //计时器
    self.ctrlTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeScheduled:) userInfo:nil repeats:YES];
	
	[self requestSMSCode];
}

- (void)cancelCountingDown {
	//显示倒计时按钮
	[self.ctrlCdBtn setTitle:@"验证码"];
	//取消定时器
	countDown = REQUEST_SMSCODE_TIMEOUT;
	[self.ctrlTimer invalidate];
}

- (void)timeScheduled:(NSTimer *)timer {
    if (countDown <= 1) {
        [self cancelCountingDown];
    } else {
        //刷新计时器显示
        [self.ctrlCdBtn setTitle:[NSString stringWithFormat:@"%d", --countDown]];
    }
}

- (void)resetPwdBtnClicked:(UIButton *) btn {
    //重置面板
    [self reset];
    if ([self chkUsrInfo] == YES) {
        [self resetPassword];
    }
}

- (void)resetPassword
{
	NSString *smsCode = self.ctrlTfSMSCode.text;
	NSString *account = self.ctrlTfAccount.text;
	NSString* password = self.ctrlTfPasswd.text;
	
	[LINKUSKIT resetPassword:password forAccount:account withSmsCode:smsCode andDataDelegate:self];
}

- (BOOL)chkUsrInfo {
    NSString *phoneNum = self.ctrlTfAccount.text;
	NSString *smsCode = self.ctrlTfSMSCode.text;
    NSString *passWd = self.ctrlTfPasswd.text;
    NSString *cmfPassWd = self.ctrlTfCmfPasswd.text;
    
    //hideKeyBoard
    [self hideKeyBoard];
    
    //检测手机号------
    if ([ChkUtil isEmptyStr:phoneNum]) {
        [self showHudWithBottomHint:@"UID/手机号不能为空"];
        return NO;
    }
    
	if ([ChkUtil isEmptyStr:smsCode]) {
        [self showHudWithBottomHint:@"短信验证码不能为空"];
        return NO;
    }
    
    //检测密码-------
    if ([passWd isEqualToString:cmfPassWd] == NO) {
        [self showHudWithBottomHint:@"两次密码不一致"];
        return NO;
    }
    
    if ([passWd linkus_isValidPassword] == NO) {
        [self showHudWithBottomHint:@"密码格式错误，应该由字母、数字及*&@组成，至少6位长"];
        return NO;
    }
    
    return YES;
}

- (void)requestSMSCode
{
	NSString* mobile = self.ctrlTfAccount.text;
	[LINKUSKIT requestSmsCodeWithType:SMSCODE_TYPE_RESET_PASSWORD forMobile:mobile withDataDelegate:self];
}

- (void)hideKeyBoard {
    //手机号
    [self.ctrlTfAccount resignFirstResponder];
    //SMS Code
	[self.ctrlTfSMSCode resignFirstResponder];
    //密码
    [self.ctrlTfPasswd resignFirstResponder];
    //确认密码
    [self.ctrlTfCmfPasswd resignFirstResponder];
}



@end
