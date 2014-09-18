/**
 * 
 *@author steven.yan
 *
 */

#import "RootVcPanel2.h"
#import "HkCell.h"

@implementation RootVcPanel2



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
        tp.delegate = self;
        [tp changeLeftBtnWithTitle:@""];
        tp.ctrlRightBtn.hidden = YES;
        [tp changeTitle:@"健康知识"];
        [self addSubview:tp];
        
        //搜索------
        //提示
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
        img.center = tp.ctrlLeftBtn.center;
        img.image = [UIImage imageNamed:@"search_icon.png"];
        [tp addSubview:img];
        //搜索面板
        SearchPanel *sp = [[SearchPanel alloc] initWithVc:self.nrVc];
        [self addSubview:sp];
        self.ctrlSearchPanel = sp;

        //tableView
        UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, tp.bottom, self.width, vc.contentPanel.height - [SysInfo instance].bottomPanelHeight) style:UITableViewStylePlain];
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



#pragma mark -
#pragma mark ------------------------TopPanelDelegate---------------------------
/*------------------------------------------------------------------------------
 |  TopPanelDelegate
 |
 -----------------------------------------------------------------------------*/
-(void)onTopPanelLeftBtnClicked {
    [self.ctrlSearchPanel openPanel];
}

-(void)onTopPanelRightBtnClicked {
}


#pragma mark -
#pragma mark ------------------------------tableView----------------------------------
/*------------------------------------------------------------------------------
 |  tableView
 |
 -----------------------------------------------------------------------------*/
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [HkCell CellHeight:@"详情详情详情详情详情详情详情详情详情详情详情详情详情"];
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
    HkCell *c = [[HkCell alloc] initWithVc:self.nrVc];
    c.tag = 100;
    [cell addSubview:c];
}

- (void)makeCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    HkCell *c = (HkCell *)[cell viewWithTag:100];
    [c refreshWithTitle:@"喝茶容易流失钙铁?" msg:@"详情详情详情详情详情详情详情详情详情详情详情详情详情" name:@"张三" time:@"2014-09-20 20:18"];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
