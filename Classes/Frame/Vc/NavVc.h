/**
 *
 *  NavVc
 *  @author steven
 *  @date Otc 22 2014
 *
 **/

#import <objc/runtime.h>

@interface NavVc : UINavigationController <UIGestureRecognizerDelegate>

//snap
@property (nonatomic, strong) UIImageView *ctrlSnap;

//保存图片
- (void)setVcPic:(BaseVc *)vc view:(UIView *)v;
//获取图片
- (UIImage *)getVcPic:(BaseVc *)vc;
//清空
- (void)cleanVcPic:(BaseVc *)vc;



@end
