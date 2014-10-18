/**
 *
 *  ExpertDetailVc
 *  @author steven
 *  @date Sep 20 2014
 *
 **/

#import "ExpertDetailVc.h"

@implementation ExpertDetailVc



#pragma mark -
#pragma mark ------------------------------窗体----------------------------------
/*------------------------------------------------------------------------------
 |  窗体
 |
 -----------------------------------------------------------------------------*/
//窗体创建
- (void)onCreate {
    //顶部面板-----------
    [self changeTopTitle:@"专家信息"];
    [self hideTopRightBtn];
    //内容面板-----------
    //顶部头像----
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentPanel.width, 80)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.contentPanel addSubview:bg];
    //头像
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 60, 60)];
    iv.layer.cornerRadius = 4;
    iv.layer.masksToBounds = YES;
    iv.backgroundColor = [UIColor lightGrayColor];
    iv.centerY = bg.height / 2;
    [bg addSubview:iv];
    self.ctrlIv = iv;
    //名字
    UILabel *l = [UILabel labelWithLeft:0 Top:0 Width:200 Height:20 FontSize:16];
    l.font = [UIFont boldSystemFontOfSize:16];
    l.left = iv.right + 15;
    l.centerY = iv.centerY;
    [bg addSubview:l];
    self.ctrlName = l;
    //分隔线
    UIView *line = [UIView lineWithWidth:self.contentPanel.width];
    line.bottom = bg.height;
    [bg addSubview:line];
    
    //简介
    l = [UILabel labelWithLeft:10 Top:bg.bottom + 15 Width:self.contentPanel.width - 20 Height:20 FontSize:14];
    l.numberOfLines = 0;
    [self.contentPanel addSubview:l];
    self.ctrlSummary = l;
    //分隔线
    line = [UIView lineWithWidth:self.contentPanel.width - 20];
    line.centerX = self.contentPanel.width / 2;
    line.top = l.bottom + 10;
    [self.contentPanel addSubview:line];
    self.ctrlLine = line;
    //详情
    l = [UILabel labelWithLeft:10 Top:l.bottom + 10 Width:self.contentPanel.width - 20 Height:20 FontSize:14];
    l.numberOfLines = 0;
    [self.contentPanel addSubview:l];
    self.ctrlIntro = l;
    
    //底部面板-----------
    //其他--------------
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
    self.expertId = [params valueForKey:@"expertId"];
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


#pragma mark --------------------------获取和提交数据-----------------------------
/*------------------------------------------------------------------------------
 |  获取和提交数据
 |
 -----------------------------------------------------------------------------*/
- (void)loadData {
    [self httpGet:[AppUtil healthUrl:@"news.NewsPRC.getDoctorDetail.submit"]];
}

- (void)onHttpRequestSuccessObj:(NSDictionary *)obj {
    NSString *doctorName = [obj valueForKey:@"doctorName"];
    NSString *introduction = [obj valueForKey:@"introduction"];
    NSString *photoPath = [obj valueForKey:@"photoPath"];
    NSString *summary = [obj valueForKey:@"summary"];
    
    //handle nil
    doctorName = [ChkUtil handleNil:doctorName];//[doctorName handleNil];
    introduction = [ChkUtil handleNil:introduction];
    photoPath = [ChkUtil handleNil:photoPath];
    summary = [ChkUtil handleNil:summary];
    
    [self refreshWithimgUrl:photoPath name:doctorName summary:summary intro:introduction];
}

- (void)completeQueryParams {
    [self.queryParams setValue:self.expertId forKey:@"doctorId"];
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)refreshWithimgUrl:(NSString *)imgUrl name:(NSString *)name summary:(NSString *)summary intro:(NSString *)intro {
    //iv
    [self.ctrlIv sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"portrait_default"]];
    //name
    self.ctrlName.text = name;
    //summary
    [self.ctrlSummary setDynamicWithStr:[@"简介:  " stringByAppendingString:summary] fontSize:14];
    //line
    self.ctrlLine.top = self.ctrlSummary.bottom + 15;
    //intro
    [self.ctrlIntro setDynamicWithStr:[@"详细介绍:  " stringByAppendingString:intro] fontSize:14];
    self.ctrlIntro.top = self.ctrlLine.bottom + 15;
    if (self.ctrlIntro.bottom > self.contentPanel.height) {
        self.contentPanel.contentSize = CGSizeMake(self.contentPanel.width, self.ctrlIntro.bottom);
    }
}



@end
