/**
 *
 * @author steven.yan
 *
 */
#import "BaseVC.h"
#import "LinkusAppDelegate.h"
#import "ChkUtil.h"
#import "QRCodeGenerator.h"
#import "CommonDefine.h"

@interface MySettingVC : BaseVC <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate>

//tv
@property (nonatomic, strong) UITableView *tableView;
//actionSheet
@property (nonatomic, strong) UIActionSheet *ctrlAs;
//img
@property (nonatomic, strong) UIImageView *ctrlImgView;
//条形码
@property (nonatomic, strong) UIView *ctrlQrView;

//userName
@property (nonatomic, strong) NSString *usrName;
//usrImg
@property (nonatomic, strong) UIImage *usrImg;



@end
