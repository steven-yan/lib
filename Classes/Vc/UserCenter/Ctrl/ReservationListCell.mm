/**
 *
 * ReservationListCell
 * @author steven.yan
 * @date Otc 7 2014
 *
 **/

#import "ReservationListCell.h"

@implementation ReservationListCell
static int kCellHeight = 120;
static int kLeftMargin = 20;



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
        //体检号
        UILabel *peId = [UILabel labelWithLeft:kLeftMargin Top:12 Width:vc.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
        [self addSubview:peId];
        self.ctrlPeMasterId = peId;
        //套餐名称
        UILabel *name = [UILabel labelWithLeft:kLeftMargin Top:peId.bottom+2 Width:vc.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
        [self addSubview:name];
        self.ctrlPackageName = name;
        //体检中心名称
        name = [UILabel labelWithLeft:kLeftMargin Top:name.bottom+2 Width:vc.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
        [self addSubview:name];
        self.ctrlPeisName = name;
        //预约状态
        name = [UILabel labelWithLeft:kLeftMargin Top:name.bottom+2 Width:vc.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
        [self addSubview:name];
        self.ctrlStatus = name;
        //预约时间
        UILabel *date = [UILabel labelWithLeft:0 Top:name.bottom Width:vc.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:10];
        date.textAlignment = NSTextAlignmentRight;
        date.right = self.width - 30;
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

- (void)refreshWithCellData:(ReservationListCellData *)d {
    //peId
    self.ctrlPeMasterId.text = [@"体检号:  " stringByAppendingString:d.peMasterId];
    //package
    self.ctrlPackageName.text = [@"套餐:  " stringByAppendingString:d.packageName];
    //peisname
    self.ctrlPeisName.text = [@"体检中心:  " stringByAppendingString:d.peisName];
    //status
    self.ctrlStatus.text = [@"预约状态:  " stringByAppendingString:d.statusText];
    //预约状态和预约时间
    self.ctrlDate.text = [@"预约日期:  " stringByAppendingString:d.peDate];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
