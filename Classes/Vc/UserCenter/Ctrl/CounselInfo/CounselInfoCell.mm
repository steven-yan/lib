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
static int kCellHeight = 50;



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
        //内容
        UILabel *content = [UILabel labelWithLeft:kLeftMargin Top:0 Width:vc.contentPanel.width - 2 *kLeftMargin Height:40 FontSize:14];
        content.numberOfLines = 2;
        [self addSubview:content];
        self.ctrlContent = content;
        
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

- (void)refreshWithContent:(NSString *)content msgId:(NSString *)msgId {
    self.msgId = msgId;
    self.ctrlContent.text = [@"内容:" stringByAppendingString:content];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
