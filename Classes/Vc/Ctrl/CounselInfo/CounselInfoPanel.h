/**
 *
 * CounselInfoPanel
 * @author steven.yan
 * @date Oct 7 2014
 *
 **/

@protocol CounselInfoPanelDelegate <NSObject>
@optional
@end

@interface CounselInfoPanel : UIView

//代理
@property (weak) NSObject<CounselInfoPanelDelegate> *delegate;
//页面
@property (weak) BaseVc *nrVc;

//tv
@property (nonatomic, strong) UITextView *ctrlTv;

//初始化
- (id)initWithVc:(BaseLayoutVc *)vc;
//显示
- (void)show;



@end
