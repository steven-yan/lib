/**
 *
 * @author steven.yan
 *
 */

@interface RegisterVc : BaseLayoutVc <UIScrollViewDelegate, UITextFieldDelegate>

//scorllView
@property (nonatomic, strong) UIScrollView *ctrlSv;

//用户名
@property (nonatomic, strong) UITextField *ctrlTfAccount;
//手机号
@property (nonatomic, strong) UITextField *ctrlTfPhNum;
//倒计时按钮
@property (nonatomic, strong) UIButton *ctrlCdBtn;
//计时器
@property (nonatomic, strong) NSTimer *ctrlTimer;
//SMS Code
@property (nonatomic, strong) UITextField *ctrlTfSMSCode;
//密码
@property (nonatomic, strong) UITextField *ctrlTfPasswd;
//确认密码
@property (nonatomic, strong) UITextField *ctrlTfCmfPasswd;



@end
