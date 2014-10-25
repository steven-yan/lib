/**
 *
 * CounselInfoPanel
 * @author steven.yan
 * @date Oct 7 2014
 *
 **/

#import "CounselInfoPanel.h"

@implementation CounselInfoPanel



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithVc:(BaseLayoutVc *)vc {
    if (self = [super initWithFrame:vc.contentPanel.bounds]) {
        //页面
        self.nrVc = vc;
        //-
        self.hidden = YES;
        
        //控件-------------------
        //蒙版--
        UIView *bg = [[UIView alloc] initWithFrame:self.bounds];
        bg.backgroundColor = [UIColor blackColor];
        bg.alpha = 0.6;
        [self addSubview:bg];
        
        //tv
        UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(15, 20, bg.width - 30, 100)];
        tv.font = [UIFont systemFontOfSize:14];
        tv.layer.cornerRadius = 4;
        [self addSubview:tv];
        self.ctrlTv = tv;
        
        //按钮----
        //取消--
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [btn addTarget:self action:@selector(cancelBtnClicked:)];
        [btn setTitle:@"取消"];
        [btn setStyleGray];
        [btn setTitleColor:[UIColor whiteColor]];
        btn.top = tv.bottom + 15;
        btn.right = self.centerX - 20;
        [self addSubview:btn];
        //提交--
        btn = [[UIButton alloc] initWithFrame:btn.bounds];
        [btn addTarget:self action:@selector(cmtBtnClicked:)];
        [btn setTitle:@"提交"];
        [btn setStyleGreen];
        btn.top = tv.bottom + 15;
        btn.left = self.centerX + 20;
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
- (void)show {
    self.hidden = NO;
    [self.ctrlTv becomeFirstResponder];
    [self bringToFont];
}

- (void)hide {
    [self.ctrlTv resignFirstResponder];
    self.hidden = YES;
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)cmtBtnClicked:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onCounselInfoPanelCmf:text:)]) {
        [self.delegate onCounselInfoPanelCmf:self text:self.ctrlTv.text];
    }
}

- (void)cancelBtnClicked:(UIButton *)btn {
    [self hide];
}



@end
