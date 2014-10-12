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
    kBtnModifyDateTag = 100,
    kBtnModifyPackageTag,
    kBtnDelReservatinTag,
    kBtnPickerCancelTag,
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
    [self.contentPanel addSubview:peisId];
    self.ctrlPeMasterId = peisId;
    //预约时间
    UILabel *date = [UILabel labelWithLeft:kLeftMargin Top:peisId.bottom + 5 Width:self.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
    [self.contentPanel addSubview:date];
    self.ctrlDate = date;
    //体检中心名称
    UILabel *name = [UILabel labelWithLeft:kLeftMargin Top:date.bottom + 5 Width:self.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
    [self.contentPanel addSubview:name];
    self.ctrlPeisName = name;
    //地址
    UILabel *addr = [UILabel labelWithLeft:kLeftMargin Top:name.bottom + 5 Width:self.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
    [self.contentPanel addSubview:addr];
    self.ctrlAddr = addr;
    //电话
    UILabel *phone = [UILabel labelWithLeft:kLeftMargin Top:addr.bottom + 5 Width:self.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
    [self.contentPanel addSubview:phone];
    self.ctrlPhone = phone;
    //套餐名称
    UILabel *packageName = [UILabel labelWithLeft:kLeftMargin Top:phone.bottom + 5 Width:self.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
    [self.contentPanel addSubview:packageName];
    self.ctrlPackageName = packageName;
    //预约状态
    UILabel *status = [UILabel labelWithLeft:kLeftMargin Top:packageName.bottom + 5 Width:self.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
    [self.contentPanel addSubview:status];
    self.ctrlStatus = status;
    
    //取消预约------
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, status.bottom + 80, self.contentPanel.width - 20, 40)];
    btn.tag = kBtnDelReservatinTag;
    [btn addTarget:self action:@selector(btnClicked:)];
    [btn setTitle:@"取消预约" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.layer.cornerRadius = 6;
    btn.backgroundColor = self.topPanel.backgroundColor;
    [self.contentPanel addSubview:btn];
    //修改日期
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btn.width/2-5, 40)];
    btn1.tag = kBtnModifyDateTag;
    [btn1 addTarget:self action:@selector(btnClicked:)];
    [btn1 setTitle:@"修改预约日期" forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:16];
    btn1.layer.cornerRadius = 6;
    btn1.backgroundColor = [UIColor colorWithHexStr:@"#f1271a"];
    btn1.bottom = btn.top - 10;
    btn1.right = btn.centerX - 5;
    [self.contentPanel addSubview:btn1];
    //修改套餐
    UIButton *btn2 = [[UIButton alloc] initWithFrame:btn1.bounds];
    btn2.tag = kBtnModifyPackageTag;
    [btn2 addTarget:self action:@selector(btnClicked:)];
    [btn2 setTitle:@"修改套餐" forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:16];
    btn2.layer.cornerRadius = 6;
    btn2.backgroundColor = [UIColor colorWithHexStr:@"#f1271a"];
    btn2.top = btn1.top;
    btn2.left = btn.centerX + 5;
    [self.contentPanel addSubview:btn2];
    //修改日期弹出层----
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(10, 5, self.contentPanel.width - 20, 300)];
    bg.hidden = YES;
    bg.backgroundColor = [UIColor whiteColor];
    [bg setStyleForSection];
    [self.contentPanel addSubview:bg];
    self.ctrlPickBg = bg;
    //hint
    UILabel *l = [UILabel labelWithLeft:0 Top:5 Width:bg.width Height:20 FontSize:16];
    l.text = @"更改预约时间";
    l.textAlignment = NSTextAlignmentCenter;
    [bg addSubview:l];
    //picker--
    UIDatePicker *dp = [[UIDatePicker alloc] init];
    dp.top = l.bottom + 5;
    dp.centerX = bg.width / 2;
    [bg addSubview:dp];
    self.ctrlDatePicker = dp;
    //取消--
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, dp.bottom + 10, 80, 30)];
    btn.tag = kBtnPickerCancelTag;
    [btn addTarget:self action:@selector(btnClicked:)];
    [btn setTitle:@"取消"];
    btn.right = bg.width / 2 - 10;
    [btn setStyleGray];
    [bg addSubview:btn];
    //确认--
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, dp.bottom + 10, 80, 30)];
    btn.tag = kBtnPickerCmfTag;
    [btn addTarget:self action:@selector(btnClicked:)];
    [btn setTitle:@"确认"];
    btn.left = bg.width / 2 + 10;
    [btn setStyleGreen];
    [bg addSubview:btn];
    
    //底部面板-----------
    //其他--------------
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
    self.peMasterId = [params valueForKey:@"peMasterId"];
}

//解析导航返回
- (void)onPraseNavBackParams:(NSDictionary *)params {
}

//窗体将要显示------
- (void)onWillShow {
    [self loadData];
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
- (void)loadData {
    [self httpGet:[AppUtil healthUrl:@"userlogin.UserLoginPRC.getReservationDetail.submit"]];
}

- (void)onHttpRequestSuccessObj:(NSDictionary *)obj {
    ReservationDetailData *d = [[ReservationDetailData alloc] initWithObj:obj];
    [self refreshWithData:d];
}

//完善参数
- (void)completeQueryParams {
    [self.queryParams setValue:self.peMasterId forKey:@"peMasterId"];
}



#pragma mark -
#pragma mark -----------------------------alert---------------------------------
/*------------------------------------------------------------------------------
 |  alert
 |
 -----------------------------------------------------------------------------*/
- (void)confirmAlert:(UIAlertView *)alertView {
    
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
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
            //修改日期
            self.ctrlPickBg.hidden = NO;
            self.ctrlPickBg.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.ctrlPickBg.alpha = 1;
            }];
        }
            break;
            
        case kBtnModifyPackageTag:
        {
            
        }
            break;
            
        case kBtnDelReservatinTag:
        {
            [self alert:@"确认取消此预约?"];
        }
            break;
            
        case kBtnPickerCancelTag:
        {
            self.ctrlPickBg.hidden = YES;
            //恢复
            [self.ctrlDatePicker setDate:[NSDate date]];
        }
            break;
            
        case kBtnPickerCmfTag:
        {
            
        }
            break;
            
        default:
            break;
    }
}



@end
