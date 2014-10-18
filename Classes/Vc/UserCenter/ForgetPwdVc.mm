/**
 *
 *  ForgetPwdVc
 *  @author steven
 *  @date Sep 27 2014
 *
 **/

#import "ForgetPwdVc.h"

@implementation ForgetPwdVc
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
    [self changeTopTitle:@"忘记密码"];
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
    tf.placeholder = @"登录名或证件号";
    [tf setValue:[UIColor colorWithHexStr:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [tf setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    [self.contentPanel addSubview:tf];
    self.ctrlTfAcc = tf;
    //分隔线
    UIView *line = [UIView lineWithWidth:tf.width];
    line.left = kLeftMargin;
    line.top = tf.bottom + 10;
    [self.contentPanel addSubview:line];
    
    //手机或邮箱----------
    //tf
    tf = [[UITextField alloc] initWithFrame:CGRectMake(kLeftMargin, line.bottom + 10, tf.width, 20)];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
	tf.returnKeyType = UIReturnKeyNext;
    tf.font = [UIFont systemFontOfSize:18];
    tf.placeholder = @"手机或邮箱";
    [tf setValue:[UIColor colorWithHexStr:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [tf setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    [self.contentPanel addSubview:tf];
    self.ctrlTfAuth = tf;
    //分隔线
    line = [UIView lineWithWidth:tf.width];
    line.left = kLeftMargin;
    line.top = tf.bottom + 10;
    [self.contentPanel addSubview:line];
    
    //重置密码
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, line.bottom + 25, self.contentPanel.width - 20, 40)];
    [btn setTitle:@"重置密码" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(resetPwdBtnClicked:)];
    btn.layer.cornerRadius = 6;
    btn.backgroundColor = self.topPanel.backgroundColor;
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
#pragma mark --------------------------获取和提交数据-----------------------------
/*------------------------------------------------------------------------------
 |  获取和提交数据
 |
 -----------------------------------------------------------------------------*/
- (void)loadData {
    [self httpGet:[AppUtil healthUrl:@"userlogin.UserLoginPRC.forgot.submit"]];
}

- (void)onHttpRequestSuccessObj:(NSDictionary *)dic {
    [self showToast:@"重置成功,请检查邮箱"];
}

//完善参数
- (void)completeQueryParams {
    [self.queryParams setValue:self.ctrlTfAcc.text forKey:@"loginIDOrCardNumber"];
    [self.queryParams setValue:self.ctrlTfAuth.text forKey:@"mobileOrEmail"];
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
        [self.ctrlTfAuth becomeFirstResponder];
    }
    
    return YES;
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)resetPwdBtnClicked:(UIButton *) btn {
    //reset
	[self reset];
    if ([self chkUsrInfo] == YES) {
        [self loadData];
    }
}

- (void)reset {
    //隐藏面板
    [self hideKeyBoard];
}

- (BOOL)chkUsrInfo {
    NSString *acc = self.ctrlTfAcc.text;
    NSString *auth = self.ctrlTfAuth.text;
    
    [self hideKeyBoard];
    
    //检测用户名------
    if ([ChkUtil isEmptyStr:acc]) {
        [self showToast:@"用户名/邮箱不能为空"];
        return NO;
    }
    
    //检测手机-------
    if ([ChkUtil isEmptyStr:auth]) {
        [self showToast:@"手机或邮箱"];
        return NO;
    }
    if (!([ChkUtil isValidEmail:auth] || [ChkUtil isValidPhoneNum:auth])) {
        [self showToast:@"手机或邮箱格式不正确"];
        return NO;
    }
    
    return YES;
}

//hide
- (void)hideKeyBoard {
    //用户名
    [self.ctrlTfAcc resignFirstResponder];
    [self.ctrlTfAuth resignFirstResponder];
}



@end
