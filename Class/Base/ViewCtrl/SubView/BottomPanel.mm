/**
 * 
 *@author steven.yan
 *
 */

#import "BottomPanel.h"

@implementation BottomPanel



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithVc:(BaseVC *)vc normalImgList:(NSArray *)normalImgList highImgList:(NSArray *)highImgList titleList:(NSArray *)titleList {
    if (self = [super initWithFrame:CGRectMake(0, 0, 320, 49)]) {
        //页面------
        self.nrVc = vc;
        self.bottom = vc.contentPanel.height;
        if (normalImgList.count != highImgList.count || highImgList.count != titleList.count) {
            return nil;
        } else {
            self.itemNum = normalImgList.count;
        }
        
        //控件----------------
        //分隔线------
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        v.backgroundColor = [UIColor redColor];
        [self addSubview:v];
        
        //按钮------
        NSMutableArray *imgViewList = [[NSMutableArray alloc] init];
        CGRect rect = CGRectMake(0, 0.5, 320.0 / self.itemNum, 49);
        
        for (int i = 0; i < self.itemNum; i++) {
            //按钮
            rect.origin.x = 320.f / self.itemNum * i;
            UIButton *btn = [[UIButton alloc] initWithFrame:rect];
            btn.adjustsImageWhenHighlighted = NO;
            btn.tag = i;
            [btn addTarget:self action:@selector(btnClicked:)];
            [btn setBgImg:[normalImgList objectAtIndex:i]];
            [self addSubview:btn];
            //test
            [imgViewList addObject:btn];
            
//            //图标
//            UIImageView *iv = [[UIImageView alloc] initWithFrame:btn.bounds];
//            [iv setImage:[UIImage imageNamed:[normalImgList objectAtIndex:i]]];
//            iv.centerX = btn.centerX;
//            [self addSubview:iv];
//            [imgViewList addObject:iv];
            
            //名字
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 42, btn.width, 10)];
            label.textColor = [UIColor lightTextColor];
            label.font = [UIFont systemFontOfSize:8];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [titleList objectAtIndex:i];
            label.centerX = btn.centerX;
            [self addSubview:label];
        }
        
        //数据-------------------
        //图片列表
        self.normalImgList = [normalImgList copy];
        self.highImgList = [highImgList copy];
        self.imgViewList = imgViewList;
        //视图索引
        self.selectedIndex = -1;
    }
    
    return self;
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void) btnClicked:(UIButton *)btn {
    for (int i = 0; i < self.itemNum; i++) {
        UIButton *rbtn = [self.imgViewList objectAtIndex:i];
        
        if (btn.tag == rbtn.tag) {
            [rbtn setBgImg:[self.highImgList objectAtIndex:i]];
        } else {
            [rbtn setBgImg:[self.normalImgList objectAtIndex:i]];
        }
    }
    
    BOOL r = [self.delegate respondsToSelector:@selector(BottomPanelClicked:index:)];
    if (r) {
        [self.delegate BottomPanelClicked:self index:btn.tag];
    }
}



@end
