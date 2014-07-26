/**
 *
 * @author steven.yan
 *
 */

@interface LoginVc : BaseLayoutVc <UITextFieldDelegate, UIScrollViewDelegate>

//sv
@property (nonatomic, strong) UIScrollView *ctrlSv;
//用户图片
@property (nonatomic, strong) UIImageView *ctrlUsrImg;
//账号
@property (nonatomic, strong) UITextField *ctrlTfAccount;
//密码
@property (nonatomic, strong) UITextField *ctrlTfPasswd;



@end
