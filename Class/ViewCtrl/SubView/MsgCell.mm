/**
 * 
 *@author steven.yan
 *
 */

#import "MsgCell.h"

@implementation MsgCell
static int kVerticalMargin = 8;
static int kContentHeight = 60;
static int kFontMsg = 14;
static int kMsgWidth = 238;


#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithVc:(BaseVC *)vc {
    if (self = [super initWithFrame:CGRectMake(0, 0, vc.view.width, kContentHeight + 2 * kVerticalMargin)]) {
        //页面
        self.nrVc = vc;
        //-
        
        //控件-------------------
        //边框------
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(6, kVerticalMargin, self.width - 12, kContentHeight)];
        bg.layer.cornerRadius = 6;
        bg.layer.borderWidth = 1.0;
        bg.layer.borderColor = [UIColor colorWithHexStr:@"#abc1cf"].CGColor;
        [self addSubview:bg];
        self.ctrlBg = bg;
        
        //图片------
        UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 45, 45)];
        v.layer.cornerRadius = 3;
        v.layer.masksToBounds = YES;
        v.backgroundColor = [UIColor clearColor];
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
        UILabel *tl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 15)];
        tl.right = bg.width - 20;
        tl.bottom = self.ctrlBg.height - 5;
        tl.textAlignment = NSTextAlignmentRight;
        tl.backgroundColor = [UIColor clearColor];
        tl.font = [UIFont systemFontOfSize:12];
        [bg addSubview:tl];
        self.ctrlLabelTime = tl;

        //nickname
        UILabel *nl = [[UILabel alloc] initWithFrame:CGRectMake(0, tl.top, 150, 15)];
        nl.right = tl.left - 10;
        nl.textAlignment = NSTextAlignmentRight;
        nl.backgroundColor = [UIColor clearColor];
        nl.font = [UIFont systemFontOfSize:12];
        [bg addSubview:nl];
        self.ctrlLabelNickName = nl;

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
- (void)refreshWithImg:(UIImage *)img msg:(NSString *)msg name:(NSString *)name time:(NSString *)time {
    //img
    if (img) {
        [self.ctrlImg setImage:img];
    } else {
        [self.ctrlImg setImage:[UIImage imageNamed:@"MessageView"]];
    }
    
    //bg
    self.ctrlBg.height = [MsgCell CellHeight:msg] - 2 * kVerticalMargin;
    
    //img
    self.ctrlImg.centerY = self.ctrlBg.height / 2;
    
    //msg
    self.ctrlLabelMsg.text = msg;
    self.ctrlLabelMsg.height = [self msgHeightWithStr:msg];
    //name
    self.ctrlLabelNickName.text = name;
    self.ctrlLabelNickName.bottom = self.ctrlBg.height - 5;
    //time
    self.ctrlLabelTime.text = time;
    self.ctrlLabelTime.top = self.ctrlLabelNickName.top;
    
    //height
    self.height = [MsgCell CellHeight:msg];
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
