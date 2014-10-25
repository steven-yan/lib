/**
 *
 *  CSDatePicker
 *  @author steven.yan
 *  @date Otc 12 2014
 *
 **/

#import "CSDatePicker.h"

@implementation CSDatePicker



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithTitle:(NSString *)title {
    if (self = [super initWithFrame:CGRectMake(00, 0, SysInfo.instance.fullWidth - 20, 300)]) {
        //--
        self.hidden = YES;
        [self setStyleForSection];
        
        //控件-----------------------
        //hint
        UILabel *l = [UILabel labelWithLeft:0 Top:5 Width:self.width Height:20 FontSize:16];
        l.text = title;
        l.textAlignment = NSTextAlignmentCenter;
        [self addSubview:l];
        //picker--
        UIDatePicker *dp = [[UIDatePicker alloc] init];
        dp.datePickerMode = UIDatePickerModeDate;
        dp.top = l.bottom + 5;
        dp.centerX = self.width / 2;
        [self addSubview:dp];
        self.ctrlDatePicker = dp;
        //取消--
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, dp.bottom + 10, 80, 30)];
        [btn addTarget:self action:@selector(cancelBtnClicked:)];
        [btn setTitle:@"取消"];
        btn.right = self.width / 2 - 10;
        [btn setStyleGray];
        [self addSubview:btn];
        //确认--
        btn = [[UIButton alloc] initWithFrame:CGRectMake(0, dp.bottom + 10, 80, 30)];
        [btn addTarget:self action:@selector(cmfBtnClicked:)];
        [btn setTitle:@"确认"];
        btn.left = self.width / 2 + 10;
        [btn setStyleGreen];
        [self addSubview:btn];
        
        //数据-----------------------
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
    //重置
    [self.ctrlDatePicker setDate:[NSDate date]];
    
    [self bringToFont];
    self.hidden = NO;
}

- (NSString *)getDateStr {
    return [TimeUtil timeWithFormat:@"YYYY-MM-dd" date:self.ctrlDatePicker.date];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)cancelBtnClicked:(UIButton *)btn {
    self.hidden = YES;
}

- (void)cmfBtnClicked:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onCSDatePickerDelegate:)]) {
        [self.delegate onCSDatePickerDelegate:self];
    }
}



@end
