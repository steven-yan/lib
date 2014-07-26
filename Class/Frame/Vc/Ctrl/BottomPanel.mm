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
- (id)initWithVc:(BaseLayoutVc *)vc normalImgList:(NSArray *)normalImgList highImgList:(NSArray *)highImgList titleList:(NSArray *)titleList {
    if (self = [super initWithFrame:CGRectMake(0, 0, 320, 49)]) {
        //页面------
        self.nrVc = vc;
        self.bottom = vc.contentPanel.height;
        self.backgroundColor = [UIColor colorWithHexStr:@"#f0f0f0"];
        if (normalImgList.count != highImgList.count || highImgList.count != titleList.count) {
            return nil;
        } else {
            self.itemNum = normalImgList.count;
        }
        
        //控件----------------
        //分隔线------
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        v.backgroundColor = [UIColor colorWithHexStr:@"#c8c8c8"];
        [self addSubview:v];
        
        //按钮------
        NSMutableArray *imgViewList = [[NSMutableArray alloc] init];
        NSMutableArray *nameLabelList = [[NSMutableArray alloc] init];
        CGRect rect = CGRectMake(0, 0.5, 320.0 / self.itemNum, 49);
        
        for (int i = 0; i < self.itemNum; i++) {
            //按钮
            rect.origin.x = 320.f / self.itemNum * i;
            UIButton *btn = [[UIButton alloc] initWithFrame:rect];
            btn.adjustsImageWhenHighlighted = NO;
            btn.tag = i;
            [btn addTarget:self action:@selector(btnClicked:)];
            [self addSubview:btn];
            
            //图标
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 30, 30)];
            [iv setImage:[UIImage imageNamed:[normalImgList objectAtIndex:i]]];
            iv.centerX = btn.centerX;
            [self addSubview:iv];
            [imgViewList addObject:iv];
            
            //名字
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, iv.bottom, btn.width, 10)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor colorWithHexStr:@"#838383"];
            label.font = [UIFont systemFontOfSize:8];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [titleList objectAtIndex:i];
            label.centerX = btn.centerX;
            [self addSubview:label];
            [nameLabelList addObject:label];
        }
        
        //数据-------------------
        //图片列表
        self.normalImgList = [normalImgList copy];
        self.highImgList = [highImgList copy];
        self.imgViewList = imgViewList;
        self.nameLabelList = nameLabelList;
        //视图索引
        self.selectedIndex = -1;
    }
    
    return self;
}



#pragma mark -
#pragma mark ------------------------------方法----------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/
- (void)setIndex:(int)idx {
    if (idx >= self.itemNum) {
        return;
    }

    [self setBgWithIdx:idx];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void) btnClicked:(UIButton *)btn {
    //set idx
    [self setBgWithIdx:btn.tag];
    
    BOOL r = [self.delegate respondsToSelector:@selector(BottomPanelClicked:index:)];
    if (r) {
        [self.delegate BottomPanelClicked:self index:btn.tag];
    }
}

- (void)setBgWithIdx:(int)idx {
    for (int i = 0; i < self.itemNum; i++) {
        UIImageView *iv = [self.imgViewList objectAtIndex:i];
        UILabel *label = [self.nameLabelList objectAtIndex:i];
        
        if (idx == i) {
            [iv setImage:[UIImage imageNamed:[self.highImgList objectAtIndex:i]]];
            label.textColor = [UIColor colorWithHexStr:@"#f34747"];
            self.selectedIndex = i;
        } else {
            [iv setImage:[UIImage imageNamed:[self.normalImgList objectAtIndex:i]]];
            label.textColor = [UIColor colorWithHexStr:@"#838383"];
        }
    }
}



@end
