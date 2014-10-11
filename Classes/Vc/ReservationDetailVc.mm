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
    [self changeTopRightBtnTitle:@"修改"];
    
    //内容面板-----------
    //体检中心名称
    UILabel *name = [UILabel labelWithLeft:kLeftMargin Top:10 Width:self.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
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
    //预约时间
    UILabel *date = [UILabel labelWithLeft:kLeftMargin Top:phone.bottom + 5 Width:self.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
    [self.contentPanel addSubview:date];
    self.ctrlDate = date;
    
    //套餐名称
    UILabel *packageName = [UILabel labelWithLeft:kLeftMargin Top:date.bottom + 5 Width:self.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
    [self.contentPanel addSubview:packageName];
    self.ctrlPackageName = packageName;
//    //套餐详情
//    UILabel *packageDetail = [UILabel labelWithLeft:kLeftMargin Top:packageName.bottom + 5 Width:self.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
//    [self.contentPanel addSubview:packageDetail];
//    self.ctrlPackageDetail = packageDetail;
    //预约状态
    UILabel *status = [UILabel labelWithLeft:kLeftMargin Top:packageName.bottom + 5 Width:self.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
    [self.contentPanel addSubview:status];
    self.ctrlStatus = status;
    
    //删除按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, status.bottom + 15, 80, 30)];
    [btn addTarget:self action:@selector(delBtnClicked:)];
    [btn setTitle:@"删除"];
    btn.centerX = self.contentPanel.width / 2;
    [btn setStyleGray];
    [self.contentPanel addSubview:btn];
    
    //修改----
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(15, 5, self.contentPanel.width - 30, 280)];
    bg.hidden = YES;
    bg.backgroundColor = [UIColor whiteColor];
    [bg setStyleForSection];
    [self.contentPanel addSubview:bg];
    self.ctrlPickBg = bg;
    //hint
    UILabel *l = [UILabel labelWithLeft:0 Top:0 Width:bg.width Height:20 FontSize:16];
    l.text = @"更改预约时间";
    l.textColor = [UIColor grayColor];
    l.textAlignment = NSTextAlignmentCenter;
    [bg addSubview:l];
    //picker--
    UIDatePicker *dp = [[UIDatePicker alloc] init];
    dp.top = l.bottom;
    dp.centerX = bg.width / 2;
    [bg addSubview:dp];
    self.ctrlDatePicker = dp;
    //取消--
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, dp.bottom, 80, 30)];
    [btn addTarget:self action:@selector(cancelBtnClicked:)];
    [btn setTitle:@"取消"];
    btn.right = bg.width / 2 - 10;
    [btn setStyleGray];
    [bg addSubview:btn];
    //确认--
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, dp.bottom, 80, 30)];
    [btn addTarget:self action:@selector(cmfBtnClicked:)];
    [btn setTitle:@"确认"];
    btn.left = bg.width / 2 + 10;
    [btn setStyleGreen];
    [bg addSubview:btn];
    
    //底部面板-----------
    //其他--------------
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
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
    //修改日期
    self.ctrlPickBg.hidden = NO;
    self.ctrlPickBg.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.ctrlPickBg.alpha = 1;
    }];
}



#pragma mark -
#pragma mark --------------------------获取和提交数据-----------------------------
/*------------------------------------------------------------------------------
 |  获取和提交数据
 |
 -----------------------------------------------------------------------------*/
- (void)loadData {
    //myReservationDetail.jsp?peMasterId =xx
    [self refreshWithData:[[ReservationDetailData alloc] initWithObj:nil]];
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)refreshWithData:(ReservationDetailData *)data {
    self.ctrlPeisName.text = [@"体检中心:" stringByAppendingString:data.peisName];
    self.ctrlAddr.text = [@"地址: " stringByAppendingString:data.addr];
    self.ctrlPhone.text = [@"电话: " stringByAppendingString:data.phone];
    self.ctrlPackageName.text = [@"套餐: " stringByAppendingString:data.peisName];
    self.ctrlDate.text = [@"预约时间: " stringByAppendingString:data.date];
    self.ctrlStatus.text = [@"状态: " stringByAppendingString:data.status];
//    [self.ctrlPackageDetail setDynamicWithStr:[@"详情: " stringByAppendingString:data.packageDetail] fontSize:14]self.ctrlPackageDetail.text = [@"地址: " stringByAppendingString:data.peisName];
}

- (void)delBtnClicked:(UIButton *)btn {
    
}

- (void)cancelBtnClicked:(UIButton *)btn {
    self.ctrlPickBg.hidden = YES;
    //恢复
    [self.ctrlDatePicker setDate:[NSDate date]];
}

- (void)cmfBtnClicked:(UIButton *)btn {
    
}



@end
