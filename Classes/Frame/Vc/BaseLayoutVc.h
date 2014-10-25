/**
 *
 * @author steven.yan
 *
 */

#import "TopPanel.h"

@interface BaseLayoutVc : BaseHttpVc <TopPanelDelegate>

//顶部面板
@property (nonatomic, strong) TopPanel *topPanel;
//内容面板
@property (nonatomic, strong) UIScrollView *contentPanel;

//提示----
//load
@property (nonatomic, strong) UIView *ctrlLoading;
//指示器
@property (nonatomic, strong) UIActivityIndicatorView *ctrlIndicator;
//error
@property (nonatomic, strong) UIView *ctrlLoadError;

//toast----
@property (nonatomic, strong) UILabel *ctrlToastHint;
@property (nonatomic, strong) UIView *ctrlToastBg;

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

//loading hint
- (void)showLoading;
- (void)hideLoading;
- (void)showLoadError;

//toast----
- (void)showToast:(NSString *)text;
- (void)hideToast:(id)ss;

@end
