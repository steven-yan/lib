/**
 *
 *  ReservationDetailVc
 *  @author steven
 *  @date Otc 7 2014
 *
 **/

#import "ReservationDetailVc.h"

@implementation ReservationDetailVc
static int kLeftMargin = 15;
enum {
    //http
    kHttpLoadDataTag = 10,
    kHttpModifyDateTag,
    kHttpCancelReservationTag,
    
    //btn
    kBtnModifyDateTag = 100,
    kBtnModifyPackageTag,
    kBtnDelReservatinTag,
    kBtnCheckReportTag,
    kBtnPickerCmfTag,
};



#pragma mark -
#pragma mark ------------------------------窗体----------------------------------
/*------------------------------------------------------------------------------
 |  窗体
 |
 -----------------------------------------------------------------------------*/
//窗体创建
- (void)onCreate {
    //顶部面板-----------
    [self changeTopTitle:@"预约详情"];
    [self hideTopRightBtn];
    
    //内容面板-----------
    //体检号
    UILabel *peisId = [UILabel labelWithLeft:kLeftMargin Top:10 Width:self.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
    peisId.text = @"体检号:  ";
    [self.contentPanel addSubview:peisId];
    self.ctrlPeMasterId = peisId;
    //预约时间
    UILabel *date = [UILabel labelWithLeft:kLeftMargin Top:peisId.bottom + 5 Width:self.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
    date.text = @"预约时间:  ";
    [self.contentPanel addSubview:date];
    self.ctrlDate = date;
    //体检中心名称
    UILabel *name = [UILabel labelWithLeft:kLeftMargin Top:date.bottom + 5 Width:self.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
    name.text = @"体检中心:  ";
    [self.contentPanel addSubview:name];
    self.ctrlPeisName = name;
    //地址
    UILabel *addr = [UILabel labelWithLeft:kLeftMargin Top:name.bottom + 5 Width:self.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
    addr.text = @"地址:  ";
    [self.contentPanel addSubview:addr];
    self.ctrlAddr = addr;
    //电话
    UILabel *phone = [UILabel labelWithLeft:kLeftMargin Top:addr.bottom + 5 Width:self.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
    phone.text = @"电话:  ";
    [self.contentPanel addSubview:phone];
    self.ctrlPhone = phone;
    //套餐名称
    UILabel *packageName = [UILabel labelWithLeft:kLeftMargin Top:phone.bottom + 5 Width:self.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
    packageName.text = @"套餐:  ";
    [self.contentPanel addSubview:packageName];
    self.ctrlPackageName = packageName;
    //预约状态
    UILabel *status = [UILabel labelWithLeft:kLeftMargin Top:packageName.bottom + 5 Width:self.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
    status.text = @"状态:  ";
    status.textColor = [UIColor colorWithHexStr:kGeneralColor];
    [self.contentPanel addSubview:status];
    self.ctrlStatus = status;
    
    //修改日期
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, status.bottom + 25, (self.contentPanel.width - 20)/2-5, 40)];
    btn1.tag = kBtnModifyDateTag;
    [btn1 addTarget:self action:@selector(btnClicked:)];
    [btn1 setTitle:@"修改预约日期" forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:16];
    btn1.layer.cornerRadius = 6;
    btn1.backgroundColor = [UIColor colorWithHexStr:@"#f1271a"];
    btn1.right = self.contentPanel.width/2 - 5;
    [self.contentPanel addSubview:btn1];
    self.ctrlBtnModifyDate = btn1;
    //修改套餐
    UIButton *btn2 = [[UIButton alloc] initWithFrame:btn1.bounds];
    btn2.tag = kBtnModifyPackageTag;
    [btn2 addTarget:self action:@selector(btnClicked:)];
    [btn2 setTitle:@"修改套餐" forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:16];
    btn2.layer.cornerRadius = 6;
    btn2.backgroundColor = [UIColor colorWithHexStr:@"#f1271a"];
    btn2.top = btn1.top;
    btn2.left = self.contentPanel.width/2 + 5;
    [self.contentPanel addSubview:btn2];
    self.ctrlBtnModifyPackage = btn2;
    
    //取消预约------
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, status.bottom + 80, self.contentPanel.width - 20, 40)];
    btn.tag = kBtnDelReservatinTag;
    [btn addTarget:self action:@selector(btnClicked:)];
    [btn setTitle:@"取消预约" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.layer.cornerRadius = 6;
    btn.backgroundColor = self.topPanel.backgroundColor;
    [self.contentPanel addSubview:btn];
    self.ctrlBtnCancel = btn;
    
    //查看报告------
    btn = [[UIButton alloc] initWithFrame:btn.frame];
    btn.tag = kBtnCheckReportTag;
    [btn addTarget:self action:@selector(btnClicked:)];
    [btn setTitle:@"查看报告"];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.layer.cornerRadius = 6;
    btn.backgroundColor = self.topPanel.backgroundColor;
    btn.top = self.ctrlBtnModifyDate.top;
    btn.hidden = YES;
    [self.contentPanel addSubview:btn];
    self.ctrlBtnCheckReport = btn;
    
    //CSDatePicker----
    CSDatePicker *dp = [[CSDatePicker alloc] initWithTitle:@"设置预约时间"];
    dp.delegate = self;
    dp.top = 40;
    dp.centerX = self.contentPanel.width / 2;
    [self.contentPanel addSubview:dp];
    self.ctrlDatePicker = dp;
    
    //底部面板-----------
    //其他--------------
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
    self.peMasterId = [params valueForKey:@"peMasterId"];
    self.status = [params valueForKey:@"status"];
}

//解析导航返回
- (void)onPraseNavBackParams:(NSDictionary *)params {
    [self loadData:kHttpLoadDataTag];
}

//窗体将要显示------
- (void)onWillShow {
    [self handleStatus:self.status];
    [self loadData:kHttpLoadDataTag];
}

//窗体显示
- (void)onShow {
}

//隐藏------
- (void)onWillHide {
}

//导航栏------
- (void)topLeftBtnClicked {
    [self navBack];
}

- (void)topRightBtnClicked {
}



#pragma mark -
#pragma mark --------------------------获取和提交数据-----------------------------
/*------------------------------------------------------------------------------
 |  获取和提交数据
 |
 -----------------------------------------------------------------------------*/
- (void)loadData:(NSInteger)tag {
    if (tag == kHttpLoadDataTag) {
        [self showLoading];
        [self httpGet:[AppUtil fillUrl:@"userlogin.UserLoginPRC.getReservationDetail.submit"] tag:tag];
    } else if (tag == kHttpModifyDateTag) {
        [self httpGet:[AppUtil fillUrl:@"pemaster.PEMasterPRC.modifyReservation.submit"] tag:tag];
    } else if (tag == kHttpCancelReservationTag) {
        [self httpGet:[AppUtil fillUrl:@"pemaster.PEMasterPRC.cancelReservation.submit"] tag:tag];
    }
}

- (void)loadData {
    [self loadData:kHttpLoadDataTag];
}

- (void)onHttpRequestSuccessObj:(NSDictionary *)obj tag:(NSInteger)tag {
    if (tag == kHttpLoadDataTag) {
        [self hideLoading];
        ReservationDetailData *d = [[ReservationDetailData alloc] initWithObj:obj];
        self.data = d;
        [self refreshWithData:d];
    } else if (tag == kHttpModifyDateTag) {
        [self loadData:kHttpLoadDataTag];
        self.ctrlDatePicker.hidden = YES;
        
        [self showToast:@"修改预约日期成功"];
    } else if (tag == kHttpCancelReservationTag) {
        [self navBack];
    }
}

- (void)onHttpRequestFailed:(EnHttpRequestFailed)err hint:(NSString *)hint tag:(NSInteger)tag {
    if (tag == kHttpLoadDataTag) {
        [self hideLoading];
        [self showLoadError];
    }
}

//完善参数
- (void)completeQueryParams:(NSInteger)tag {
    if (tag == kHttpLoadDataTag) {
        [self.queryParams setValue:self.peMasterId forKey:@"peMasterId"];
    } else if (tag == kHttpModifyDateTag) {
        [self.queryParams setValue:self.data.peMasterId forKey:@"peMasterId"];
        [self.queryParams setValue:[self.ctrlDatePicker getDateStr] forKey:@"reservationDate"];
    } else if (tag == kHttpCancelReservationTag) {
        [self.queryParams setValue:self.peMasterId forKey:@"peMasterId"];
    }
}



#pragma mark -
#pragma mark --------------------CSDatePickerDelegate---------------------------
/*------------------------------------------------------------------------------
 |  CSDatePickerDelegate
 |
 -----------------------------------------------------------------------------*/
- (void)onCSDatePickerDelegate:(CSDatePicker *)picker {
    //请求
    [self loadData:kHttpModifyDateTag];
}



#pragma mark -
#pragma mark -----------------------------alert---------------------------------
/*------------------------------------------------------------------------------
 |  alert
 |
 -----------------------------------------------------------------------------*/
- (void)confirmAlert:(UIAlertView *)alertView {
    [self loadData:kHttpCancelReservationTag];
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)handleStatus:(NSString *)status {
    if ([status boolValue] == 0) {
        self.ctrlBtnModifyDate.hidden = NO;
        self.ctrlBtnModifyPackage.hidden = NO;
        self.ctrlBtnCancel.hidden = NO;
        
        self.ctrlBtnCheckReport.hidden = YES;
    } else {
        self.ctrlBtnModifyDate.hidden = YES;
        self.ctrlBtnModifyPackage.hidden = YES;
        self.ctrlBtnCancel.hidden = YES;
        
        self.ctrlBtnCheckReport.hidden = NO;
    }
}

- (void)refreshWithData:(ReservationDetailData *)data {
    self.ctrlPeMasterId.text = [@"体检号:  " stringByAppendingString:data.peMasterId];
    self.ctrlPeisName.text = [@"体检中心:  " stringByAppendingString:data.peisName];
    self.ctrlAddr.text = [@"地址:  " stringByAppendingString:data.address];
    self.ctrlPhone.text = [@"电话:  " stringByAppendingString:data.tel];
    self.ctrlPackageName.text = [@"套餐:  " stringByAppendingString:data.packageName];
    self.ctrlDate.text = [@"预约时间:  " stringByAppendingString:data.peDate];
    self.ctrlStatus.text = [@"状态:  " stringByAppendingString:data.statusText];
}

- (void)btnClicked:(UIButton *)btn {
    switch (btn.tag) {
        case kBtnModifyDateTag:
        {
            //检测预约状态
            if ([self.data.status intValue] == 0) {
                //修改日期
                self.ctrlDatePicker.hidden = NO;
                self.ctrlDatePicker.alpha = 0;
                [UIView animateWithDuration:0.5 animations:^{
                    self.ctrlDatePicker.alpha = 1;
                }];
            } else {
                [self showToast:@"已不能修改"];
            }
        }
            break;
            
        case kBtnModifyPackageTag:
        {
            //检测预约状态
            if ([self.data.status intValue] == 0) {
                [self navTo:@"HealthPackageListVc" params:[NSDictionary dictionaryWithObjects:@[self.data.peisCenterId, @"ReservationDetailVc", self.data.peMasterId] forKeys:@[@"centerId", @"fromePage", @"peMasterId"]]];
            } else {
                [self showToast:@"不能修改套餐"];
            }
        }
            break;
            
        case kBtnDelReservatinTag:
        {
            [self alert:@"确认取消此预约?"];
        }
            break;
            
        case kBtnPickerCmfTag:
        {
            [self loadData:kHttpModifyDateTag];
        }
            break;
            
        case kBtnCheckReportTag:
        {
            //导航到报告页
            [self navTo:@"HealthReportWebVc" params:@{@"peMasterId":self.data.peMasterId}];
        }
            break;
            
        default:
            break;
    }
}



@end
