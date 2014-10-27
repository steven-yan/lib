/**
 *
 *  RootUserCenter
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "RootUserCenter.h"

@implementation RootUserCenter
enum {
    //btn
    kBtnSignUpTag = 100,
    kBtnSignInTag,
    kBtnSettingTag,
    kBtnRateAppTag,
    kBtnUpdateTag,
    kBtnCounselInfoTag,
    kBtnFillUserInfoTag,
    kBtnModifyPwdTag,
    kBtnUserImgTag,
    kBtnMkOrderTag,
    kBtnHealthReportTag,
    
    //alert
    kAlertLogOutTag,
    kAlertUpdateTag,
    
    //http
    kHttpUpdateTag,
    kHttpPostUserImgTag,
};



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithVc:(BaseLayoutVc *)vc {
    if (self = [super initWithVc:vc frame:vc.contentPanel.bounds]) {
        //页面------
        //控件------
        UITableView *tv = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tv.dataSource = self;
        tv.delegate = self;
        tv.showsVerticalScrollIndicator = NO;
        tv.separatorStyle = UITableViewCellSeparatorStyleNone;
        tv.backgroundColor = [UIColor whiteColor];
        [self addSubview:tv];
        self.ctrlTableView = tv;
        
        //数据------
        //其他------
    }
    
    return self;
}

- (void)onWillShow {
    [self.nrVc changeTopTitle:@"个人中心"];
    //登录状态
    self.userState = Global.instance.userInfo.userState;
    //刷新
    [self.ctrlTableView reloadData];
}

- (void)onWillHide {
}

- (void)reloadPanel {
    //登录状态
    self.userState = Global.instance.userInfo.userState;
    //刷新
    [self.ctrlTableView reloadData];
}



#pragma mark -
#pragma mark --------------------------获取和提交数据-----------------------------
/*------------------------------------------------------------------------------
 |  获取和提交数据
 |
 -----------------------------------------------------------------------------*/
- (void)loadData:(NSInteger)tag {
    if (tag == kHttpUpdateTag) {
        [self httpGet:[AppUtil fillUrl:@"pubreference.PubReferencePRC.upgrade.submit"]];
    } else if (tag == kHttpPostUserImgTag) {
//        [self httpGet:[AppUtil fillUrl:@"userlogin.UserLoginPRC.imageUpload.submit"]];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"userlogin.UserLoginPRC.imageUpload.submit?userLoginId=%@", Global.instance.userInfo.userLoginId]];
        ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:url];
        [req addRequestHeader:@"Content-Type" value:@"image/png"];
        [req setTimeOutSeconds:60];
        [req setRequestMethod:@"POST"];
        
        //[Request setPostValue:auth forKey:@"auth"];
        UIImage *img = [UIImage scaleImg:self.image toSize:CGSizeMake(300, 300)];
        [req setData:[Global.instance.userInfo.userLoginId dataUsingEncoding:NSUTF8StringEncoding] forKey:@"userLoginId"];
        [req setData:[GTMBase64 encodeData:UIImagePNGRepresentation(img)] forKey:@"image"];
        
        [req setCompletionBlock:^{
            
        }];
        
        [req setFailedBlock:^{
            NSString *str = [req responseString];
            
        }];
        
        [req startSynchronous];
    }
}

- (void)onHttpRequestSuccessObj:(NSDictionary *)obj {
    NSString *version = [obj valueForKey:@"version"];
    if (version && [version isEqualToString:[AppUtil appVersion]] == NO) {
        [self alertWithTitle:@"提示" cancel:@"取消" msg:@"应用有更新" cmfTitle:@"更新" tag:kAlertUpdateTag];
    } else {
        [self.nrVc showToast:@"已是最新版"];
    }
}

- (void)onHttpRequestFailed:(EnHttpRequestFailed)err hint:(NSString *)hint tag:(NSInteger)tag {
}

//完善参数
- (void)completeQueryParams:(NSInteger)tag {
    if (tag == kHttpUpdateTag) {
        [self.queryParams setValue:@"IOS" forKey:@"appType"];
        [self.queryParams setValue:[AppUtil appVersion] forKey:@"version"];
    } else if (tag == kHttpPostUserImgTag) {
//        userLoginId				用户编号
//        image				图片数据流字符串
        [self.queryParams setValue:Global.instance.userInfo.userLoginId forKey:@"userLoginId"];
        [self.queryParams setValue:[AppUtil appVersion] forKey:@"image"];
    }
}



#pragma mark -
#pragma mark ------------------------------方法----------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/



