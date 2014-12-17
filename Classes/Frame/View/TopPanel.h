/**
 *
 *@author steven.yan
 *
 */

@protocol TopPanelDelegate <NSObject>
@optional
-(void)onTopPanelLeftBtnClicked;
-(void)onTopPanelRightBtnClicked;
@end

@interface TopPanel : UIView

//代理
@property (weak) NSObject<TopPanelDelegate> *delegate;

//左侧按钮
@property (nonatomic, strong) UIButton *ctrlLeftBtn;
//标题栏
@property (nonatomic, strong) UILabel *ctrlTitle;
//右侧按钮
@property (nonatomic, strong) UIButton *ctrlRightBtn;



//初始化
- (id)init;
//设置左侧按键标题
- (void)changeLeftBtnWithTitle:(NSString *)title;
//设置标题
- (void)changeTitle:(NSString *)title;
//设置右侧按键标题
- (void)changeRightBtnWithTitle:(NSString *)title;
//改变图片
- (void)changeRightBtnWithImg:(NSString *)img;
- (void)changeRightBtnWithHlImg:(NSString *)hlImg;



@end
