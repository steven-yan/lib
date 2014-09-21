/**
 * 
 *@author steven.yan
 *
 */

#import "TabBarBottomPanel.h"

@implementation TabBarBottomPanel



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithImgList:(NSArray *)normalImgList selectedImgList:(NSArray *)selectedImgList titleList:(NSArray *)titleList {
    if (self = [super initWithFrame:CGRectMake(0, 0, 320, 49)]) {
        //页面------
        if (normalImgList.count != selectedImgList.count || selectedImgList.count != titleList.count) {
            return nil;
        }
        
        //控件----------------
        //分隔线------
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        v.backgroundColor = [UIColor colorWithHexStr:@"#c8c8c8"];
        [self addSubview:v];
        //设置
        [self setImgList:normalImgList selectedImgList:selectedImgList titleList:titleList];
        
        //视图索引
        self.selectedIndex = 0;
    }
    
    return self;
}



#pragma mark -
#pragma mark ------------------------------方法----------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/
- (void)setImgList:(NSArray *)normalImgList
   selectedImgList:(NSArray *)selectedImgList
         titleList:(NSArray *)titleList {
    //容错
    if (normalImgList.count != selectedImgList.count || selectedImgList.count != titleList.count) {
        return;
    }
    
    //itemNum
    self.itemNum = normalImgList.count;
    self.arrayOfBtn = [[NSMutableArray alloc] init];
    self.arrayOfNormalImg = [[NSMutableArray alloc] init];
    self.arrayOfSelectedImg = [[NSMutableArray alloc] init];
    
    //按钮------
    CGRect rect = CGRectMake(0, 0.5, Global.instance.sysInfo.fullWidth / self.itemNum, 49);
    for (int i = 0; i < self.itemNum; i++) {
        NSString *normalImg = [normalImgList objectAtIndex:i];;
        NSString *selectedImg = [selectedImgList objectAtIndex:i];;
        NSString *title = [titleList objectAtIndex:i];;
        
        //按钮
        rect.origin.x = Global.instance.sysInfo.fullWidth / self.itemNum * i;
        UIButton *btn = [[UIButton alloc] initWithFrame:rect];
        [btn addTarget:self action:@selector(btnClicked:)];
        [btn setTitle:title];
        [btn setImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
        btn.adjustsImageWhenHighlighted = NO;
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        btn.imageEdgeInsets = UIEdgeInsetsMake(floor((btn.bounds.size.height / 2) -
                                                     (btn.imageView.image.size.height / 2) - 10),
                                               floor((btn.bounds.size.width / 2) -
                                                     (btn.imageView.image.size.width / 2)),
                                               floor((btn.bounds.size.height / 2) -
                                                     (btn.imageView.image.size.height / 2)),
                                               floor((btn.bounds.size.width / 2) -
                                                     (btn.imageView.image.size.width / 2)));
        btn.titleEdgeInsets = UIEdgeInsetsMake(floor(btn.imageView.image.size.height / 2 + btn.titleLabel.size.height / 2 + 8), -25, 0, 0);
        btn.tag = i;
        [self addSubview:btn];
        [btn setImage:[UIImage imageNamed:@"btn_air_hospital_normal@2x"] forState:UIControlStateNormal];
        
        //数据
        [self.arrayOfBtn addObject:btn];
        [self.arrayOfNormalImg addObject:normalImg];
        [self.arrayOfSelectedImg addObject:selectedImg];
    }
    
    //设置索引
    [self setIndex:0];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)btnClicked:(UIButton *)btn {
    NSInteger index = btn.tag;
    
    if (index >= self.itemNum || index == self.selectedIndex) {
        return;
    }
    
    //设置索引
    [self setIndex:index];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarBottomPanelClicked:index:)]) {
        [self.delegate tabBarBottomPanelClicked:self index:btn.tag];
    }
}

- (void)setIndex:(NSInteger)index {
    //设置默认索引
    self.selectedIndex = index;
    
    //设置默认
    for (NSInteger i = 0; i < self.itemNum; i++) {
        UIButton *btn = [self.arrayOfBtn objectAtIndex:i];
        NSString *normalImg = [self.arrayOfNormalImg objectAtIndex:i];
        
        [btn setTitleColor:[UIColor colorWithHexStr:@"#cccccc"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
    }
    
    //设置高亮
    UIButton *btn = [self.arrayOfBtn objectAtIndex:index];
    [btn setTitleColor:[UIColor colorWithHexStr:kGeneralColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:[self.arrayOfSelectedImg objectAtIndex:index]] forState:UIControlStateNormal];
}



@end
