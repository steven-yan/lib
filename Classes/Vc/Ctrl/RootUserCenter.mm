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
    kBtnSignUpTag = 100,
    kBtnSignInTag,
    kBtnMarkAppTag,
    kBtnUpdateTag,
    kBtnDeclareTag,
    kBtnCounselInfoTag,
    kBtnChkUpdateTag,
    kBtnUserImgTag,
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
    self.userState = LOGIN_STATE_AUTH;//Global.instance.userInfo.userState;
    //刷新
    [self.ctrlTableView reloadData];
}

- (void)onWillHide {
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
    } else if (self.userState == LOGIN_STATE_NORMAL) {
        return 3;
    } else {
        return 3;
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
    } else if (self.userState == LOGIN_STATE_NORMAL) {
        if (row == 0) {
            height = 120;
        } else if (row == 1) {
            height = 100;
        } else {
            height = 120;
        }
    } else {
        if (row == 0) {
            height = 120;
        } else if (row == 1) {
            height = 140;
        } else {
            height = 120;
        }
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
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
    } else if (self.userState == LOGIN_STATE_NORMAL) {
        if (row == 0) {
            [self createUserImgCell:cell];
        } else if (row == 1) {
            //背景----
            UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(10, 20, cell.width - 20, 80)];
            [bg setStyleForSection];
            [cell addSubview:bg];
            
            //信息咨询----
            UIButton *btn = [UIButton btnCellWithTitle:@"信息咨询"];
            [btn addTarget:self action:@selector(btnClicked:)];
            btn.tag = kBtnCounselInfoTag;
            [bg addSubview:btn];
            //分隔线----
            UIView *line = [UIView lineWithWidth:btn.width];
            line.bottom = btn.height;
            [btn addSubview:line];
            
            //检查更新----
            btn = [UIButton btnCellWithTitle:@"完善个人信息"];
            [btn addTarget:self action:@selector(btnClicked:)];
            btn.tag = kBtnChkUpdateTag;
            btn.top = btn.height;
            [bg addSubview:btn];
        } else {
            [self createAdditonCell:cell];
        }
    } else {
        if (row == 0) {
            [self createUserImgCell:cell];
        } else if (row == 1) {
            //背景----
            UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(10, 20, cell.width - 20, 120)];
            [bg setStyleForSection];
            [cell addSubview:bg];
            
            //信息咨询----
            UIButton *btn = [UIButton btnCellWithTitle:@"信息咨询"];
            [btn addTarget:self action:@selector(btnClicked:)];
            btn.tag = kBtnCounselInfoTag;
            [bg addSubview:btn];
            //分隔线----
            UIView *line = [UIView lineWithWidth:btn.width];
            line.bottom = btn.height;
            [btn addSubview:line];
            
            //预约----
            btn = [UIButton btnCellWithTitle:@"预约"];
            [btn addTarget:self action:@selector(btnClicked:)];
            btn.tag = kBtnCounselInfoTag;
            btn.top = btn.height;
            [bg addSubview:btn];
            //分隔线----
            line = [UIView lineWithWidth:btn.width];
            line.bottom = btn.height;
            [btn addSubview:line];
            
            //体检报告----
            btn = [UIButton btnCellWithTitle:@"体检报告"];
            [btn addTarget:self action:@selector(btnClicked:)];
            btn.tag = kBtnCounselInfoTag;
            btn.top = btn.height * 2;
            [bg addSubview:btn];
            
            [bg addSubview:btn];
        } else {
            [self createAdditonCell:cell];
        }
    }
    
    return cell;
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)createUserImgCell:(UITableViewCell *)cell {
    //背景----
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(10, 40, cell.width - 20, 80)];
    [bg setStyleForSection];
    [cell addSubview:bg];
    //------
    UIButton *btn = [UIButton btnCellWithTitle:@"头像" height:bg.height];
    [btn addTarget:self action:@selector(btnClicked:)];
    btn.tag = kBtnUserImgTag;
    [bg addSubview:btn];
    //图片
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 45, 45)];
    iv.layer.cornerRadius = 8;
    iv.layer.masksToBounds = YES;
    iv.backgroundColor = [UIColor lightGrayColor];
    [iv setImage:[UIImage imageNamed:@"man_small"]];
    iv.right = bg.right - 48;
    iv.centerY = bg.height / 2;
    [bg addSubview:iv];
}

- (void)createAdditonCell:(UITableViewCell *)cell {
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(10, 20, cell.width - 20, 0)];
    [bg setStyleForSection];
    [cell addSubview:bg];
    
    //评分----
    UIButton *btn = [UIButton btnCellWithTitle:@"给东方云健康评分"];
    [btn addTarget:self action:@selector(btnClicked:)];
    btn.tag = kBtnMarkAppTag;
    [bg addSubview:btn];
    //分隔线
    UIView *line = [UIView lineWithWidth:btn.width];
    line.bottom = btn.height;
    [btn addSubview:line];
    //检查更新----
    btn = [UIButton btnCellWithTitle:@"检查更新"];
    [btn addTarget:self action:@selector(btnClicked:)];
    btn.tag = kBtnUpdateTag;
    btn.top = btn.height;
    [bg addSubview:btn];
    //分隔线
    line = [UIView lineWithWidth:btn.width];
    line.bottom = btn.height;
    [btn addSubview:line];
    //声明----
    btn = [UIButton btnCellWithTitle:@"声明"];
    [btn addTarget:self action:@selector(btnClicked:)];
    btn.tag = kBtnDeclareTag;
    btn.top = btn.height * 2;
    [bg addSubview:btn];
    
    bg.height = btn.bottom;
}

- (void)btnClicked:(UIButton *)btn{
    NSInteger tag = btn.tag;
    
    switch (tag) {
        case kBtnSignUpTag:
            [self.nrVc navTo:@"SignUpVc"];
            break;
        case kBtnSignInTag:
            [self.nrVc navTo:@"SignInVc"];
            break;
        case kBtnMarkAppTag:
            break;
        case kBtnUpdateTag:
            break;
        case kBtnDeclareTag:
            break;
        case kBtnCounselInfoTag:
            break;
        case kBtnChkUpdateTag:
            break;
            
        default:
            break;
    }
}



@end
