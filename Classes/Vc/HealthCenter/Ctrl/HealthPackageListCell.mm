/**
 *
 *  HealthPackageCell
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "HealthPackageListCell.h"

@implementation HealthPackageListCell
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
        //名字
        UILabel *name = [UILabel labelWithLeft:kLeftMargin Top:8 Width:vc.contentPanel.width - 2 *kLeftMargin Height:20 FontSize:14];
        [self addSubview:name];
        self.ctrlName = name;
        //价格
        UILabel *price = [UILabel labelWithLeft:kLeftMargin Top:name.bottom+5 Width:100 Height:20 FontSize:14];
        price.textColor = [UIColor grayColor];
        [self addSubview:price];
        self.ctrlPrice = price;
        //预定
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        [btn setTitle:@"预约"];
        [btn addTarget:self action:@selector(btnClicked:)];
        [btn setStyleGreen];
        btn.right = self.width - 30;
        btn.centerY = self.height / 2;
        [self addSubview:btn];
        
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

- (void)refreshWithItemData:(HealthPackageListCellData *)d index:(NSInteger)idx {
    self.ctrlName.text = [@"套餐: " stringByAppendingString:d.packageName];
    self.ctrlPrice.text = [@"价格: " stringByAppendingString:d.price];
    
    //数据
    self.data = d;
    self.index = idx;
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)btnClicked:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onHealthPackageListCellClicked:)]) {
        [self.delegate onHealthPackageListCellClicked:self.index];
    }
}



@end
