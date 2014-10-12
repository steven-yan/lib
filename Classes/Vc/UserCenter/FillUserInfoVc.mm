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
    
    //TODO: hint
//    头像非必填，手机邮箱二选一，其他都必填
    
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
