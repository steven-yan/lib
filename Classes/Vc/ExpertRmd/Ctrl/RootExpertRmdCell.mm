/**
 *
 *  RootExpertRmdCell
 *  @author steven
 *  @date   July 10 2014
 *
 **/

#import "RootExpertRmdCell.h"

@implementation RootExpertRmdCell
static int kCellHeight = 60;



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithVc:(BaseVc *)vc {
    if (self = [super initWithFrame:CGRectMake(0, 0, vc.view.width, kCellHeight)]) {
        //页面
        self.nrVc = vc;
        //-
        
        //控件-------------------
        //图片
        UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 45, 45)];
        v.layer.cornerRadius = 3;
        v.layer.masksToBounds = YES;
        v.backgroundColor = [UIColor clearColor];
        v.centerY = self.height / 2;
        [self addSubview:v];
        self.ctrlImg = v;
        //名称
        UILabel *name = [UILabel labelWithLeft:v.right + 12 Top:v.top+3 Width:SysInfo.instance.fullWidth - v.right - 5 - 60  Height:14 FontSize:15];
        [self addSubview:name];
        self.ctrlLabelName = name;
        //描述
        UILabel *dsp = [UILabel labelWithLeft:name.left  Top:name.bottom + 5 Width:SysInfo.instance.fullWidth - v.right - 5 - 40  Height:24 FontSize:10];
        dsp.textColor = [UIColor grayColor];
        dsp.numberOfLines = 2;
        [self addSubview:dsp];
        self.ctrlLabelDsp = dsp;
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
//高度
+ (float)CellHeight {
    return kCellHeight;
}

//刷新
- (void)refreshWithCellData:(RootExpertRmdCellData *)data {
    //TODO: 图片
    [self.ctrlImg sd_setImageWithURL:[NSURL URLWithString:data.imgUrl] placeholderImage:[UIImage imageNamed:@"portrait_default"]];
    //名称
    self.ctrlLabelName.text = [@"" stringByAppendingString:data.name];
    //简介
    self.ctrlLabelDsp.text = [@"简介: " stringByAppendingString:data.desp];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
