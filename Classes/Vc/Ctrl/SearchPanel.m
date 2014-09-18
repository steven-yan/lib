/**
 * xxxxx
 *
 */

#import "SearchPanel.h"

@implementation SearchPanel
enum {
    kSearchNoTextTag = 1,
    kSearchNoResultTag,
    kSearchShowResultTag,
};



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
-(id)initWithVc:(BaseLayoutVc *)vc {
    if (self = [super initWithFrame:CGRectMake(0, vc.topPanel.top, vc.view.width, vc.view.height - vc.topPanel.height)]) {
        //页面
        self.nrVc = vc;
        //-
        [vc.view addSubview:self];
        self.hidden = YES;
        
        //控件-------------------
        //背景
        UIScrollView *bg = [[UIScrollView alloc] initWithFrame:self.bounds];
        bg.backgroundColor = [UIColor blackColor];
        bg.showsVerticalScrollIndicator = NO;
        bg.delegate = self;
        bg.alpha = 0.4;
        //添加点击事件
        UITapGestureRecognizer *tg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgClicked)];
        [bg addGestureRecognizer:tg];
        [self addSubview:bg];
        self.ctrlBg = bg;

        //搜索框大背景
        UIView *sb = [[UIView alloc] initWithFrame:CGRectMake(0, bg.top, self.width, 46)];
        sb.backgroundColor = [UIColor colorWithHexStr:@"#dcdcdc"];
        //搜索框小背景
        UIView *tb = [[UIView alloc] initWithFrame:CGRectMake(15, 8, 250, 30)];
        tb.layer.cornerRadius = 6;
        tb.backgroundColor = [UIColor whiteColor];
        //搜索图标
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 15, 15)];
        [icon setImage:[UIImage imageNamed:@"search_icon"]];
        [tb addSubview:icon];
        //textfiled
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(32, 5.5, tb.width - 40, tb.height - 10)];
        tf.delegate = self;
        tf.placeholder = @"搜索健康知识";
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        tf.keyboardType = UIKeyboardTypeDefault;
        tf.returnKeyType = UIReturnKeyDone;
        tf.backgroundColor = [UIColor clearColor];
        [tf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        self.ctrlTf = tf;
        [tb addSubview:tf];
        //完成按钮
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(tb.right + 10, 15, 40, 16)];
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:@"完成"];
        [btn setTitleColor:[UIColor colorWithHexStr:@"#007aff"]];
        [btn addTarget:self action:@selector(btnClicked)];
        [sb addSubview:btn];
        
        [sb addSubview:tb];
        
        [self addSubview:sb];
        self.ctrlSearchBar = sb;
        
        //tableView
        UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, self.ctrlSearchBar.bottom, self.width, self.height - vc.topPanel.height)];
        tv.backgroundColor = [UIColor clearColor];
        tv.separatorStyle = UITableViewCellSeparatorStyleNone;
        tv.delegate = self;
        tv.dataSource = self;
        [self addSubview:tv];
        self.ctrlTableView = tv;
        
        //搜索提示
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(125, bg.top + 160, 100, 25)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"没有结果";
        label.font = [UIFont fontWithName:@"Arial" size:18];
        label.textColor = [UIColor darkGrayColor];
        label.hidden = YES;
        [bg addSubview:label];
        self.ctrlHint = label;
        
        //数据-------------------
        //搜索数据
        //搜索结果
    }
    
    return self;
}



#pragma mark -
#pragma mark ------------------------------方法----------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/
-(void)openPanel {
    //重置
    [self clean];
    //显示
    [self show];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
#pragma mark -
#pragma mark ------textField
-(void) textFieldDidChange:(id)sender {
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [self handleResultWithTag:kSearchNoTextTag];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (![textField.text isEqualToString:@""]) {
        [textField resignFirstResponder];
    }
    return YES;
}



#pragma mark -
#pragma mark ------tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResult.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"CSTkSearchPanelidentifier";

    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [self createCell:cell];
    }
    
    [self makeCell:cell withIndex:indexPath];
    
    return cell;
}

- (void)createCell:(UITableViewCell *)cell {
    
    //指示
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)makeCell:(UITableViewCell *)cell withIndex:(NSIndexPath *)indexPath {
    int row = indexPath.row;
    
    if (row >= self.searchResult.count){
        return;
    }
    
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.ctrlTf resignFirstResponder];
}



-(void)handleResultWithTag:(int)tag{
    self.ctrlTableView.hidden = YES;
    [self.ctrlBg setContentSize:self.bounds.size];
    if (tag == kSearchNoTextTag) {                  //输框为空
        self.ctrlBg.backgroundColor = [UIColor blackColor];
        self.ctrlBg.alpha = 0.4;
        self.ctrlHint.hidden= YES;
        self.searchTag = NO;
    } else {
        self.ctrlBg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"frame_bg"]];
        self.ctrlBg.alpha = 1.0;
        self.searchTag = YES;
        if (tag == kSearchNoResultTag) {            //没有搜索结果
            self.ctrlHint.hidden = NO;
            [self.ctrlBg setContentSize:CGSizeMake(self.width, self.height + 1)];
        } else if (tag == kSearchShowResultTag) {   //加载结果
            self.ctrlHint.hidden = YES;
            self.ctrlTableView.hidden = NO;
            [self.ctrlTableView setContentOffset:CGPointMake(0, 0) animated:NO];
            [self.ctrlTableView reloadData];
        }
    }
}

-(void)clean {
    //背景
    self.ctrlBg.backgroundColor = [UIColor blackColor];
    self.ctrlBg.alpha = 0.4;
    //搜索框
    self.ctrlTf.text = nil;
    //tableView
    self.ctrlTableView.hidden = YES;
    //搜索提示
    self.ctrlHint.hidden= YES;
}

-(void)bgClicked {
    if (self.searchTag == NO) {
        [self hide];
    }
}

-(void)btnClicked {
    [self hide];
}

-(void)show {
    [self.ctrlTf becomeFirstResponder];
    [self bringToFont];
    self.hidden = NO;
}

-(void)hide {
    [self.ctrlTf resignFirstResponder];
    self.hidden = YES;
}



@end
