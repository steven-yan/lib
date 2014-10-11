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
    if (self = [super initWithFrame:CGRectMake(0, Global.instance.sysInfo.topMarginHeight, Global.instance.sysInfo.fullWidth, Global.instance.sysInfo.topPanelHeight)]) {
        //页面
        self.backgroundColor = [UIColor generalColor];
        //-
        
        //控件-------------------
        //左侧按钮------
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(5, 6, 55, 30)];
        //图片--
        [btn setImage:[UIImage imageNamed:@"btn_back_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"btn_back_disabled"] forState:UIControlStateHighlighted];
        //标题--
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -1, 0, 0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        self.ctrlLeftBtn = btn;
        //标题栏------
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, 200, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.centerX = self.centerX;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"标题";
        [self addSubview:label];
        self.ctrlTitle = label;
        //适配ios6
        if (SysInfo.instance.isIos6Tag) {
            self.ctrlTitle.centerY = self.centerY;
        }
        
        //右侧按钮------
        btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 6, 50, 30)];
        [btn setTitle:@"更多" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        btn.right = self.width;
        [self addSubview:btn];
        self.ctrlRightBtn = btn;
        
        //数据-------------------
        //其他-------------------
    }
    
    return self;
}



#pragma mark -
#pragma mark ------------------------------方法----------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/
- (void)changeTitle:(NSString *)title {
    self.ctrlTitle.text = title;
}

- (void)changeLeftBtnWithTitle:(NSString *)title {
    [self.ctrlLeftBtn setTitle:title forState:UIControlStateNormal];
}

- (void)changeRightBtnWithTitle:(NSString *)title {
    [self.ctrlRightBtn setTitle:title forState:UIControlStateNormal];
}

- (void)changeRightBtnWithImg:(NSString *)img {
    //清空title
    [self.ctrlRightBtn setTitle:@"" forState:UIControlStateNormal];
    [self.ctrlRightBtn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
}
- (void)changeRightBtnWithHlImg:(NSString *)hlImg {
    [self.ctrlRightBtn setImage:[UIImage imageNamed:hlImg] forState:UIControlStateHighlighted];
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
