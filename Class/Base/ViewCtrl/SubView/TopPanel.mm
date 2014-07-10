/**
 * 
 *@author steven.yan
 *
 */

#import "TopPanel.h"

@implementation TopPanel



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
-(id)init {
    int top = 0;
    if ([SysInfo instance].isIos7Tag) {
        top = 20;
    }
    
    if (self = [super initWithFrame:CGRectMake(0, top, 320, 44)]) {
        //页面
        self.backgroundColor = [UIColor colorWithHexStr:@"#212121"];
        //-
        
        //控件-------------------
        //左侧按钮------
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(5, 6, 50, 30)];
        [btn setBackgroundImage:[UIImage imageNamed:@"NavLeft"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"NavLeft_Selected"] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        self.ctrlLeftBtn = btn;
        [self addSubview:btn];
        //标题栏------
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 200, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.centerX = self.centerX;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"标题";
        self.ctrlTitle = label;
        [self addSubview:label];
        //右侧按钮------
        btn = [[UIButton alloc] initWithFrame:CGRectMake(260, 6, 50, 30)];
        [btn setBackgroundImage:[UIImage imageNamed:@"NavRight"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"NavRight_Selected"] forState:UIControlStateSelected];
        [btn setTitle:@"添加" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        self.ctrlRightBtn = btn;
        [self addSubview:btn];
        
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
- (void)changeTitle:(NSString *)str {
    self.ctrlTitle.text = str;
}

- (void)changeLeftBtnWithTitle:(NSString *)title {
    [self.ctrlLeftBtn setTitle:title forState:UIControlStateNormal];
}

- (void)changeRightBtnWithTitle:(NSString *)title {
    [self.ctrlRightBtn setTitle:title forState:UIControlStateNormal];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)leftBtnClicked {
    if (self.delegate != nil) {
        BOOL r = [self.delegate respondsToSelector:@selector(onTopPanelLeftBtnClicked)];
        
        if (r) {
            [self.delegate onTopPanelLeftBtnClicked];
        }
    }
}

- (void)rightBtnClicked {
    if (self.delegate != nil) {
        BOOL r = [self.delegate respondsToSelector:@selector(onTopPanelRightBtnClicked)];

        if (r) {
            [self.delegate onTopPanelRightBtnClicked];
        }
    }
}



@end
