/**
 *
 *  SliderLeftPanel
 *  @author steven
 *  @date July 22 2014
 *
 **/

@class SliderLeftPanel;

@protocol SliderLeftPanelDelegate <NSObject>
@optional
- (void)sliderLeftPanel:(SliderLeftPanel *)slider;
@end

@interface SliderLeftPanel : UIView <UIGestureRecognizerDelegate>

//代理
@property (weak) NSObject<SliderLeftPanelDelegate> *delegate;
//nrVc
@property (weak) BaseVc *nrVc;

@property (nonatomic) CGFloat contentWidth;
@property (nonatomic) BOOL showTag;

//初始化
- (id)initWithVc:(BaseVc *)vc contentWidth:(CGFloat)width;
- (void)show;
- (void)hide;


@end
