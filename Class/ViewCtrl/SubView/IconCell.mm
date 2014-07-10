/**
 * 
 *@author steven.yan
 *
 */

#import "IconCell.h"
#import "Global.h"

@implementation IconCell
static int kCellHeight = 166;



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithVc:(BaseVC *)vc {
    if (self = [super initWithFrame:CGRectMake(0, 0, vc.view.width, kCellHeight)]) {
        //页面
        self.nrVc = vc;
        //-

        //控件-------------------
        NSMutableArray *bgList = [[NSMutableArray alloc] init];
        NSMutableArray *imgList = [[NSMutableArray alloc] init];
        NSMutableArray *nameList = [[NSMutableArray alloc] init];
        NSMutableArray *imgHintList = [[NSMutableArray alloc] init];
        CGRect rect = CGRectMake(0, 0, 132, kCellHeight);
        for (int i = 0; i < 2; i++) {
            rect.origin.x = 18 + (133 + 18)* i;
            //背景
            UIImageView *v = [[UIImageView alloc] initWithFrame:rect];
            [v setImage:[UIImage stretchableImageNamed:@"icon_bg"]];
            [self addSubview:v];
            [bgList addObject:v];
            
            //图片
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(6, 2, v.width - 12, v.width - 12)];
            iv.layer.borderWidth = 1;
            iv.layer.borderColor = [UIColor grayColor].CGColor;
            iv.layer.cornerRadius = 10;
            iv.layer.masksToBounds = YES;
            [v addSubview:iv];
            [imgList addObject:iv];
            
            //名字
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, iv.bottom + 10, 100, 15)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:14];
            label.adjustsFontSizeToFitWidth = YES;
            [v addSubview:label];
            [nameList addObject:label];
            
            //添加按钮
            UIButton *btn = [[UIButton alloc] initWithFrame:v.frame];
            btn.tag = i;
            [btn addTarget:self action:@selector(cellClicked:)];
            [self addSubview:btn];
            
            //测试------------
            iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            [iv setImage:[UIImage imageNamed:@"state_online"]];
            iv.bottom = v.height - 16;
            iv.right = v.width - 10;
            iv.hidden = YES;
            [v addSubview:iv];
            [imgHintList addObject:iv];
        }
        
        //数据-------------------
        self.bgList = bgList;
        self.imgList = imgList;
        self.nameList = nameList;
        self.imgHintList = imgHintList;
        self.elementNum = 0;

        //其他-------------------
        OBSERVE_NOTIFICATION(NN_STR_FRIEND_STATUS_CHANGED, onGetFriendStateChanged:);
    }
    
    return self;
}

- (void)dealloc {
    REMOVE_NOTIFICATION;
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

- (void)refreshWithNameList:(NSMutableArray *)nameList
                   jidList:(NSMutableArray *)jidList {
    //容错
    if (jidList.count != nameList.count) {
        return;
    }
    
    //元素个数
    self.elementNum = nameList.count;
    
    //显示全部
    for (UIView *v in self.bgList) {
        v.hidden = NO;
    }
    
    //刷新
    for (int i = 0; i < self.elementNum; i++) {
        //获取图片
        UIImageView *iv = [self.imgList objectAtIndex:i];
        
        APPDELEGATE;
        UIImage *img = [appDelegate getRosterPhoto:[jidList objectAtIndex:i]];
        if (img != nil) {
            [iv setImage:img];
        } else {
            [iv setImage:[UIImage imageNamed:@"pet_avatar"]];
        }
        
        //名字
        UILabel *label = [self.nameList objectAtIndex:i];
        label.text = [nameList objectAtIndex:i];
        
        //在线提醒
        iv = [self.imgHintList objectAtIndex:i];
        NSString *state = [appDelegate.jid_state_dic valueForKey:[[jidList objectAtIndex:i] bare]];
        if ([state isEqualToString:@"available"]) {
            iv.hidden = NO;
        } else {
            iv.hidden = YES;
        }
    }
    
    //设置jid
    self.jidList = [jidList copy];
    
    //隐藏不需要的视图
    for (int i = self.elementNum; i < 2; i++) {
        UIView *v = [self.bgList objectAtIndex:i];
        v.hidden = YES;
    }
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)cellClicked:(UIButton *)btn {
    int index = btn.tag;
    
    //容错
    if (index >= self.elementNum) {
        return;
    }
    
    if (self.delegate != nil) {
        BOOL r = [self.delegate respondsToSelector:@selector(onIconCellSelected:)];
        if (r) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            //图片
            UIImageView *imageView = [self.imgList objectAtIndex:index];
            [params setValue:imageView.image forKey:@"image"];
            //nickName
            UILabel *label = [self.nameList objectAtIndex:index];
            [params setValue:label.text forKey:@"nickName"];
            //jid
            XMPPJID *jid = [self.jidList objectAtIndex:index];
            [params setValue:jid forKey:@"device_jid"];
            
            [self.delegate onIconCellSelected:params];
        }
    }
}

//test------
- (void)onGetFriendStateChanged:(NSNotification *)notify {
    NSDictionary *params = notify.object;

    //容错
    XMPPJID *jid = [params valueForKey:@"jid"];
    if (jid == nil) {
        return;
    }
    
    for (int i = 0; i < self.jidList.count; i++) {
        UIImageView *iv = [self.imgHintList objectAtIndex:i];
        XMPPJID *dev_jid = [self.jidList objectAtIndex:i];

        if ([dev_jid isEqualToJID:jid options:XMPPJIDCompareBare]) {
            NSString *status = [params valueForKey:@"status"];
            
            if ([status isEqualToString:@"available"]) {
                iv.hidden = NO;
            } else if ([status isEqualToString:@"unavailable"]) {
                iv.hidden = YES;
            }
        }
    }
}



@end
