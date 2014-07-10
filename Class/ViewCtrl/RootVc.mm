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
    
    //底部面板-----------
    NSMutableArray *normalImgList = [[NSMutableArray alloc] init];
    NSMutableArray *highImgList = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        NSString *normalImg = [NSString stringWithFormat:@"frame_bv_btn_%d", i + 1];
        [normalImgList addObject:normalImg];
        NSString *highImg = [NSString stringWithFormat:@"frame_bv_btn_%d_hl", i + 1];
        [highImgList addObject:highImg];
    }
    NSArray *titleList = @[@"餐厅", @"选手", @"11", @"22", @"33"];
    
    BottomPanel *bp = [[BottomPanel alloc] initWithVc:self normalImgList:normalImgList highImgList:highImgList titleList:titleList];
    bp.delegate = self;
    [self.contentPanel addSubview:bp];
    self.ctrlBottomPanel = bp;
    
    //其他--------------
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
- (void)BottomPanelClicked:(id)sender index:(int)index {

}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
