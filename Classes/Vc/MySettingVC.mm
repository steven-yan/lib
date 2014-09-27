/**
 *
 * @author steven.yan
 *
 */

#import "MySettingVC.h"
#import "ImageUtil.h"
#import "CommonDefine.h"

@implementation MySettingVC



#pragma mark -
#pragma mark ------------------------------窗体----------------------------------
/*------------------------------------------------------------------------------
 |  窗体
 |
 -----------------------------------------------------------------------------*/
- (void) onCreate {
    //顶部面板-----------
    //标题栏
    [self changeTopTitle:@"设置"];
    [self hideTopRightBtn];
    //内容面板-----------
    UITableView *tv = [[UITableView alloc] initWithFrame:self.contentPanel.bounds style:UITableViewStyleGrouped];
    tv.backgroundView = nil;
    tv.scrollEnabled = NO;
    tv.height = 360;
    tv.dataSource = self;
    tv.delegate = self;
    tv.backgroundColor = [UIColor clearColor];
    [self.contentPanel addSubview:tv];
    self.tableView = tv;
    
    //删除设备
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithHexStr:@"#fe0000"];
    btn.layer.cornerRadius = 4;
    btn.top = tv.bottom;
    btn.centerX = self.contentPanel.centerX;
    [btn addTarget:self action:@selector(logOutBtnClicked:)];
    [self.contentPanel addSubview:btn];
    
    //actionSheet
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照上传", @"从相册上传", nil];
    as.top = self.contentPanel.height;
    [self.contentPanel addSubview:as];
    self.ctrlAs = as;
    
    //条形码
    UIView *qrView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
    qrView.centerX = self.contentPanel.centerX;
    qrView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(qrViewTapped:)];
    [qrView addGestureRecognizer:tapGes];
    qrView.backgroundColor = [UIColor whiteColor];
    qrView.alpha = 0;
    [self.contentPanel addSubview:qrView];
    //imgView
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:qrView.bounds];
    [qrView addSubview:imgView];
    self.ctrlQrView = qrView;
    
    //底部面板-----------
    //其他--------------
    OBSERVE_NOTIFICATION(NN_ROSTER_UPDATE,  onUpdateRoster:);
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
}

//解析导航返回
- (void)onPraseNavBackParams:(NSDictionary *)params {
}

//窗体将要显示
- (void)onWillShow {
    //用户名
    self.usrName = [LINKUSKIT getMyUser];
    //头像
    self.usrImg = [LINKUSKIT getMyPhoto];
    
    //刷新
    [self.tableView reloadData];
}

//窗体显示
- (void)onShow {
}

//导航栏------
- (void)topLeftBtnClicked {
    [self navBack];
}
- (void)topRightBtnClicked {
}

-(void)dealloc {
    REMOVE_NOTIFICATION;
}



