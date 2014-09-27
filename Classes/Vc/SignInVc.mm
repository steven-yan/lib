/**
 *
 *  SignInVc
 *  @author steven
 *  @date Sep 27 2014
 *
 **/

#import "SignInVc.h"

@implementation SignInVc
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
    [self changeTopTitle:@"登录"];
    //隐藏左侧按键
    [self hideTopRightBtn];
    
    //内容面板-----------
    //用户名----------
    //tf
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(kLeftMargin, 15, self.contentPanel.width - kLeftMargin, 20)];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.returnKeyType = UIReturnKeyNext;
    tf.font = [UIFont systemFontOfSize:18];
    tf.placeholder = @"用户名/邮箱";
    [tf setValue:[UIColor colorWithHexStr:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [tf setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    [self.contentPanel addSubview:tf];
    self.ctrlTfAcc = tf;
    //分隔线
    UIView *line = [UIView lineWithWidth:tf.width];
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
    
    //注册
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, line.bottom + 25, self.contentPanel.width - 20, 40)];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(signUpBtnClicked:)];
    btn.layer.cornerRadius = 6;
    btn.backgroundColor = self.topPanel.backgroundColor;
    [self.contentPanel addSubview:btn];
    
    //忘记密码
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    [btn addTarget:self action:@selector(forgetPwdBtn:)];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitle:@"忘记密码?"];
    [btn setTitleColor:[UIColor colorWithHexStr:@"#b3b3b3"]];
    btn.top = 165;
    btn.right = self.contentPanel.width - 8;
    [self.contentPanel addSubview:btn];
    
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
    [self.ctrlTfAcc becomeFirstResponder];
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
    if (textField == self.ctrlTfAcc) {
        [self.ctrlTfPasswd becomeFirstResponder];
    } else if (textField == self.ctrlTfPasswd) {
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
    NSString *acc = self.ctrlTfAcc.text;
    NSString *pwd = self.ctrlTfPasswd.text;
    
    [self hideKeyBoard];
    
    //检测用户名------
    if ([ChkUtil isEmptyStr:acc]) {
        [self showToast:@"用户名/邮箱不能为空"];
        return NO;
    }
    
    //检测密码-------
    if ([ChkUtil isEmptyStr:pwd]) {
        [self showToast:@"密码不能为空"];
        return NO;
    }
    
    return YES;
}

- (void)forgetPwdBtn:(UIButton *)btn {
    [self navTo:@"ForgetPwdVc"];
}

//hide
- (void)hideKeyBoard {
    //用户名
    [self.ctrlTfAcc resignFirstResponder];
    //密码
    [self.ctrlTfPasswd resignFirstResponder];
}



@end