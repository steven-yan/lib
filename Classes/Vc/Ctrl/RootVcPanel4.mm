/**
 * 
 *@author steven.yan
 *
 */

#import "RootVcPanel4.h"

@implementation RootVcPanel4



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithVc:(BaseLayoutVc *)vc {
    if (self = [super initWithFrame:CGRectMake(0, 0, vc.view.width, vc.view.height - [SysInfo instance].bottomPanelHeight)]) {
        //页面
        self.nrVc = vc;
        //-
        
        //控件-------------------
        TopPanel *tp = [[TopPanel alloc] init];
        tp.ctrlLeftBtn.hidden = YES;
        tp.ctrlRightBtn.hidden = YES;
        [tp changeTitle:@"个人中心"];
        [self addSubview:tp];
        
        //tableView
        UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, tp.bottom, self.width, vc.contentPanel.height - [SysInfo instance].bottomPanelHeight) style:UITableViewStyleGrouped];
        tv.backgroundView = nil;
        tv.backgroundColor = [UIColor clearColor];
        tv.dataSource = self;
        tv.delegate = self;
        tv.separatorStyle = UITableViewCellSeparatorStyleNone;
        tv.showsVerticalScrollIndicator = NO;
        [self addSubview:tv];

        //数据-------------------
    }
    
    return self;
}



#pragma mark -
#pragma mark ------------------------------方法----------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/



//我的信息
//我的健康档案
//我的体检报告
//我的收藏（体检中心、健康知识）
//健康Tip（根据我的档案推送健康小知识）
//我的私人医生
//我的体检（预约的体检订单）
//健康分析
//健康回访
//邀请新用户
#pragma mark -
#pragma mark ------------------------------tableView----------------------------------
/*------------------------------------------------------------------------------
 |  tableView
 |
 -----------------------------------------------------------------------------*/
- (int)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 10;
    }
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    label.backgroundColor = [UIColor clearColor];
    if (section == 0) {
        label.text = @"    账号管理";
    } else {
        label.text = @"    详细信息";
    }
    
    return label;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *uniqueIdentifyer = NSStringFromClass([self class]);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:uniqueIdentifyer];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:uniqueIdentifyer];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self createCell:cell];
    }
    
    [self makeCell:cell indexPath:indexPath];
    
    return cell;
}

- (void)createCell:(UITableViewCell *)cell {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 200, 20)];
    label.backgroundColor = [UIColor clearColor];
    label.tag = 100;
    [cell addSubview:label];
    
    //分隔线
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, cell.height - 0.5, cell.width, 0.5)];
//    line.backgroundColor = [UIColor grayColor];
//    [cell addSubview:line];
}

- (void)makeCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    int section = indexPath.section;
    int row = indexPath.row;
    
    UILabel *label = (UILabel *)[cell viewWithTag:100];
    
    if (section == 0) {
        label.text = @"用户登录";
    } else {
        switch (row) {
            case 0:
                label.text = @"我的信息";
                break;
                
            case 1:
                label.text = @"健康档案";
                break;
                
            case 2:
                label.text = @"体检报告";
                break;
                
            case 3:
                label.text = @"我的收藏";
                break;
                
            case 4:
                label.text = @"健康Tip";
                break;
                
            case 5:
                label.text = @"私人医生";
                break;
                
            case 6:
                label.text = @"我的体检";
                break;
                
            case 7:
                label.text = @"健康分析";
                break;
                
            case 8:
                label.text = @"健康回访";
                break;
                
            case 9:
                label.text = @"邀请新用户";
                break;
                
            default:
                break;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
