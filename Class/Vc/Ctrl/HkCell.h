/**
 *
 *@author steven.yan
 *
 */
#import "BaseVC.h"

@protocol HkCellDelegate <NSObject>
@optional
@end

@interface HkCell : UIView

//代理
@property (weak) NSObject<HkCellDelegate> *delegate;
//页面
@property (weak) BaseVC *nrVc;

//title
@property (nonatomic, strong) UILabel *ctrlLabelTitle;
//详情
@property (nonatomic, strong) UILabel *ctrlLabelMsg;
//昵称
@property (nonatomic, strong) UILabel *ctrlLabelNickName;
//时间
@property (nonatomic, strong) UILabel *ctrlLabelTime;
//分隔线
@property (nonatomic, strong) UIView *ctrlLine;

//初始化
- (id)initWithVc:(BaseVC *)vc;

//高度
+ (float)CellHeight:(NSString *)msg;
//刷新
- (void)refreshWithTitle:(NSString *)title
                     msg:(NSString *)msg
                    name:(NSString *)name
                    time:(NSString *)time;



@end