#pragma mark -
#pragma mark -------------------------------表格---------------------------------
/*------------------------------------------------------------------------------
 |  表格
 |
 -----------------------------------------------------------------------------*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int rowNum = 1;
    
    switch (section) {
        case 1:
            rowNum = 2;
            break;
        case 2:
            rowNum = 2;
            break;
        default:
            break;
    }
    
    return rowNum;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    int height = 0;
    
    if (section == 0) {
        height = 65;
    } else {
        height = 40;
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.contentPanel.width, 20)];
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    
    if (section == 0) {
        cell.frame = CGRectMake(0, 0, self.contentPanel.width, 40);
        //label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 40, 20)];
        label.font = [UIFont systemFontOfSize:16];
        label.text = @"头像";
        label.backgroundColor = [UIColor clearColor];
        [cell addSubview:label];
        
        //图片
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 45, 45)];
        iv.layer.cornerRadius = 8;
        iv.layer.masksToBounds = YES;
        iv.backgroundColor = [UIColor lightGrayColor];
        if (self.usrImg != nil) {
            [iv setImage:self.usrImg];
        } else {
            [iv setImage:[UIImage imageNamed:@"man_small"]];
        }
        iv.right = cell.right - 48;
        [cell addSubview:iv];
        self.ctrlImgView = iv;
    } else if (section == 1) {
        UILabel *label = [[UILabel alloc] initWithFrame:cell.bounds];
        label.left = 15;
        label.font = [UIFont systemFontOfSize:16];
        label.backgroundColor = [UIColor clearColor];
        [cell addSubview:label];
        
        if (row == 0) {
            label.text = @"UID";
            
            //uid name
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 180, 20)];
            name.textAlignment = NSTextAlignmentRight;
            name.font = [UIFont systemFontOfSize:14];
            name.text = self.usrName;
            name.minimumScaleFactor = 0.5;
            name.backgroundColor = [UIColor clearColor];
            name.right = cell.right - 91;
            [label addSubview:name];
            
            //二维码图片
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
            [iv setImage:[UIImage imageNamed:@"qr_icon"]];
            iv.right = cell.right - 62;
            iv.centerY = name.centerY;
            [label addSubview:iv];
        } else if (row == 1) {
			label.text = @"修改密码";
		}
    } else if (section == 2) {
        if (row == 0) {
            UILabel *label = [[UILabel alloc] initWithFrame:cell.bounds];
            label.left = 15;
            label.font = [UIFont systemFontOfSize:16];
            label.text = @"添加设备";
            label.backgroundColor = [UIColor clearColor];
            [cell addSubview:label];
        } else if (row == 1) {
            UILabel *label = [[UILabel alloc] initWithFrame:cell.bounds];
            label.left = 15;
            label.font = [UIFont systemFontOfSize:16];
            label.text = @"设备界面管理";
            label.backgroundColor = [UIColor clearColor];
            [cell addSubview:label];
        }
    } else if (section == 3) {
        UILabel *label = [[UILabel alloc] initWithFrame:cell.bounds];
        label.text = @"关于我们";
        label.left = 15;
        label.font = [UIFont systemFontOfSize:16];
        label.backgroundColor = [UIColor clearColor];
        [cell addSubview:label];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        //打开actionSheet
        [self.ctrlAs showInView:self.contentPanel];
    } else if (section == 1) {
		if (row == 0) {
            NSString* lid = [LINKUSKIT getMyLid];
            UIImage *img = [QRCodeGenerator qrImageForString:lid imageSize:250];
            if (img) {
                UIImageView *iv = [[self.ctrlQrView subviews] objectAtIndex:0];
                self.ctrlQrView.top = -5;
                [iv setImage:img];
                [UIView animateWithDuration:0.4 animations:^(void){
                     self.ctrlQrView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0f, 1.0f);
                     self.ctrlQrView.alpha = 1;
                     self.ctrlQrView.top = 40;
                 }];
            }
		} else if (row == 1) {
            [self navTo:@"ModifyPwdVC"];
		}
    } else if (section == 2) {
        if (row == 0) {
            //添加设备
            [self navTo:@"ScanQrCodesVC"];
        } else if (row == 1) {
            //插件管理
            [self navTo:@"PluginControlVC"];
        }
    } else {
    }
}



#pragma mark -
#pragma mark --------------------------actionSheetDelegate------------------------
/*--------------------------------------------------------------------------------
 |  actionSheetDelegate
 |
 -------------------------------------------------------------------------------*/
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
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        [self showHudWithBottomHint:str];
    }
}



#pragma mark -
#pragma mark --------------------UIImagePickerControllerDelegate--------------------
/*----------------------------------------------------------------------------------
 |  UIImagePickerControllerDelegate
 |
 ---------------------------------------------------------------------------------*/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *img = nil;
    //选择照片
    img = [info valueForKey:@"UIImagePickerControllerEditedImage"];
    if (img == nil) {
        img = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
    }
    
    //设置照片
    if (img != nil) {
        //上传到服务器
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			[LINKUSKIT setMyPhoto:[ImageUtil imageWithImage:img scaledToSize:AVATAR_SIZE]];
        });
        //设置照片
        [self.ctrlImgView setImage:img];
    } else {
        [self showHudWithBottomHint:@"设置照片失败"];
    }
    
    //隐藏
    [picker dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark -
#pragma mark --------------------------UIAlertViewDelegate------------------------
/*--------------------------------------------------------------------------------
 |  UIAlertViewDelegate
 |
 -------------------------------------------------------------------------------*/
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
        case 1:
			//退出
			[self logOut];
            break;
        case 0:
            break;
		default:
			break;
	}

}



#pragma mark -
#pragma mark -------------------------------其他--------------------------------
/*-----------------------------------------------------------------------------
 |  其他
 |
 ----------------------------------------------------------------------------*/
- (void)onUpdateRoster:(NSNotification *)notify {
    NSDictionary *params = notify.object;
    NSString *lid = [params valueForKey:@"lid"];
    
    if ([lid isEqualToString:[LINKUSKIT getMyLid]]) {
        //设置照片
        [self.ctrlImgView setImage:[LINKUSKIT getMyPhoto]];
    }
}

- (void)qrViewTapped:(id)ges {
    [UIView animateWithDuration:0.4 animations:
     ^(void){
         self.ctrlQrView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2f, 0.2f);
         self.ctrlQrView.alpha = 0;
         self.ctrlQrView.top = -5;
     }];
}

- (void)logOutBtnClicked:(UIButton *)btn {
	UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"您确定要退出登录么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alert.alertViewStyle=UIAlertViewStyleDefault;
    [alert show];
}

- (void)logOut {
    [self navTo:@"SignInVC" style:NavStyleBottomToTop];
}



@end
