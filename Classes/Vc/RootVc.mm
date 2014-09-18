/**
 *
 *  RootVc
 *  @author steven
 *  @date   July 10 2014
 *
 **/

#import "RootVc.h"

@implementation RootVc



#pragma mark -
#pragma mark ------------------------------窗体----------------------------------
/*------------------------------------------------------------------------------
 |  窗体
 |
 -----------------------------------------------------------------------------*/
//窗体创建
- (void)onCreate {
    //顶部面板-----------
    self.topPanel.hidden = YES;
    //内容面板-----------
    NSMutableArray *pa = [[NSMutableArray alloc] init];
    RootVcPanel0 *rp0 = [[RootVcPanel0 alloc] initWithVc:self];
    [pa addObject:rp0];
    [self.view addSubview:rp0];
    
    RootVcPanel1 *rp1 = [[RootVcPanel1 alloc] initWithVc:self];
    [pa addObject:rp1];
    [self.view addSubview:rp1];

    RootVcPanel2 *rp2 = [[RootVcPanel2 alloc] initWithVc:self];
    [pa addObject:rp2];
    [self.view addSubview:rp2];
    
//    RootVcPanel3 *rp3 = [[RootVcPanel3 alloc] initWithVc:self];
//    [pa addObject:rp3];
//    [self.view addSubview:rp3];
    
    RootVcPanel4 *rp4 = [[RootVcPanel4 alloc] initWithVc:self];
    [pa addObject:rp4];
    [self.view addSubview:rp4];

    self.panelArray = pa;
    
    
    //底部面板-----------
    NSMutableArray *normalImgList = [[NSMutableArray alloc] init];
    NSMutableArray *highImgList = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i++) {
        NSString *normalImg = [NSString stringWithFormat:@"%d", i];
        [normalImgList addObject:normalImg];
        NSString *highImg = [NSString stringWithFormat:@"%d_hl", i];
        [highImgList addObject:highImg];
    }
    NSArray *titleList = @[@"专家推荐", @"体检中心", @"健康知识", @"我的"];
    
    BottomPanel *bp = [[BottomPanel alloc] initWithVc:self normalImgList:normalImgList highImgList:highImgList titleList:titleList];
    bp.delegate = self;
    [self.contentPanel addSubview:bp];
    self.ctrlBottomPanel = bp;
    
    //其他--------------
    //显示
    [self showPanelWithIdx:2];
    [bp setIndex:2];
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
}

//解析导航返回
- (void)onPraseNavBackParams:(NSDictionary *)params {
}

//窗体将要显示------
- (void)onWillShow {
}

//窗体显示
- (void)onShow {
}

//隐藏------
- (void)onWillHide {
}

//导航栏------
- (void)topLeftBtnClicked {
    [self navBack];
}

- (void)topRightBtnClicked {
}



#pragma mark -
#pragma mark -------------------------BottomPanelDelegate-----------------------
/*------------------------------------------------------------------------------
 |  BottomPanelDelegate
 |
 -----------------------------------------------------------------------------*/
- (void)BottomPanelClicked:(BottomPanel *)sender index:(int)index {
    [self showPanelWithIdx:index];
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)showPanelWithIdx:(int)idx {
    //容错
    if (idx >= self.panelArray.count) {
        return;
    }
    
    for (int i = 0; i < 5; i++) {
        UIView *v = [self.panelArray objectAtIndex:i];
        
        if (i == idx) {
            v.hidden = NO;
        } else {
            v.hidden = YES;
        }
    }
}



@end
