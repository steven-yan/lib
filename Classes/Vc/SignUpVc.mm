/**
 *
 *  SignUpVc
 *  @author steven
 *  @date Sep 27 2014
 *
 **/

#import "SignUpVc.h"

@implementation SignUpVc
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
    //用户名----------
    //tf
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(kLeftMargin, 10, self.contentPanel.width - kLeftMargin, 20)];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.returnKeyType = UIReturnKeyNext;
    tf.font = [UIFont systemFontOfSize:18];
    tf.placeholder = @"用户名";
    [tf setValue:[UIColor colorWithHexStr:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [tf setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    [self.contentPanel addSubview:tf];
    self.ctrlTfUserName = tf;
    //分隔线
    UIView *line = [UIView lineWithWidth:tf.width];
    line.left = kLeftMargin;
    line.top = tf.bottom + 10;
    [self.contentPanel addSubview:line];

    //tf
    tf = [[UITextField alloc] initWithFrame:CGRectMake(kLeftMargin, line.bottom + 10, self.contentPanel.width - kLeftMargin, 20)];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.returnKeyType = UIReturnKeyNext;
    tf.font = [UIFont systemFontOfSize:18];
    tf.placeholder = @"邮箱";
    [tf setValue:[UIColor colorWithHexStr:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [tf setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    [self.contentPanel addSubview:tf];
    self.ctrlTfMail = tf;
    //分隔线
    line = [UIView lineWithWidth:tf.width];
    line.left = kLeftMargin;
    line.top = tf.bottom + 10;
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
    tf.placeholder = @"密码";
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
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, line.bottom + 25, self.contentPanel.width - 20, 40)];
    [btn setTitle:@"立即注册" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(signUpBtnClicked:)];
    btn.layer.cornerRadius = 6;
    btn.backgroundColor = self.topPanel.backgroundColor;
    [self.contentPanel addSubview:btn];
    
    //底部面板-----------
    //其他--------------
    [self.topPanel bringToFont];
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
    [self.ctrlTfUserName becomeFirstResponder];
}

//导航栏------
- (void)topLeftBtnClicked {
    [self navBack];
}

- (void)topRightBtnClicked {
}

- (void)onWillHide {
}

- (void)dealloc {
}



#pragma mark -
#pragma mark ------textField delegate------
/*------------------------------------------------------------------------------
 |  textField
 |
 -----------------------------------------------------------------------------*/
- (void)textFieldDidBeginEditing:(UITextField *)textField {
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.ctrlTfUserName) {
        [self.ctrlTfMail becomeFirstResponder];
    } else if (textField == self.ctrlTfMail) {
        [self.ctrlTfPasswd becomeFirstResponder];
    } else if (textField == self.ctrlTfPasswd) {
        [self.ctrlTfCmfPasswd becomeFirstResponder];
    }
    
    return YES;
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/

- (void)signUpBtnClicked:(UIButton *) btn {
    //reset
	[self reset];
    if ([self chkUsrInfo] == YES) {
//        [self usrRegister];
    }
}

- (void)reset {
    //隐藏面板
    [self hideKeyBoard];
}

- (BOOL)chkUsrInfo {
    NSString *user = self.ctrlTfUserName.text;
    NSString *mail = self.ctrlTfMail.text;
    NSString *pwd = self.ctrlTfPasswd.text;
    NSString *cmfPwd = self.ctrlTfCmfPasswd.text;
    
    //hideKeyBoard
    [self hideKeyBoard];
    
    //检测用户名------
    if ([ChkUtil isEmptyStr:user]) {
        [self showToast:@"用户名不能为空"];
        return NO;
    }
    
    //检测邮箱------
    if ([ChkUtil isEmptyStr:mail]) {
        [self showToast:@"邮箱不能为空"];
        return NO;
    }
    if ([ChkUtil isValidateEmail:mail] == NO) {
        [self showToast:@"邮箱格式不正确"];
        return NO;
    }
    
    //检测密码-------
    if ([ChkUtil isEmptyStr:pwd]) {
        [self showToast:@"密码不能为空"];
        return NO;
    }
    if (pwd.length < 6) {
        [self showToast:@"密码长度不能小于6位"];
        return NO;
    }
    
    if ([ChkUtil isEmptyStr:cmfPwd]) {
        [self showToast:@"确认密码不能为空"];
        return NO;
    }
    
    if ([pwd isEqualToString:cmfPwd] == NO) {
        [self showToast:@"两次密码不一致"];
        return NO;
    }
    
    return YES;
}

- (void)hideKeyBoard {
    //用户名
    [self.ctrlTfUserName resignFirstResponder];
    //手机号
    [self.ctrlTfMail resignFirstResponder];
    //密码
    [self.ctrlTfPasswd resignFirstResponder];
    //确认密码
    [self.ctrlTfCmfPasswd resignFirstResponder];
}



@end
