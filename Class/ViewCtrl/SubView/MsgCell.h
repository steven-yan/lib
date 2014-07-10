/**
 *
 *@author steven.yan
 *
 */
#import "BaseVC.h"

@protocol MsgCellDelegate <NSObject>
@optional
@end

@interface MsgCell : UIView

//代理
@property (weak) NSObject<MsgCellDelegate> *delegate;
//页面
@property (weak) BaseVC *nrVc;

//背景
@property (nonatomic, strong) UIView *ctrlBg;
//图片
@property (nonatomic, strong) UIImageView *ctrlImg;
//推送消息
@property (nonatomic, strong) UILabel *ctrlLabelMsg;
//昵称
@property (nonatomic, strong) UILabel *ctrlLabelNickName;
//时间
@property (nonatomic, strong) UILabel *ctrlLabelTime;

//初始化
- (id)initWithVc:(BaseVC *)vc;

//高度
+ (float)CellHeight:(NSString *)msg;
//刷新
- (void)refreshWithImg:(UIImage *)img
                   msg:(NSString *)msg
                  name:(NSString *)name
                  time:(NSString *)time;



@end
