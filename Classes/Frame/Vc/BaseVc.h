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

@interface BaseVc : UIViewController <TopPanelDelegate>

//导航前进标识
@property BOOL _navToTag;
//导航返回标识
@property BOOL _navBackTag;
//导航前进参数
@property (nonatomic, strong)  NSDictionary *_tmpNavToParams;
//导航返回参数
@property (nonatomic, strong)  NSDictionary *_tmpNavBackParams;

//创建-销毁
- (void)_onCreateBegin;
- (void)onCreate;
- (void)_onCreateEnd;
- (void)onDidHide;

//显示-隐藏------
- (void)onWillShow;
- (void)onShow;
- (void)onWillHide;

//导航--------
- (void)navTo:(NSString *)vcKey;
- (void)navTo:(NSString *)vcKey style:(NavStyle)style;
- (void)navTo:(NSString *)vcKey params:(NSDictionary *)params;
- (void)navTo:(NSString *)vcKey params:(NSDictionary *)params style:(NavStyle)style;

- (void)navBack;
- (void)navBackWithStyle:(NavStyle)style;
- (void)navBackWithParams:(NSDictionary *)params;
- (void)navBackWithParams:(NSDictionary *)params style:(NavStyle)style;
- (void)navBackTo:(NSString *)vcKey;
- (void)navBackTo:(NSString *)vcKey style:(NavStyle)style;
- (void)navBackTo:(NSString *)vcKey params:(NSDictionary *)params;
- (void)navBackTo:(NSString *)vcKey params:(NSDictionary *)params style:(NavStyle)style;



@end
