/**
 * 
 *@author steven.yan
 *
 */

#import "HealthyCheckCenterCell.h"

@implementation HealthyCheckCenterCell
static int kCellHeight = 45;



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
        //iv
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(18, 0, 30, 30)];
        iv.layer.cornerRadius = 6;
        iv.layer.masksToBounds = YES;
        iv.centerY = self.height / 2;
        [self addSubview:iv];
        self.ctrlIv = iv;
        //onLine hint
        UIImageView *hintView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 10, 10)];
        [hintView setImage:[UIImage imageNamed:@"state_online"]];
        [iv addSubview:hintView];
        self.ctrlOnlineHint = hintView;
        
        //label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(iv.right + 10, 0, 200, 40)];
        label.textColor = [UIColor colorWithHexStr:@"#696969"];
        label.backgroundColor = [UIColor clearColor];
        label.centerY = iv.centerY;
        [self addSubview:label];
        self.ctrlLabel = label;
        
        //arrow
        iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 13)];
        [iv setImage:[UIImage imageNamed:@"ic_more"]];
        iv.right = self.width - 20;
        iv.centerY = self.height / 2;
        [self addSubview:iv];
        
        //分隔线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(label.left, 0, self.width - label.left, 1)];
        line.backgroundColor = [UIColor colorWithHexStr:@"#c7c7c7"];
        line.bottom = self.height;
        [self addSubview:line];
        //数据-------------------
        //其他-------------------
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

//刷新
- (void)refreshWithImg:(UIImage *)img name:(NSString *)name onlineTag:(BOOL)onLineTag {
    //img
    [self.ctrlIv setImage:img];
    //name
    self.ctrlLabel.text = name;
    //online hint
    self.ctrlOnlineHint.hidden = !onLineTag;
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
