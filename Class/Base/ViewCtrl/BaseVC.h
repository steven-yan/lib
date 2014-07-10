/**
 *
 * @author steven.yan
 *
 */

#import "TopPanel.h"
#import "MBProgressHUD.h"

typedef enum {
    NavStyleDefault = 0, 
    NavStyleBottomToTop,  
    NavStyleTopToBottom, 
    NavStyleLeftToRight,  
    NavStyleFadeIn,
    NavStyleFadeOut,
    NavStyleNoEffect,
} NavStyle;

@interface BaseVC : UIViewController <TopPanelDelegate>

//顶部面板
@property (nonatomic, strong) TopPanel *topPanel;
//内容面板
@property (nonatomic, strong) UIView *contentPanel;
//Hud
@property (nonatomic, strong) MBProgressHUD *ctrlHud;

//导航前进标识
@property BOOL _navToTag;
//导航前进参数
@property (nonatomic, strong)  NSMutableDictionary *_tmpNavToParams;
//导航返回标识
@property BOOL _navBackTag;
//导航返回参数
@property (nonatomic, strong)  NSMutableDictionary *_tmpNavBackParams;

//显示------
- (void)onWillShow;
- (void)onShow;
//隐藏------
- (void)onWillHide;

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

//导航--------
- (void)navTo:(NSString *)vcKey;
- (void)navTo:(NSString *)vcKey style:(NavStyle)style;
- (void)navTo:(NSString *)vcKey params:(NSMutableDictionary *)params;
- (void)navTo:(NSString *)vcKey params:(NSMutableDictionary *)params style:(NavStyle)style;

- (void)navBack;
- (void)navBackWithStyle:(NavStyle)style;
- (void)navBackWithParams:(NSMutableDictionary *)params;
- (void)navBackWithParams:(NSMutableDictionary *)params style:(NavStyle)style;
- (void)navBackTo:(NSString *)vcKey;
- (void)navBackTo:(NSString *)vcKey style:(NavStyle)style;
- (void)navBackTo:(NSString *)vcKey params:(NSMutableDictionary *)params;
- (void)navBackTo:(NSString *)vcKey params:(NSMutableDictionary *)params style:(NavStyle)style;

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
