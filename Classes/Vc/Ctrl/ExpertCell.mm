/**
 * 
 *@author steven.yan
 *
 */

#import "ExpertCell.h"

@implementation ExpertCell
static int kVerticalMargin = 8;
static int kContentHeight = 60;
static int kFontMsg = 14;
static int kMsgWidth = 230;


#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithVc:(BaseVc *)vc {
    if (self = [super initWithFrame:CGRectMake(0, 0, vc.view.width, kContentHeight + 2 * kVerticalMargin)]) {
        //页面
        self.nrVc = vc;
        //-
        
        //控件-------------------
        //边框------
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(6, kVerticalMargin, self.width - 12, kContentHeight)];
        bg.layer.cornerRadius = 6;
        bg.layer.borderWidth = 0.5;
        bg.layer.borderColor = [UIColor colorWithHexStr:@"#abc1cf"].CGColor;
        [self addSubview:bg];
        self.ctrlBg = bg;
        
        //图片------
        UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 45, 45)];
        v.layer.cornerRadius = 3;
        v.layer.masksToBounds = YES;
        v.backgroundColor = [UIColor clearColor];
        [v setImage:[UIImage imageNamed:@"rr_rmd"]];
        v.centerY = bg.height / 2;
        [bg addSubview:v];
        self.ctrlImg = v;
        
        //消息
        UILabel *ml = [[UILabel alloc] initWithFrame:CGRectMake(v.right + 10, 5, kMsgWidth, 16)];
        ml.textAlignment = NSTextAlignmentLeft;
        ml.numberOfLines = 0;
        ml.backgroundColor = [UIColor clearColor];
        ml.font = [UIFont systemFontOfSize:kFontMsg];
        [bg addSubview:ml];
        self.ctrlLabelMsg = ml;
        
        //时间
        UILabel *expertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 15)];
        expertLabel.right = bg.width - 45;
        expertLabel.bottom = self.ctrlBg.height - 5;
        expertLabel.text = @"专家:";
        expertLabel.backgroundColor = [UIColor clearColor];
        expertLabel.font = [UIFont systemFontOfSize:12];
        [bg addSubview:expertLabel];
        self.ctrlLabelExpert = expertLabel;
        
        //nickname
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, expertLabel.top, 40, 15)];
        name.left = expertLabel.right;
        name.text = @"张三";
        name.backgroundColor = [UIColor clearColor];
        name.font = [UIFont systemFontOfSize:12];
        [bg addSubview:name];
        self.ctrlLabelName = name;

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
+ (float)CellHeight:(NSString *)msg {
    float height;
    
    if ([msg respondsToSelector:@selector(sizeWithFont:constrainedToSize:lineBreakMode:)]) {
        height = [msg sizeWithFont:[UIFont systemFontOfSize:kFontMsg]
               constrainedToSize:CGSizeMake(kMsgWidth, MAXFLOAT)
                   lineBreakMode:NSLineBreakByWordWrapping].height;
    } else {
        height = [msg boundingRectWithSize:CGSizeMake(kMsgWidth, MAXFLOAT)
                                 options:NSStringDrawingUsesLineFragmentOrigin
                              attributes:[UIFont systemFontOfSize:kFontMsg].fontDescriptor.fontAttributes
                                 context:nil].size.height;
    }
    
    if (height >= 20) {
        height = height + 30 + 2 * kVerticalMargin;
    } else {
        height = kContentHeight + 2 * kVerticalMargin;
    }

    return height;
}

//刷新
- (void)refreshWithImg:(UIImage *)img msg:(NSString *)msg name:(NSString *)name {
    //img
    if (img) {
        [self.ctrlImg setImage:img];
    } else {
        [self.ctrlImg setImage:[UIImage imageNamed:@"rr_rmd"]];
    }
    
    //bg
    self.ctrlBg.height = [ExpertCell CellHeight:msg] - 2 * kVerticalMargin;
    
    //img
    self.ctrlImg.centerY = self.ctrlBg.height / 2;
    
    //msg
    self.ctrlLabelMsg.text = msg;
    self.ctrlLabelMsg.height = [self msgHeightWithStr:msg];
    //name
    self.ctrlLabelName.text = name;
    self.ctrlLabelName.bottom = self.ctrlBg.height - 5;
    self.ctrlLabelExpert.bottom = self.ctrlBg.height - 5;
    
    //height
    self.height = [ExpertCell CellHeight:msg];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (CGFloat)msgHeightWithStr:(NSString *)str {
    CGSize size;
    
    if ([str respondsToSelector:@selector(sizeWithFont:constrainedToSize:lineBreakMode:)]) {
        size = [str sizeWithFont:[UIFont systemFontOfSize:kFontMsg]
                    constrainedToSize:CGSizeMake(kMsgWidth, MAXFLOAT)
                        lineBreakMode:NSLineBreakByWordWrapping];
    } else {
        size = [str boundingRectWithSize:CGSizeMake(kMsgWidth, MAXFLOAT)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:[UIFont systemFontOfSize:kFontMsg].fontDescriptor.fontAttributes
                                      context:nil].size;
    }
    
    return size.height;
}



@end
