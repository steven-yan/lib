/**
 *
 *  ForgetPwdVc
 *  @author steven
 *  @date Sep 27 2014
 *
 **/

@interface ForgetPwdVc : BaseLayoutVc <UIScrollViewDelegate, UITextFieldDelegate>

//scorllView
@property (nonatomic, strong) UIScrollView *ctrlSv;

//用户名
@property (nonatomic, strong) UITextField *ctrlTfAcc;
//密码
@property (nonatomic, strong) UITextField *ctrlTfPasswd;
//确认密码
@property (nonatomic, strong) UITextField *ctrlTfCmfPasswd;



@end
