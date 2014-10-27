/**
 *
 *  CounselInfoDetailVc
 *  @author steven
 *  @date Otc 7 2014
 *
 **/

#import "CounselInfoDetailVc.h"

@implementation CounselInfoDetailVc
enum {
    kHttpLoadDataTag = 100,
    kHttpPostCounselTag,
    kHttpCleanInfo,
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
    [self changeTopTitle:@"咨询详情"];
    [self changeTopRightBtnTitle:@"清空"];
    
    //内容面板-----------
    //背景------
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentPanel.width, 50)];
    bg.bottom = self.contentPanel.height;
    [self.contentPanel addSubview:bg];
    self.ctrlBg = bg;
    //登录
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, bg.width - 20, bg.height - 10)];
    [btn setTitle:@"回复"];
    [btn addTarget:self action:@selector(cmtBtnClicked:)];
    btn.layer.cornerRadius = 6;
    btn.backgroundColor = self.topPanel.backgroundColor;
    btn.centerY = bg.height/2;
    [bg addSubview:btn];
    //tv
    self.tableView.height = self.contentPanel.height - bg.height;
    
    //counsel
    CounselInfoPanel *p = [[CounselInfoPanel alloc] initWithVc:self];
    p.delegate = self;
    [self.contentPanel addSubview:p];
    self.ctrlCounsel = p;
    
    //底部面板-----------
    //其他--------------
    self.arrayOfCellData = [[NSMutableArray alloc] init];
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
    self.messageId = [params valueForKey:@"messageId"];
}

//解析导航返回
- (void)onPraseNavBackParams:(NSDictionary *)params {
}

//窗体将要显示------
- (void)onWillShow {
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
    [self alert:@"清空咨询信息?"];
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
        [self httpGet:[AppUtil fillUrl:@"userlogin.UserLoginPRC.getInquiryDetail.submit"] tag:tag];
    } else if (tag == kHttpPostCounselTag) {
        [self httpGet:[AppUtil fillUrl:@"message.MessagePRC.inquirySubmit.submit"] tag:tag];
    } else if (tag == kHttpCleanInfo) {
        [self httpGet:[AppUtil fillUrl:@"message.MessagePRC.deleteInquiry.submit"] tag:tag];
    }
}

- (void)loadData {
    [self loadData:kHttpLoadDataTag];
}

- (void)onHttpRequestSuccessObj:(NSDictionary *)obj tag:(NSInteger)tag {
    if (tag != kHttpCleanInfo) {
        [self hideLoading];
        
        if (self.arrayOfCellData.count == 0) {
            NSArray *list = [obj valueForKey:@"list"];
            for (NSDictionary *obj in list) {
                CounselInfoDetailCellData *cd = [[CounselInfoDetailCellData alloc] initWithObj:obj];
                [self.arrayOfCellData addObject:cd];
            }
        } else {
            CounselInfoDetailCellData *cd = [[CounselInfoDetailCellData alloc] initWithObj:nil];
            cd.sendFrom = Global.instance.userInfo.userLoginId;
            cd.sendFromName = Global.instance.userInfo.userName;
            cd.sendTime = [TimeUtil timeWithFormat:@"YYYY-MM-dd HH:mm" date:[NSDate date]];
            cd.content = self.text;
            [self.arrayOfCellData addObject:cd];
            
            self.ctrlCounsel.ctrlTv.text = nil;
            [self showToast:@"回复成功"];
        }
        
        [self.tableView reloadData];
    } else {
        [self showToast:@"清空咨询详情成功"];
        [self navBackWithParams:[NSDictionary dictionaryWithObject:@"needRefreshTag" forKey:@"1"]];
    }
}

- (void)onHttpRequestFailed:(EnHttpRequestFailed)err hint:(NSString *)hint tag:(NSInteger)tag {
    if (tag == kHttpLoadDataTag) {
        [self hideLoading];
        [self showLoadError];
    } else if (tag == kHttpPostCounselTag) {
        [self showToast:@"回复信息失败"];
    } else if (tag == kHttpCleanInfo) {
        [self showToast:@"清空信息失败"];
    }
}

//完善参数
- (void)completeQueryParams:(NSInteger)tag {
    if (tag == kHttpLoadDataTag) {
        [self.queryParams setValue:self.messageId forKey:@"messageId"];
    } else if (tag == kHttpPostCounselTag) {
        [self.queryParams setValue:self.messageId forKey:@"replyToMsgId"];
        [self.queryParams setValue:Global.instance.userInfo.userLoginId forKey:@"sendFrom"];
        [self.queryParams setValue:self.text forKey:@"content"];
    } else if (tag == kHttpCleanInfo) {
        [self.queryParams setValue:self.messageId forKey:@"messageId"];
    }
}



#pragma mark -
#pragma mark ------------------------------tableView----------------------------------
/*------------------------------------------------------------------------------
 |  tableView
 |
 -----------------------------------------------------------------------------*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfCellData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    //容错
    if (row >= self.arrayOfCellData.count) {
        return 0;
    }
    
    CounselInfoDetailCellData *cd = [self.arrayOfCellData objectAtIndex:row];
    
    return [CounselInfoDetailCell CellHeight:cd];
}

- (void) createCell:(UITableViewCell *)cell {
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    CounselInfoDetailCell *c = [[CounselInfoDetailCell alloc] initWithVc:self];
    c.tag = 100;
    [cell addSubview:c];
}

- (void)makeCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    //容错
    if (row >= self.arrayOfCellData.count) {
        return;
    }
    
    CounselInfoDetailCell *c = (CounselInfoDetailCell *)[cell viewWithTag:100];
    CounselInfoDetailCellData *cd = [self.arrayOfCellData objectAtIndex:row];
    //刷新
    [c refreshWithCellData:cd];
}



#pragma mark -
#pragma mark ------------------------------alert--------------------------------
/*------------------------------------------------------------------------------
 |  alert
 |
 -----------------------------------------------------------------------------*/
- (void)confirmAlert:(UIAlertView *)alertView {
    [self loadData:kHttpCleanInfo];
}



#pragma mark -
#pragma mark --------------------------CounselInfoPanel-------------------------
/*------------------------------------------------------------------------------
 |  CounselInfoPanel
 |
 -----------------------------------------------------------------------------*/
- (void)onCounselInfoPanelCmf:(CounselInfoPanel *)p text:(NSString *)text {
    text = [StringUtil trimStr:text];
    
    if ([ChkUtil isEmptyStr:text] == NO) {
        self.text = text;
        [self loadData:kHttpPostCounselTag];
        [self.ctrlCounsel.ctrlTv resignFirstResponder];
        self.ctrlCounsel.hidden = YES;
    }
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)cmtBtnClicked:(UIButton *)btn {
    //显示
    [self.ctrlCounsel show];
}



@end
