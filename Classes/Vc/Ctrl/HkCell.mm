/**
 * 
 *@author steven.yan
 *
 */

#import "HkCell.h"

@implementation HkCell
static int kTopMargin = 8;
static int kFontMsg = 14;
static int kMsgWidth = 230;


#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithVc:(BaseVc *)vc {
    if (self = [super initWithFrame:CGRectMake(0, 0, vc.view.width, 40)]) {
        //页面
        self.nrVc = vc;
        //-
        
        //控件-------------------
        //标题
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 5 + kTopMargin, kMsgWidth, 16)];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:18];
        [self addSubview:title];
        self.ctrlLabelTitle = title;
        
        //详情
        UILabel *ml = [[UILabel alloc] initWithFrame:CGRectMake(10, title.bottom + 5, kMsgWidth, 16)];
        ml.textAlignment = NSTextAlignmentLeft;
        ml.numberOfLines = 0;
        ml.backgroundColor = [UIColor clearColor];
        ml.font = [UIFont systemFontOfSize:kFontMsg];
        [self addSubview:ml];
        self.ctrlLabelMsg = ml;
        
        //时间
        UILabel *tl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 15)];
        tl.textAlignment = NSTextAlignmentRight;
        tl.right = 300;
        tl.bottom = self.height - 5;
        tl.backgroundColor = [UIColor clearColor];
        tl.font = [UIFont systemFontOfSize:12];
        [self addSubview:tl];
        self.ctrlLabelTime = tl;
        
        //nickname
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, tl.top, 40, 15)];
        name.right = tl.left - 10;
        name.textAlignment = NSTextAlignmentRight;
        name.backgroundColor = [UIColor clearColor];
        name.font = [UIFont systemFontOfSize:12];
        [self addSubview:name];
        self.ctrlLabelNickName = name;
        
        //分隔线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        line.bottom = self.height;
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
    
    return height + 40 + kTopMargin * 2;
}

//刷新
- (void)refreshWithTitle:(NSString *)title msg:(NSString *)msg name:(NSString *)name
                    time:(NSString *)time {
    //height
    self.height = [HkCell CellHeight:msg];

    //title
    self.ctrlLabelTitle.text = title;
    //msg
    self.ctrlLabelMsg.text = msg;
    self.ctrlLabelMsg.height = [self msgHeightWithStr:msg];
    //name
    self.ctrlLabelNickName.text = name;
    self.ctrlLabelNickName.bottom = self.height - 5;
    //time
    self.ctrlLabelTime.text = time;
    self.ctrlLabelTime.top = self.ctrlLabelNickName.top;
    
    self.ctrlLine.bottom = [HkCell CellHeight:msg] - self.ctrlLine.height;
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
