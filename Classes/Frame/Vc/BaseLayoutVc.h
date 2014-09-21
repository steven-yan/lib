/**
 *
 * @author steven.yan
 *
 */

#import "TopPanel.h"
#import "MBProgressHUD.h"

@interface BaseLayoutVc : BaseVc <TopPanelDelegate>

//顶部面板
@property (nonatomic, strong) TopPanel *topPanel;
//内容面板
@property (nonatomic, strong) UIView *contentPanel;
//Hud
@property (nonatomic, strong) MBProgressHUD *ctrlHud;

//顶部面板--------
//显示隐藏------
- (void)hideTopPanel;
- (void)showTopPanel;
//左侧按键
- (void)hideTopLeftBtn;
- (void)showTopLeftBtn;
- (void)changeTopLeftBtnTitle:(NSString *)title;
//标题栏
- (void)changeTopTitle:(NSString *)str;
//右侧按键
- (void)hideTopRightBtn;
- (void)showTopRightBtn;
- (void)changeTopRightBtnTitle:(NSString *)title;

//HUD--------
//msg------
- (void)showHudLoading;
- (void)showHudWithMsg:(NSString *)msg;
- (void)dismissHud;
//toast----
- (void)showHudWithHint:(NSString *)hint;
- (void)showHudWithBottomHint:(NSString *)hint;
- (void)showHudWithHint:(NSString *)hint yoffset:(float)yoffset;



@end
