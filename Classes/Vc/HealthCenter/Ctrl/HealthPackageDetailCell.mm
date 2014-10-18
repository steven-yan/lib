/**
 *
 *  HealthPackageDetailCell
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "HealthPackageDetailCell.h"

@implementation HealthPackageDetailCell
//TODO: kCellHeight 分隔线消失  
static int kCellHeight = 50;
static int kLeftMargin = 15;
static int kFontSize = 12;
static int kLabelWidth = Global.instance.sysInfo.fullWidth - 2*kLeftMargin;


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
        UILabel *name = [UILabel labelWithLeft:kLeftMargin Top:10 Width:kLabelWidth Height:20 FontSize:14];
        [self addSubview:name];
        self.ctrlGroupName = name;
        //详情
        UILabel *detail = [UILabel labelWithLeft:kLeftMargin Top:name.bottom+5 Width:kLabelWidth Height:20 FontSize:kFontSize];
        detail.textColor = [UIColor grayColor];
        detail.numberOfLines = 0;
        [self addSubview:detail];
        self.ctrlDetail = detail;
        
        //分割线
        UIView *line = [UIView lineWithWidth:self.width];
        [self addSubview:line];
        self.ctrlLine = line;
        
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
+ (float)CellHeight:(NSString *)detail {
    CGSize size = [UILabel dynamicHeightWithStr:detail width:kLabelWidth fontSize:kFontSize];
    return kCellHeight + size.height;
}

- (void)refreshWithItemData:(HealthPackageDetailCellData *)d {
    
    self.ctrlGroupName.text = [@"组合: " stringByAppendingString:d.groupName];
    [self.ctrlDetail setDynamicWithStr:d.detail fontSize:kFontSize];
    self.ctrlLine.bottom = self.ctrlDetail.bottom + 10;
    self.height = self.ctrlDetail.bottom + 10;
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