#pragma mark -
#pragma mark ------------------------------tableView----------------------------------
/*------------------------------------------------------------------------------
 |  tableView
 |
 -----------------------------------------------------------------------------*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.userState == LOGIN_STATE_NONE) {
        return 2;
    }
//    else if (self.userState == LOGIN_STATE_NORMAL) {
//        return 4;
//    }
    else {
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    CGFloat height = 0;
    
    if (self.userState == LOGIN_STATE_NONE) {
        if (row == 0) {
            height = 160;
        } else {
            height = 120;
        }
    } else {
        if (row == 0) {
            height = 100;
        } else if (row == 1) {
            height = 220;
        } else if (row == 2){
            height = 160;
        } else if (row == 3) {
            height = 80;
        }
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.width = self.nrVc.contentPanel.width;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.userState == LOGIN_STATE_NONE) {
        if (row == 0) {
            //注册
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 60, 150, 55)];
            [btn addTarget:self action:@selector(btnClicked:)];
            [btn setImage:[UIImage imageNamed:@"btn_signup_normal"] forState:UIControlStateNormal];
            btn.tag = kBtnSignUpTag;
            btn.right = self.width / 2 - 5;
            [cell addSubview:btn];
            //登录
            btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 60, 150, 55)];
            [btn addTarget:self action:@selector(btnClicked:)];
            [btn setImage:[UIImage imageNamed:@"btn_signin_normal"] forState:UIControlStateNormal];
            btn.tag = kBtnSignInTag;
            btn.left = self.width / 2 + 5;
            [cell addSubview:btn];
        } else {
            [self createAdditonCell:cell];
        }
    } else {
        if (row == 0) {
            [self createUserImgCell:cell title:Global.instance.userInfo.loginID];
        } else if (row == 1) {
            //背景----
            UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(10, 20, cell.width - 20, 200)];
            [bg setStyleForSection];
            [cell addSubview:bg];
            
            //完善信息----
            UIButton *btn = [UIButton btnCellWithTitle:@"我的信息" image:@"ucenter_icon_member_card"];
            [btn addTarget:self action:@selector(btnClicked:)];
            btn.tag = kBtnFillUserInfoTag;
            [bg addSubview:btn];
            //分隔线----
            UIView *line = [UIView lineWithWidth:btn.width];
            line.bottom = btn.height;
            [btn addSubview:line];
            
            //我的咨询----
            btn = [UIButton btnCellWithTitle:@"我的咨询" image:@"ucenter_icon_help"];
            [btn addTarget:self action:@selector(btnClicked:)];
            btn.tag = kBtnCounselInfoTag;
            btn.top = btn.height;
            [bg addSubview:btn];
            //分隔线----
            line = [UIView lineWithWidth:btn.width];
            line.bottom = btn.height;
            [btn addSubview:line];
            
            //预约----
            btn = [UIButton btnCellWithTitle:@"我的预约" image:@"ucenter_icon_about_mem"];
            [btn addTarget:self action:@selector(btnClicked:)];
            btn.tag = kBtnMkOrderTag;
            btn.top = btn.height*2;
            [bg addSubview:btn];
            //分隔线----
            line = [UIView lineWithWidth:btn.width];
            line.bottom = btn.height;
            [btn addSubview:line];
            
            //体检报告----
            btn = [UIButton btnCellWithTitle:@"体检报告" image:@"ucenter_icon_news"];
            [btn addTarget:self action:@selector(btnClicked:)];
            btn.tag = kBtnHealthReportTag;
            btn.top = btn.height * 3;
            [bg addSubview:btn];
            //分隔线----
            line = [UIView lineWithWidth:btn.width];
            line.bottom = btn.height;
            [btn addSubview:line];
            
            //修改密码----
            btn = [UIButton btnCellWithTitle:@"修改密码" image:@"ucenter_icon_lock"];
            [btn addTarget:self action:@selector(btnClicked:)];
            btn.tag = kBtnModifyPwdTag;
            btn.top = btn.height*4;
            [bg addSubview:btn];
            
            [bg addSubview:btn];
        } else if (row == 2) {
            [self createAdditonCell:cell];
        } else if (row == 3) {
            //退出登录
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, cell.width - 20, 40)];
            [btn setTitle:@"退出" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(logOutBtnClicked:)];
            btn.layer.cornerRadius = 6;
            btn.backgroundColor = [UIColor colorWithHexStr:@"#f1271a"];
            btn.centerY = cell.height / 2;
            [cell addSubview:btn];
        }
    }
    
    return cell;
}



#pragma mark -
#pragma mark ---------------------------actionSheetDelegate---------------------
/*------------------------------------------------------------------------------
 |  actionSheetDelegate
 |
 -----------------------------------------------------------------------------*/
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex >= 2) {
        return;
    }
    
    //设置 UIImagePickerController
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    NSString *str = nil;
    BOOL flag = YES;
    
    if (buttonIndex == 0) {         //打开相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else {
            flag = NO;
            str = @"打开相机失败";
        }
    } else if (buttonIndex == 1) {  //打开相册
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        } else {
            flag = NO;
            str = @"打开相册失败";
        }
    }
    
    if (flag) {
        [self.nrVc presentViewController:imagePicker animated:YES completion:nil];
    } else {
        [self.nrVc showToast:str];
    }
}



