/**
 * 
 *@author steven.yan
 *
 */

#import "TabBarBottomPanel.h"

@implementation TabBarBottomPanel
static int kDefaultSelectedIndex = 0;
static int kInitNum = -1;



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithVc:(BaseLayoutVc *)vc {
    if (self = [super initWithFrame:CGRectMake(0, 0, Global.instance.sysInfo.fullWidth, Global.instance.sysInfo.tabBarPanelHeight)]) {
        //页面--------
        self.nrVc = vc;
        self.backgroundColor = [UIColor whiteColor];
        //控件-------
        //分隔线------
        UIView *line = [UIView lineWithWidth:self.width];
        [self addSubview:line];
        //数据-------
        //索引
        self.selectedIndex = kDefaultSelectedIndex;
        self.itemNum = kInitNum;
        self.selectedIndex = kInitNum;
    }
    
    return self;
}



#pragma mark -
#pragma mark ------------------------------方法----------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/
- (void)setImgList:(NSArray *)normalImgList selectedImgList:(NSArray *)selectedImgList titleList:(NSArray *)titleList {
    //容错
    if (normalImgList.count != selectedImgList.count || selectedImgList.count != titleList.count) {
        return;
    }
    
    //itemNum
    if (self.itemNum != kInitNum && self.itemNum != normalImgList.count) {
        return;
    }
    self.itemNum = normalImgList.count;
    
    //array
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
    [self setIndex:kDefaultSelectedIndex];
}

- (void)setContentPanel:(NSArray *)tabBarContentPanelList {
    //itemNum
    if (self.itemNum != kInitNum && self.itemNum != tabBarContentPanelList.count) {
        return;
    }
    self.itemNum = tabBarContentPanelList.count;
    
    //check TabBarContentPanel class
    for (id content in tabBarContentPanelList) {
        if (![content isKindOfClass:NSClassFromString(@"TabBarContentPanel")]) {
            return;
        }
    }
    
    self.arrayOfTabBarContent = [[NSMutableArray alloc] init];
    for (TabBarContentPanel *tabBarContent in tabBarContentPanelList) {
        [self.arrayOfTabBarContent addObject:tabBarContent];
    }
    
    //设置索引
    [self setIndex:kDefaultSelectedIndex];
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
}

- (void)setIndex:(NSInteger)index {
    if (self.arrayOfBtn.count > 0) {
        //设置默认
        for (NSInteger i = 0; i < self.itemNum; i++) {
            UIButton *btn = [self.arrayOfBtn objectAtIndex:i];
            NSString *normalImg = [self.arrayOfNormalImg objectAtIndex:i];
            
            [btn setTitleColor:[UIColor colorWithHexStr:@"#cccccc"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
        }
        
        //设置高亮
        UIButton *btn = [self.arrayOfBtn objectAtIndex:index];
        [btn setTitleColor:[UIColor generalColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[self.arrayOfSelectedImg objectAtIndex:index]] forState:UIControlStateNormal];
    }
    
    if (self.arrayOfTabBarContent.count > 0) {
        TabBarContentPanel *tabBarContent = [self.arrayOfTabBarContent objectAtIndex:self.selectedIndex];
        [tabBarContent onWillHide];
        tabBarContent.hidden = YES;
        
        tabBarContent = [self.arrayOfTabBarContent objectAtIndex:index];
        [self.nrVc.contentPanel addSubview:tabBarContent];
        [self.nrVc.contentPanel setNeedsLayout];
        [tabBarContent onWillShow];
        tabBarContent.hidden = NO;
    }
    
    //设置默认索引
    self.selectedIndex = index;
}

- (void)reloadPanel:(NSInteger)index {
    TabBarContentPanel *p = [self.arrayOfTabBarContent objectAtIndex:index];
    [p reloadPanel];
}



@end
