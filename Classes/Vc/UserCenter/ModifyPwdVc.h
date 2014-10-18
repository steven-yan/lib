/**
 *
 *  ModifyPwdVc
 *  @author steven
 *  @date Otc 18 2014
 *
 **/

@interface ModifyPwdVc : BaseLayoutVc <UIScrollViewDelegate, UITextFieldDelegate>

//scorllView
@property (nonatomic, strong) UIScrollView *ctrlSv;

//用户名
@property (nonatomic, strong) UITextField *ctrlTfOldPwd;
//密码
@property (nonatomic, strong) UITextField *ctrlTfPwd;
//确认密码
@property (nonatomic, strong) UITextField *ctrlTfCmfPwd;



@end
