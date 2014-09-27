/**
 *
 * @author steven.yan
 *
 */

@interface ResetPwdVC : BaseVC <UIScrollViewDelegate, UITextFieldDelegate, LinkusDataRequestDelegate>

//手机号/Uid
@property (nonatomic, strong) UITextField *ctrlTfAccount;
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

//上移tag
@property (nonatomic) BOOL contentUpTag;



@end
