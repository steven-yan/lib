/**
 *
 *  RootHealthCenterCell
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "RootHealthCenterCell.h"

@implementation RootHealthCenterCell
static int kCellHeight = 80;



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
        UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 50, 50)];
        v.layer.cornerRadius = 6;
        v.layer.masksToBounds = YES;
        v.backgroundColor = [UIColor clearColor];
        [v setImage:[UIImage imageNamed:@"rr_rmd"]];
        v.centerY = self.height / 2;
        [self addSubview:v];
        self.ctrlImg = v;
        //名称
        UILabel *name = [UILabel labelWithLeft:v.right + 12 Top:v.top Width:SysInfo.instance.fullWidth - v.right - 5 - 60  Height:14 FontSize:14];
        [self addSubview:name];
        self.ctrlLabelName = name;
        //地址
        UILabel *addr = [UILabel labelWithLeft:name.left  Top:name.bottom + 8 Width:SysInfo.instance.fullWidth - v.right - 5 - 60  Height:14 FontSize:10];
        [self addSubview:addr];
        self.ctrlLabelAddr = addr;
        //电话
        UILabel *phone = [UILabel labelWithLeft:name.left Top:addr.bottom Width:SysInfo.instance.fullWidth - v.right - 5 - 60  Height:14 FontSize:10];
        [self addSubview:phone];
        self.ctrlLabelPhone = phone;
        //电话按钮
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [btn addTarget:self action:@selector(btnClicked:)];
        [btn setImage:[UIImage imageNamed:@"tips_icon_call"] forState:UIControlStateNormal];
        btn.centerX = name.right + 10;
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

- (void)refreshWithCellData:(RootHealthCenterCellData *)data {
    //TODO: 图片
    [self.ctrlImg sd_setImageWithURL:[NSURL URLWithString:data.imgUrl] placeholderImage:[UIImage imageNamed:@"rr_rmd"]];
    //名称
    self.ctrlLabelName.text = [@"" stringByAppendingString:data.name];
    //地址
    self.ctrlLabelAddr.text = [@"地址: " stringByAppendingString:data.addr];
    //电话
    self.ctrlLabelPhone.text = [@"电话: " stringByAppendingString:data.tel];
    
    //data
    self.data = data;
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)btnClicked:(UIButton *)btn {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.data.tel]];
}



@end
