/**
 *
 *@author steven.yan
 *
 */
#import "BaseVc.h"

@protocol ExpertCellDelegate <NSObject>
@optional
@end

@interface ExpertCell : UIView

//代理
@property (weak) NSObject<ExpertCellDelegate> *delegate;
//页面
@property (weak) BaseVc *nrVc;

//背景
@property (nonatomic, strong) UIView *ctrlBg;
//图片
@property (nonatomic, strong) UIImageView *ctrlImg;
//推送消息
@property (nonatomic, strong) UILabel *ctrlLabelMsg;
//昵称
@property (nonatomic, strong) UILabel *ctrlLabelName;
//时间
@property (nonatomic, strong) UILabel *ctrlLabelExpert;

//初始化
- (id)initWithVc:(BaseVc *)vc;

//高度
+ (float)CellHeight:(NSString *)msg;
//刷新
- (void)refreshWithImg:(UIImage *)img
                   msg:(NSString *)msg
                  name:(NSString *)name;


@end
