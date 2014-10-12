/**
 *
 * HealthReportListCell
 * @author steven.yan
 * @date Sep 28 2014
 *
 **/

#import "HealthReportListCell.h"

@implementation HealthReportListCell
static int kCellHeight = 60;
static int kLeftMargin = 15;



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithVc:(BaseLayoutVc *)vc {
    if (self = [super initWithFrame:CGRectMake(0, 0, vc.view.width, kCellHeight)]) {
        //页面
        self.nrVc = vc;
        //-
        
        //控件-------------------
        //组合名称
        UILabel *name = [UILabel labelWithLeft:kLeftMargin Top:10 Width:vc.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
        [self addSubview:name];
        self.ctrlName = name;
        //日期
        UILabel *date = [UILabel labelWithLeft:kLeftMargin Top:0 Width:200 Height:20 FontSize:10];
        date.textAlignment = NSTextAlignmentRight;
        date.right = self.width - 40;
        date.bottom = self.bottom;
        [self addSubview:date];
        self.ctrlDate = date;
        
        //分割线
        UIView *line = [UIView lineWithWidth:self.width];
        line.bottom = self.height;
        [self addSubview:line];
        
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
+ (float)CellHeight {
    return kCellHeight;
}

- (void)refreshWith:(NSString *)name date:(NSString *)date {
    self.ctrlName.text = name;
    self.ctrlDate.text = [@"日期:  " stringByAppendingString:date];
}


#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
