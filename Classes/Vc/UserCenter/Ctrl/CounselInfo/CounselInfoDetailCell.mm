/**
 *
 * CounselInfoDetailCell
 * @author steven.yan
 * @date Oct 19 2014
 *
 **/

#import "CounselInfoDetailCell.h"

@implementation CounselInfoDetailCell
static int kMarginWidth = 10;
static int kContentBgWidth = SysInfo.instance.fullWidth - 4 * kMarginWidth;
static int kContentWidth = kContentBgWidth - 2 * kMarginWidth;
static int kCellMinHeight = 140;
static int kCellHeight;
static int kFontSize = 14;



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithVc:(BaseLayoutVc *)vc {
    if (self = [super initWithFrame:CGRectMake(0, 0, vc.view.width, kCellMinHeight)]) {
        //页面
        self.nrVc = vc;
        //-
        
        //控件-------------------
        //头像--
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 50, 50)];
        iv.layer.cornerRadius = 6;
        iv.layer.masksToBounds = YES;
        [self addSubview:iv];
        self.ctrlIvUser = iv;
        //名字--
        UILabel *l = [UILabel labelWithLeft:0 Top:0 Width:100 Height:20 FontSize:kFontSize];
        l.centerY = iv.height/2;
        [self addSubview:l];
        self.ctrlName = l;
        //bg
        UIImageView *v = [[UIImageView alloc] init];
        v.layer.cornerRadius = 6;
        v.layer.borderColor = [UIColor colorWithHexStr:@"#cccccc"].CGColor;
        v.layer.borderWidth = 0.5;
        v.top = iv.bottom+5;
        [self addSubview:v];
        self.ctrlContentBg = v;
        //内容--
        l = [UILabel labelWithLeft:0 Top:0 Width:kContentWidth Height:20 FontSize:14];
        l.numberOfLines = 0;
        l.top = v.top + kMarginWidth;
        l.left = v.left + kMarginWidth;
        [self addSubview:l];
        self.ctrlContent = l;
        //时间--
        l = [UILabel labelWithLeft:0 Top:0 Width:100 Height:20 FontSize:12];
        l.textColor = [UIColor grayColor];
        l.textAlignment = NSTextAlignmentRight;
        l.right = self.width - kMarginWidth;
        l.bottom = self.height;
        [self addSubview:l];
        self.ctrlTime = l;
        
        //line
        UIView *line = [UIView lineWithWidth:self.width];
        [self addSubview:line];
        line.bottom = self.height;
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
+ (float)CellHeight:(CounselInfoDetailCellData *)d {
    float height = [UILabel dynamicHeightWithStr:d.content width:kContentWidth fontSize:kFontSize].height;
    
    kCellHeight = kCellMinHeight - 20 + height;
    if (kCellHeight < kCellMinHeight) {
        kCellHeight = kCellMinHeight;
    }
    
    return kCellHeight;
}

- (void)refreshWithCellData:(CounselInfoDetailCellData *)d {
    BOOL tag = NO;
    if ([d.sendFrom isEqualToString:Global.instance.userInfo.userLoginId]) {
        tag = YES;
    }
    
    if (tag) {
        self.ctrlIvUser.right = self.width - kMarginWidth;
        self.ctrlName.right = self.ctrlIvUser.left - 5;
        self.ctrlName.textAlignment = NSTextAlignmentRight;
        self.ctrlContentBg.backgroundColor = [UIColor colorWithHexStr:@"#cccccc"];
        self.ctrlContentBg.layer.borderWidth = 0.5;
        self.ctrlContentBg.right = self.ctrlIvUser.right;
        self.ctrlContent.right = self.ctrlContentBg.right - kMarginWidth;
        [self.ctrlIvUser sd_setImageWithURL:[NSURL URLWithString:Global.instance.userInfo.photoPath] placeholderImage:[UIImage imageNamed:@"portrait_default"]];
    } else {
        self.ctrlIvUser.left = kMarginWidth;
        self.ctrlName.left = self.ctrlIvUser.right + 5;
        self.ctrlName.textAlignment = NSTextAlignmentLeft;
        self.ctrlContentBg.backgroundColor = [UIColor colorWithHexStr:@"#fcf4de"];
        self.ctrlContentBg.layer.borderWidth = 0;
        self.ctrlContentBg.left = kMarginWidth;
        self.ctrlContent.left = self.ctrlContentBg.left + kMarginWidth;
        [self.ctrlIvUser sd_setImageWithURL:[NSURL URLWithString:d.photoPath] placeholderImage:[UIImage imageNamed:@"doctor_default"]];
    }
    
    self.ctrlName.text = d.sendFromName;
    self.ctrlTime.text = d.sendTime;
    CGSize size = [self.ctrlContent setDynamicWithStr:d.content fontSize:kFontSize];
//    [self.ctrlContentBg setImage:[[UIImage imageNamed:@"cell_comment_icon"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]];
    self.ctrlContentBg.height = self.ctrlContent.height + 2*kMarginWidth;
    self.ctrlContentBg.width = self.ctrlContent.width + 2*kMarginWidth;
    self.ctrlTime.top = self.ctrlContentBg.bottom + 10;
    
    kCellHeight = kCellMinHeight - 20 + self.ctrlContent.height;
    if (kCellHeight < kCellMinHeight) {
        kCellHeight = kCellMinHeight;
    }
    
    self.ctrlContentBg.left = self.ctrlContent.left - kMarginWidth;
    self.ctrlContentBg.width = size.width + 2*kMarginWidth;
    
    self.ctrlLine.bottom = kCellHeight;
    self.height = kCellHeight;
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
