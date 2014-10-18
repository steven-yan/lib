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
        [self httpGet:[AppUtil healthUrl:@"userlogin.UserLoginPRC.getInquiryList.submit"] tag:tag];
    } else if (tag == kHttpPostCounselTag) {
        [self httpGet:[AppUtil healthUrl:@"message.MessagePRC.inquirySubmit.submit"] tag:tag];
    }
}

- (void)onHttpRequestSuccessObj:(NSDictionary *)obj tag:(NSInteger)tag {
    if (tag == kHttpLoadDataTag) {
        [self.arrayOfCellData removeAllObjects];
        NSArray *list = [obj valueForKey:@"list"];
        [self.arrayOfCellData addObjectsFromArray:list];
        
        [self.tableView reloadData];
    } else if (tag == kHttpPostCounselTag) {
        [self loadData:kHttpLoadDataTag];
        [self.ctrlCounselPanel.ctrlTv resignFirstResponder];
        self.ctrlCounselPanel.hidden = YES;
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
    if ([ChkUtil isEmptyStr:text] == NO) {
        self.text = text;
        [self loadData:kHttpPostCounselTag];
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
    [c refreshWithContent:[dic valueForKey:@"content"] msgId:[dic valueForKey:@"messageId"]];
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
