/**
 *
 *  FillUserInfoVc
 *  @author steven
 *  @date Sep 22 2014
 *
 **/

#import "FillUserInfoVc.h"

@implementation FillUserInfoVc
static int kLeftMargin = 15;
static int kFontSize = 15;



#pragma mark -
#pragma mark ------------------------------窗体----------------------------------
/*------------------------------------------------------------------------------
 |  窗体
 |
 -----------------------------------------------------------------------------*/
//窗体创建
- (void)onCreate {
    //顶部面板-----------
    [self changeTopTitle:@"完善信息"];
    [self hideTopRightBtn];
    
    //内容面板-----------
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    [self.contentPanel addGestureRecognizer:pan];
    //用户名------
    //hint----
    UILabel *l = [UILabel labelWithLeft:kLeftMargin Top:20 Width:80 Height:20 FontSize:kFontSize];
    l.text = @"姓名:";
    l.textColor = [UIColor grayColor];
    [self.contentPanel addSubview:l];
    //tf----
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(l.right, 0, self.contentPanel.width - l.right - 20, 20)];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.returnKeyType = UIReturnKeyNext;
    tf.font = [UIFont systemFontOfSize:kFontSize];
    [tf setValue:[UIColor colorWithHexStr:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [tf setValue:[UIFont systemFontOfSize:kFontSize] forKeyPath:@"_placeholderLabel.font"];
    tf.bottom = l.bottom;
    [self.contentPanel addSubview:tf];
    self.ctrlTfName = tf;
    //分隔线----
    UIView *line = [UIView lineWithWidth:tf.width];
    line.left = tf.left;
    line.top = tf.bottom;
    [self.contentPanel addSubview:line];
    
    //hint----
    l = [UILabel labelWithLeft:kLeftMargin Top:line.bottom + 20 Width:80 Height:20 FontSize:kFontSize];
    l.text = @"手机:";
    l.textColor = [UIColor grayColor];
    [self.contentPanel addSubview:l];
    //tf----
    tf = [[UITextField alloc] initWithFrame:CGRectMake(l.right, 0, self.contentPanel.width - l.right - 20, 20)];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.returnKeyType = UIReturnKeyNext;
    tf.font = [UIFont systemFontOfSize:kFontSize];
    [tf setValue:[UIColor colorWithHexStr:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [tf setValue:[UIFont systemFontOfSize:kFontSize] forKeyPath:@"_placeholderLabel.font"];
    tf.bottom = l.bottom;
    [self.contentPanel addSubview:tf];
    self.ctrlTfPhone = tf;
    //分隔线----
    line = [UIView lineWithWidth:tf.width];
    line.left = tf.left;
    line.top = tf.bottom;
    [self.contentPanel addSubview:line];

    //hint----
    l = [UILabel labelWithLeft:kLeftMargin Top:line.bottom + 20 Width:80 Height:20 FontSize:kFontSize];
    l.text = @"邮箱:";
    l.textColor = [UIColor grayColor];
    [self.contentPanel addSubview:l];
    //tf----
    tf = [[UITextField alloc] initWithFrame:CGRectMake(l.right, 0, self.contentPanel.width - l.right - 20, 20)];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.returnKeyType = UIReturnKeyNext;
    tf.font = [UIFont systemFontOfSize:kFontSize];
    [tf setValue:[UIColor colorWithHexStr:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [tf setValue:[UIFont systemFontOfSize:kFontSize] forKeyPath:@"_placeholderLabel.font"];
    tf.bottom = l.bottom;
    [self.contentPanel addSubview:tf];
    self.ctrlTfMail = tf;
    //分隔线----
    line = [UIView lineWithWidth:tf.width];
    line.left = tf.left;
    line.top = tf.bottom;
    [self.contentPanel addSubview:line];
    
    //性别------
    //hint----
    l = [UILabel labelWithLeft:kLeftMargin Top:line.bottom + 20 Width:80 Height:20 FontSize:kFontSize];
    l.text = @"性别:";
    l.textColor = [UIColor grayColor];
    [self.contentPanel addSubview:l];
    //证件----
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"男", @"女", nil]];
    segment.selectedSegmentIndex = 0;
    segment.tintColor = [UIColor generalColor];
    segment.left = line.left;
    segment.centerY = l.centerY;
    [self.contentPanel addSubview:segment];
    self.ctrlSegSex = segment;
    
    //婚姻------
    //hint----
    l = [UILabel labelWithLeft:kLeftMargin Top:segment.bottom + 20 Width:80 Height:20 FontSize:kFontSize];
    l.text = @"婚姻:";
    l.textColor = [UIColor grayColor];
    [self.contentPanel addSubview:l];
    //证件----
    segment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"已婚", @"未婚", nil]];
    segment.selectedSegmentIndex = 0;
    segment.tintColor = [UIColor generalColor];
    segment.left = line.left;
    segment.centerY = l.centerY;
    [self.contentPanel addSubview:segment];
    self.ctrlSegMarrage = segment;
    
    //证件类型------
    //hint----
    l = [UILabel labelWithLeft:kLeftMargin Top:segment.bottom + 20 Width:80 Height:20 FontSize:kFontSize];
    l.text = @"证件类型:";
    l.textColor = [UIColor grayColor];
    [self.contentPanel addSubview:l];
    //证件----
    segment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"身份证", @"军官证", nil]];
    segment.selectedSegmentIndex = 0;
    segment.tintColor = [UIColor generalColor];
    segment.left = line.left;
    segment.centerY = l.centerY;
    [self.contentPanel addSubview:segment];
    self.ctrlSegIdType = segment;
    
    //hint----
    l = [UILabel labelWithLeft:kLeftMargin Top:segment.bottom + 20 Width:80 Height:20 FontSize:kFontSize];
    l.text = @"证件号:";
    l.textColor = [UIColor grayColor];
    [self.contentPanel addSubview:l];
    //tf----
    tf = [[UITextField alloc] initWithFrame:CGRectMake(l.right, 0, self.contentPanel.width - l.right - 20, 20)];
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.returnKeyType = UIReturnKeyNext;
    tf.font = [UIFont systemFontOfSize:kFontSize];
    [tf setValue:[UIColor colorWithHexStr:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [tf setValue:[UIFont systemFontOfSize:kFontSize] forKeyPath:@"_placeholderLabel.font"];
    tf.bottom = l.bottom;
    [self.contentPanel addSubview:tf];
    self.ctrlTfId = tf;
    //分隔线----
    line = [UIView lineWithWidth:tf.width];
    line.left = tf.left;
    line.top = tf.bottom;
    [self.contentPanel addSubview:line];
    
    //登录
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, line.bottom + 25, self.contentPanel.width - 20, 40)];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cmfBtnClicked:)];
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

