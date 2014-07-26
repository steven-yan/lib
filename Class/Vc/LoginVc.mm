/**
 *
 * @author steven.yan
 *
 */

#import "loginVC.h"

@implementation LoginVc
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
    [self changeTopTitle:@"登录"];
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
    
    //用户图片-----
    //账号--------
    //外框------
    UIButton *v = [[UIButton alloc] initWithFrame:CGRectMake(kLeftMargin, 50, self.view.width - kLeftMargin *  2, 40)];
    v.backgroundColor = [UIColor whiteColor];
    v.layer.cornerRadius = 6;
    [sv addSubview:v];
    //tf------
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, v.width - 10, 20)];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.returnKeyType = UIReturnKeyNext;
	tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.placeholder = @"用户名/手机号码";
    tf.font = [UIFont systemFontOfSize:18];
    [v addSubview:tf];
    self.ctrlTfAccount = tf;
    
    //密码--------
    //外框------
    v = [[UIButton alloc] initWithFrame:v.bounds];
    v.backgroundColor = [UIColor whiteColor];
    v.layer.cornerRadius = 6;
    v.top = 120;
    v.left = kLeftMargin;
    [sv addSubview:v];
    //tf------
    tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, v.width - 10, 20)];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
	tf.returnKeyType = UIReturnKeySend;
    tf.placeholder = @"密码";
    tf.secureTextEntry = YES;
    tf.font = [UIFont systemFontOfSize:18];
    [v addSubview:tf];
    self.ctrlTfPasswd = tf;
    
    //登录------
    UIButton *btn = [[UIButton alloc] initWithFrame:v.bounds];
    [btn addTarget:self action:@selector(loginBtnClicked:)];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    btn.layer.cornerRadius = 6;
    btn.backgroundColor = [UIColor colorWithHexStr:@"#0394e7"];
    btn.top = v.bottom + 30;
    btn.left = kLeftMargin;
    [sv addSubview:btn];
    
    //忘记密码
    btn = [[UIButton alloc] initWithFrame:CGRectMake(kLeftMargin, btn.bottom + 15, 150, 30)];
    [btn addTarget:self action:@selector(forgetPassWdBtnClicked:)];
    [btn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexStr:@"#c0c5c9"]];
	[btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sv addSubview:btn];
    
    //注册
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, btn.top, 150, 30)];
    [btn addTarget:self action:@selector(registerBtnClicked:)];
    [btn setTitle:@"注册" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexStr:@"#c0c5c9"]];
	[btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.right = v.right;
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
    //加载数据
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
    [self.ctrlSv setContentOffset:CGPointMake(0, 40)];
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
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)loginBtnClicked:(UIButton *)btn {
    [self login];
}

- (void)forgetPassWdBtnClicked:(UIButton *)btn {
	[self navTo:@"resetPasswordVC"];
}

- (void)registerBtnClicked:(UIButton *)btn {
    [self navTo:@"RegisterVc"];
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
        //添加提示
        [self showHudWithMsg:@"登录中..."];
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
