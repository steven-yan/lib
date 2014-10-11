/**
 *
 *  CounselInfoCell
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "CounselInfoCell.h"

@implementation CounselInfoCell
static int kLeftMargin = 15;
static int kCellHeight = 40;



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
        name.text = @"zizz:";
        [self addSubview:name];
        self.ctrlGroupName = name;
        //详情
        UILabel *price = [UILabel labelWithLeft:kLeftMargin Top:name.bottom Width:name.width Height:20 FontSize:14];
        [self addSubview:price];
        self.ctrlDetail = price;
        
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



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
