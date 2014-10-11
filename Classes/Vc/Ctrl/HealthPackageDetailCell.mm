/**
 *
 *  HealthPackageDetailCell
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "HealthPackageDetailCell.h"

@implementation HealthPackageDetailCell
static int kCellHeight = 60;
static int kLeftMargin = 15;
static int kWidth;


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
        self.ctrlGroupName = name;
        //详情
        UILabel *detail = [UILabel labelWithLeft:kLeftMargin Top:name.bottom Width:name.width Height:20 FontSize:14];
        detail.numberOfLines = 0;
        [self addSubview:detail];
        self.ctrlDetail = detail;
        
        //分割线
        UIView *line = [UIView lineWithWidth:self.width];
        line.bottom = self.height;
        [self addSubview:line];
        self.ctrlLine = line;
        
        //数据-------------------
        kWidth = detail.width;
    }
    
    return self;
}



#pragma mark -
#pragma mark ------------------------------方法----------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/
+ (float)CellHeight:(NSString *)detail {
    CGSize size = [UILabel dynamicHeightWithStr:detail width:kWidth fontSize:14];
    return kCellHeight + size.height - 20;
}

- (void)refreshWithItemData:(HealthPackageDetailCellData *)d {
    self.ctrlGroupName.text = [@"组合: " stringByAppendingString:d.groupName];
    [self.ctrlDetail setDynamicWithStr:d.detail fontSize:14];
    self.ctrlLine.bottom = self.ctrlDetail.bottom + 10;
    self.height = self.ctrlLine.bottom;
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