//窗体将要显示------
- (void)onWillShow {
    UserInfoDto *user = Global.instance.userInfo;
    self.ctrlTfName.text = user.userName;
    self.ctrlTfPhone.text = user.mobile;
    self.ctrlTfMail.text = user.email;
    if ([[user sex] boolValue]) {
        self.ctrlSegSex.selectedSegmentIndex = 1;
    }
    if ([[user marryStatus] boolValue]) {
        self.ctrlSegMarrage.selectedSegmentIndex = 1;
    }
    if ([[user cardType] boolValue]) {
        self.ctrlSegIdType.selectedSegmentIndex = 1;
    }
    self.ctrlTfId.text = user.cardNumber;
}

//窗体显示
- (void)onShow {
    [self.ctrlTfName becomeFirstResponder];
}

//隐藏------
- (void)onWillHide {
    [self.ctrlTfName resignFirstResponder];
}

//导航栏------
- (void)topLeftBtnClicked {
    [self navBack];
}

- (void)topRightBtnClicked {
}



#pragma mark -
#pragma mark --------------------------获取和提交数据-----------------------------
/*------------------------------------------------------------------------------
 |  获取和提交数据
 |
 -----------------------------------------------------------------------------*/
- (void)loadData {
    [self httpGet:[AppUtil fillUrl:@"userlogin.UserLoginPRC.filledPersonInfo.submit"]];
}

