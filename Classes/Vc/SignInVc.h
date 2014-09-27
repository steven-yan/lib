/**
 *
 *  SignInVc
 *  @author steven
 *  @date Sep 27 2014
 *
 **/

@interface SignInVc : BaseLayoutVc <UIScrollViewDelegate, UITextFieldDelegate>

//scorllView
@property (nonatomic, strong) UIScrollView *ctrlSv;

//用户名
@property (nonatomic, strong) UITextField *ctrlTfAcc;
//密码
@property (nonatomic, strong) UITextField *ctrlTfPasswd;



@end
