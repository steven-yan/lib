/**
 *
 *  CounselInfoVc
 *  @author steven
 *  @date Oct 7 2014
 *
 **/

#import "CounselInfoListVc.h"

@implementation CounselInfoListVc
enum {
    kHttpLoadDataTag = 100,
    kHttpPostCounselTag,
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
    [self changeTopTitle:@"我的咨询"];
    [self changeTopRightBtnTitle:@"咨询"];
    //内容面板-----------
    //无信息提示
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [iv setImage:[UIImage imageNamed:@"depression_face"]];
    iv.hidden = YES;
    iv.centerX = self.contentPanel.width / 2;
    iv.centerY = self.contentPanel.height / 2 - 60;
    [self.contentPanel addSubview:iv];
    self.ctrlIv = iv;
    
    //咨询面板
    CounselInfoPanel *p = [[CounselInfoPanel alloc] initWithVc:self];
    p.delegate = self;
    [self.contentPanel addSubview:p];
    self.ctrlCounselPanel = p;
    
    //底部面板-----------
    //数据--------------
    self.arrayOfCellData = [[NSMutableArray alloc] init];
    //其他--------------
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
}

//解析导航返回
- (void)onPraseNavBackParams:(NSDictionary *)params {
    NSString *tag = [params valueForKey:@"needRefreshTag"];
    if ([tag intValue]) {
        [self loadData];
    }
}

//窗体将要显示------
- (void)onWillShow {
    //获取历史咨询信息
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
    //打开咨询面板
    [self.ctrlCounselPanel show];
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
        [self httpGet:[AppUtil fillUrl:@"userlogin.UserLoginPRC.getInquiryList.submit"] tag:tag];
    } else if (tag == kHttpPostCounselTag) {
        [self httpGet:[AppUtil fillUrl:@"message.MessagePRC.inquirySubmit.submit"] tag:tag];
    }
}

- (void)loadData {
    [self loadData:kHttpLoadDataTag];
}

- (void)onHttpRequestSuccessObj:(NSDictionary *)obj tag:(NSInteger)tag {
    if (tag == kHttpLoadDataTag) {
        [self hideLoading];
        
        [self.arrayOfCellData removeAllObjects];
        NSArray *list = [obj valueForKey:@"list"];
        if (list.count>0) {
            [self.arrayOfCellData addObjectsFromArray:list];
            self.ctrlIv.hidden = YES;
        } else {
            [self showToast:@"暂时没有信息"];
            self.ctrlIv.hidden = NO;
        }
        [self.tableView reloadData];
    } else if (tag == kHttpPostCounselTag) {
        [self loadData:kHttpLoadDataTag];
        
        self.ctrlCounselPanel.ctrlTv.text = nil;
        [self showToast:@"咨询提交成功"];
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
        [self.queryParams setValue:Global.instance.userInfo.userLoginId forKey:@"userLoginId"];
    } else if (tag == kHttpPostCounselTag) {
        [self.queryParams setValue:Global.instance.userInfo.userLoginId forKey:@"sendFrom"];
        [self.queryParams setValue:self.text forKey:@"content"];
    }
}



#pragma mark -
#pragma mark ----------------------CounselInfoPanel-----------------------------
/*------------------------------------------------------------------------------
 |  CounselInfoPanel
 |
 -----------------------------------------------------------------------------*/
- (void)onCounselInfoPanelCmf:(CounselInfoPanel *)p text:(NSString *)text {
    text = [StringUtil trimStr:text];
    
    if ([ChkUtil isEmptyStr:text] == NO) {
        self.text = text;
        [self loadData:kHttpPostCounselTag];
        [self.ctrlCounselPanel.ctrlTv resignFirstResponder];
        self.ctrlCounselPanel.hidden = YES;
    }
}



#pragma mark -
#pragma mark ---------------------------tableView-------------------------------
/*------------------------------------------------------------------------------
 |  tableView
 |
 -----------------------------------------------------------------------------*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfCellData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CounselInfoCell CellHeight];
}

- (void) createCell:(UITableViewCell *)cell {
    
    CounselInfoCell *c = [[CounselInfoCell alloc] initWithVc:self];
    c.tag = 100;
    [cell addSubview:c];
}

- (void)makeCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    //容错
    if (row >= self.arrayOfCellData.count) {
        return;
    }
    
    CounselInfoCell *c = (CounselInfoCell *)[cell viewWithTag:100];
    NSDictionary *dic = [self.arrayOfCellData objectAtIndex:row];
    [c refreshWithDic:dic];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    //容错
    if (row >= self.arrayOfCellData.count) {
        return;
    }
    
    //
    NSDictionary *dic = [self.arrayOfCellData objectAtIndex:row];
    [self navTo:@"CounselInfoDetailVc" params:dic];
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
