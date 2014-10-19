/**
 *
 * CounselInfoCell
 * @author steven.yan
 * @date Oct 7 2014
 *
 **/

@protocol CounselInfoCellDelegate <NSObject>
@optional
@end

@interface CounselInfoCell : UIView

//代理
@property (weak) NSObject<CounselInfoCellDelegate> *delegate;
//页面
@property (weak) BaseVc *nrVc;

//内容
@property (nonatomic, strong) UILabel *ctrlContent;
//时间
@property (nonatomic, strong) UILabel *ctrlTime;
//未读格式bg
@property (nonatomic, strong) UIView *ctrlUnReadBg;
@property (nonatomic, strong) UILabel *ctrlUnRead;

//msgId
@property (nonatomic, strong) NSString *msgId;

//初始化
- (id)initWithVc:(BaseLayoutVc *)vc;
//高度
+ (float)CellHeight;
//refresh
- (void)refreshWithDic:(NSDictionary *)dic;



@end
