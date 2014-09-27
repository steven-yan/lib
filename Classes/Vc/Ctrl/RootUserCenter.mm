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
        return 4;
    } else {
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    CGFloat height = 0;
    
    if (self.userState == LOGIN_STATE_NONE) {
        if (section == 0) {
            if (row == 0) {
                height = 160;
            } else {
                height = 120;
            }
        } else {
        
        }
    } else if (self.userState == LOGIN_STATE_NORMAL) {
        if (section == 0) {
            
        } else {
            
        }
    } else {
        if (section == 0) {
            
        } else {
            
        }
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.userState == LOGIN_STATE_NONE) {
        if (section == 0) {
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
                UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(10, 0, cell.width - 20, 0)];
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
        } else {
            
        }
    } else if (self.userState == LOGIN_STATE_NORMAL) {
        if (section == 0) {
            
        } else {
            
        }
    } else {
        if (section == 0) {
            
        } else {
            
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
- (void)btnClicked:(UIButton *)btn{
    NSInteger tag = btn.tag;
    
    switch (tag) {
        case kBtnSignUpTag:
            [self.nrVc navTo:@"SignUpVc"];
            break;
        case kBtnSignInTag:
            [self.nrVc navTo:@"SignInVc"];

            break;

        default:
            break;
    }
}



@end