#pragma mark -
#pragma mark ---------------------UIImagePickerControllerDelegate-----------------
/*--------------------------------------------------------------------------------
 |  UIImagePickerControllerDelegate
 |
 -------------------------------------------------------------------------------*/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *img = nil;
    //选择照片
    img = [info valueForKey:@"UIImagePickerControllerEditedImage"];
    if (img == nil) {
        img = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
    }
    
    //设置照片
    if (img != nil) {
        self.image = img;
        [self loadData:kHttpPostUserImgTag];
    } else {
        [self.nrVc showToast:@"设置照片失败"];
    }
    
    //隐藏
    [picker dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark -
#pragma mark -----------------------------alert----------------------------------
/*------------------------------------------------------------------------------
 |  alert
 |
 -----------------------------------------------------------------------------*/
- (void)confirmAlert:(UIAlertView *)alertView tag:(NSInteger)tag {
    if (tag == kAlertLogOutTag) {
        //清空存储
        [Cache.instance removeWithDir:kGlobalDir key:kGlobalKeyUser];
        [Global.instance.userInfo clear];
        self.userState = Global.instance.userInfo.userState;
        [self.ctrlTableView reloadData];
    } else if (tag == kAlertUpdateTag) {
        [AppUtil appStoreUpdate];
    }
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)createUserImgCell:(UITableViewCell *)cell title:(NSString *)title {
    //背景----
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(10, 25, cell.width - 20, 75)];
    [bg setStyleForSection];
    [cell addSubview:bg];
    //------
    UIButton *btn = [[UIButton alloc] initWithFrame:bg.bounds];
    btn.tag = kBtnUserImgTag;
    [btn addTarget:self action:@selector(btnClicked:)];
    [bg addSubview:btn];
    //图片
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 45, 45)];
    iv.layer.cornerRadius = 8;
    iv.layer.masksToBounds = YES;
    iv.backgroundColor = [UIColor lightGrayColor];
    [iv setImage:[UIImage imageNamed:@"man_small"]];
    iv.left = 10;
    iv.centerY = bg.height / 2;
    [bg addSubview:iv];
    self.ctrlUserImg = iv;
    //title
    UILabel *l = [UILabel labelWithLeft:iv.right + 19 Top:0 Width:200 Height:20 FontSize:16];
    l.text = title;
    l.centerY = bg.height/2;
    [bg addSubview:l];
    //img
    [btn setImage:[UIImage imageNamed:@"ic_list"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.width - btn.imageView.width - 20, 0, 0)];
}

- (void)createAdditonCell:(UITableViewCell *)cell {
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(10, 20, cell.width - 20, 0)];
    [bg setStyleForSection];
    [cell addSubview:bg];
    
    //设置----
    UIButton *btn = [UIButton btnCellWithTitle:@"设置" image:@"ucenter_icon_setting"];
    [btn addTarget:self action:@selector(btnClicked:)];
    btn.tag = kBtnSettingTag;
    [bg addSubview:btn];
    //分隔线
    UIView *line = [UIView lineWithWidth:btn.width];
    line.bottom = btn.height;
    [btn addSubview:line];
    //评分----
    btn = [UIButton btnCellWithTitle:@"给东方健康云评分" image:@"btn_star_big_pressed"];
    [btn addTarget:self action:@selector(btnClicked:)];
    btn.tag = kBtnRateAppTag;
    btn.top = btn.height;
    [bg addSubview:btn];
    //分隔线
    line = [UIView lineWithWidth:btn.width];
    line.bottom = btn.height;
    [btn addSubview:line];
    //检查更新----
    btn = [UIButton btnCellWithTitle:@"检查更新" image:@"ucenter_icon_update"];
    [btn addTarget:self action:@selector(btnClicked:)];
    btn.tag = kBtnUpdateTag;
    btn.top = btn.height*2;
    [bg addSubview:btn];
    
    bg.height = btn.bottom;
}

- (void)btnClicked:(UIButton *)btn {
    NSInteger tag = btn.tag;
    
    switch (tag) {
        case kBtnSignUpTag:
            [self.nrVc navTo:@"SignUpVc"];
            break;
        case kBtnSignInTag:
            [self.nrVc navTo:@"SignInVc"];
            break;
        case kBtnSettingTag:
            break;
        case kBtnRateAppTag:
            [AppUtil appStoreRate];
            break;
        case kBtnUpdateTag:
            [self loadData:kHttpUpdateTag];
            break;
        case kBtnModifyPwdTag:
            [self.nrVc navTo:@"ModifyPwdVc"];
            break;
        case kBtnCounselInfoTag:
            [self.nrVc navTo:@"CounselInfoListVc"];
            break;
        case kBtnMkOrderTag:
            [self.nrVc navTo:@"ReservationListVc"];
            break;
        case kBtnHealthReportTag:
            [self.nrVc navTo:@"HealthReportListVc"];
            break;
        case  kBtnFillUserInfoTag:
            [self.nrVc navTo:@"FillUserInfoVc"];
            break;
        case  kBtnUserImgTag:
            UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照上传", @"从相册上传", nil];
            //打开actionSheet
            [as showInView:self];
            break;
    }
}

- (void)logOutBtnClicked:(UIButton *)btn {
    [self alert:@"确认退出登录?" tag:kAlertLogOutTag];
}



@end
