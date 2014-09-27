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
}

//解析导航返回
- (void)onPraseNavBackParams:(NSDictionary *)params {
}

//窗体将要显示------
- (void)onWillShow {
    [self refreshWithimgUrl:@"http://www.news.cn/politics/static/ldrtp/001.jpg" name:@"王二" summary:@"我同普京总统5月在上海成功会晤之后，又在金砖国家领导人福塔莱萨峰会和不久前举行的上海合作组织杜尚别峰会期间成功。" intro:@"会晤，推动中俄全面战略协作伙伴关系进入新的历史阶段。明年两国将共同举办庆祝第二次世界大战胜利70周年活动。两国立法机构也可以积极参与，并在多边议会组织中密切配合，共同发声发力，扩大宣传，维护好第二次世界大战成果和。"];
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
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)refreshWithimgUrl:(NSString *)imgUrl name:(NSString *)name summary:(NSString *)summary intro:(NSString *)intro {
    //iv
    [self.ctrlIv sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@""]];
    //name
    self.ctrlName.text = name;
    //summary
    [self.ctrlSummary setDynamicWithStr:[@"简介:  " stringByAppendingString:summary] fontSize:14];
    //line
    self.ctrlLine.top = self.ctrlSummary.bottom + 15;
    //intro
    [self.ctrlIntro setDynamicWithStr:[@"详细介绍:  " stringByAppendingString:intro] fontSize:14];
    self.ctrlIntro.top = self.ctrlLine.bottom + 15;
}



@end