- (void)onHttpRequestSuccessObj:(NSDictionary *)obj {
    UserInfoDto *user = [[UserInfoDto alloc] initWithObj:nil];
    //设置值
    user.userLoginId = Global.instance.userInfo.userLoginId;
    //login
    user.loginID = Global.instance.userInfo.loginID;
    //userName
    user.userName = self.ctrlTfName.text;
    //userPwd
    user.userPwd = Global.instance.userInfo.userPwd;
    //mobile
    if ([ChkUtil isEmptyStr:self.ctrlTfPhone.text] == NO) {
        user.mobile = self.ctrlTfPhone.text;
    } else {
        user.mobile = Global.instance.userInfo.mobile;
    }
    
    //email
    if ([ChkUtil isEmptyStr:self.ctrlTfPhone.text] == NO) {
        user.email = self.ctrlTfMail.text;
    } else {
        user.email = Global.instance.userInfo.email;
    }
    //photo
    user.photoPath = Global.instance.userInfo.photoPath;
    //sex 0 男， 1 女
    user.sex = [NSString stringWithFormat:@"%ld", (long)self.ctrlSegSex.selectedSegmentIndex];
    //marryStatus  0 已婚， 1未婚
    user.marryStatus = [NSString stringWithFormat:@"%ld", (long)self.ctrlSegMarrage.selectedSegmentIndex];
    //cardType   0 身份证 1 军官证
    user.cardType = [NSString stringWithFormat:@"%ld", (long)self.ctrlSegIdType.selectedSegmentIndex];
    //cardNumber
    user.cardNumber = self.ctrlTfId.text;
    
    user.userState = LOGIN_STATE_AUTH;
    
    obj = [user transToObj];
    
    //存储用户信息
    [Cache.instance storeWithDir:kGlobalDir key:kGlobalKeyUser dic:obj];
    Global.instance.userInfo = user;
    
    [self showToast:@"完善信息成功"];
    
    [self navBack];
}

//完善参数
- (void)completeQueryParams {
    [self.queryParams setValue:Global.instance.userInfo.userLoginId forKey:@"userLoginId"];
    [self.queryParams setValue:self.ctrlTfName.text forKey:@"userName"];
    [self.queryParams setValue:self.ctrlTfPhone.text forKey:@"mobile"];
    [self.queryParams setValue:self.ctrlTfMail.text forKey:@"email"];
    [self.queryParams setValue:[NSString stringWithFormat:@"%ld", (long)self.ctrlSegSex.selectedSegmentIndex] forKey:@"sex"];
    [self.queryParams setValue:[NSString stringWithFormat:@"%ld", (long)self.ctrlSegMarrage.selectedSegmentIndex] forKey:@"marryStatus"];
    [self.queryParams setValue:[NSString stringWithFormat:@"%ld", (long)self.ctrlSegIdType.selectedSegmentIndex] forKey:@"cardType"];
    [self.queryParams setValue:Global.instance.userInfo.userLoginId forKey:@"cardNumber"];
}



#pragma mark -
#pragma mark -------------------------------tf----------------------------------
/*------------------------------------------------------------------------------
 |  tf
 |
 -----------------------------------------------------------------------------*/
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.ctrlTfMail) {
        [self.contentPanel setContentOffset:CGPointMake(0, self.ctrlTfPhone.top) animated:YES];
    } else if (textField == self.ctrlTfId) {
        [self.contentPanel setContentOffset:CGPointMake(0, self.ctrlSegSex.top) animated:YES];
    } else {
        [self.contentPanel setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)cmfBtnClicked:(UIButton *)btn {
    if ([self chkInfo]) {
        [self loadData];
    }
}

- (BOOL)chkInfo {
    //用户名
    if ([ChkUtil isEmptyStr:self.ctrlTfName.text]) {
        [self showToast:@"请填写姓名"];
        return NO;
    }
    
    //手机邮箱可二选一
    if ([ChkUtil isEmptyStr:self.ctrlTfPhone.text] && [ChkUtil isEmptyStr:self.ctrlTfMail.text]) {
        [self showToast:@"手机邮箱可二选一"];
        return NO;
    }
    if ([ChkUtil isEmptyStr:self.ctrlTfPhone.text] == NO) {
        if ([ChkUtil isValidPhoneNum:self.ctrlTfPhone.text] == NO) {
            [self showToast:@"手机号格式不正确"];
            return NO;
        }
    }
    if ([ChkUtil isEmptyStr:self.ctrlTfMail.text] == NO) {
        if ([ChkUtil isValidEmail:self.ctrlTfMail.text] == NO) {
            [self showToast:@"邮箱格式不正确"];
            return NO;
        }
    }
    
    if ([ChkUtil isEmptyStr:self.ctrlTfId.text]) {
        [self showToast:@"证件号不能为空"];
        return NO;
    }
    
    return YES;
}

- (void)panned:(UIPanGestureRecognizer *)pan {
    //reset
    [self reset];
}

- (void)reset {
    //隐藏键盘
    [self hideKeyBoard];
    //恢复偏移
    [self.contentPanel setContentOffset:CGPointZero animated:YES];
}

- (void)hideKeyBoard {
    [self.ctrlTfName resignFirstResponder];
    [self.ctrlTfPhone resignFirstResponder];
    [self.ctrlTfMail resignFirstResponder];
    [self.ctrlTfId resignFirstResponder];
}



@end
