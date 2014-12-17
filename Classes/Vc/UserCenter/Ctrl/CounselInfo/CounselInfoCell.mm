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
static int kCellHeight = 66;



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
        UILabel *content = [UILabel labelWithLeft:kLeftMargin Top:2 Width:vc.contentPanel.width - kLeftMargin - 50 Height:40 FontSize:14];
        content.numberOfLines = 0;
        [self addSubview:content];
        self.ctrlContent = content;
        //未读个数
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
        v.layer.cornerRadius = v.height / 2;
        v.clipsToBounds = YES;
        v.backgroundColor = [UIColor redColor];
        v.right = self.width - 35;
        v.top = 15;
        [self addSubview:v];
        self.ctrlUnReadBg = v;
        UILabel *l = [UILabel labelWithLeft:0 Top:0 Width:16 Height:10 FontSize:10];
        l.textAlignment = NSTextAlignmentCenter;
        l.textColor = [UIColor whiteColor];
        l.centerX = v.width / 2;
        l.centerY = v.height / 2;
        [v addSubview:l];
        self.ctrlUnRead = l;
        //时间
        l = [UILabel labelWithLeft:0 Top:0 Width:120 Height:20 FontSize:12];
        l.textAlignment = NSTextAlignmentRight;
        l.textColor = [UIColor grayColor];
        l.bottom = self.height - 5;
        l.right = self.right - 30;
        [self addSubview:l];
        self.ctrlTime = l;
        
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

- (void)refreshWithDic:(NSDictionary *)dic {
//    NSString *messageId = [dic valueForKey:@"messageId"];
    NSString *content = [dic valueForKey:@"content"];
    NSString *sendTime = [dic valueForKey:@"sendTime"];
    NSString *unReadCount = [dic valueForKey:@"unReadCount"];
    
    //handle nil
//    messageId = [ChkUtil handleNil:messageId];
    content = [ChkUtil handleNil:content];
    sendTime = [ChkUtil handleNil:sendTime];
    unReadCount = [ChkUtil handleNil:unReadCount];
    
    self.msgId = [dic valueForKey:@"messageId"];
    self.ctrlContent.text = content;
    self.ctrlTime.text = sendTime;
    if ([unReadCount intValue] > 0) {
        self.ctrlUnRead.text = unReadCount;
        self.ctrlUnRead.hidden = NO;
        self.ctrlUnReadBg.hidden = NO;
    } else {
        self.ctrlUnRead.hidden = YES;
        self.ctrlUnReadBg.hidden = YES;
    }
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
