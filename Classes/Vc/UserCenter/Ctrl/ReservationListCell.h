/**
 *
 * ReservationListCell
 * @author steven.yan
 * @date Otc 7 2014
 *
 **/

@protocol ReservationListCellDelegate <NSObject>
@optional
@end

@interface ReservationListCell : UIView

//代理
@property (weak) NSObject<ReservationListCellDelegate> *delegate;
//页面
@property (weak) BaseVc *nrVc;

//套餐名称
@property (nonatomic, strong) UILabel *ctrlPackageName;
//体检中心名称
@property (nonatomic, strong) UILabel *ctrlPeisName;
//预约状态
@property (nonatomic, strong) UILabel *ctrlStatus;

//和预约时间
@property (nonatomic, strong) UILabel *ctrlDate;

//初始化
- (id)initWithVc:(BaseLayoutVc *)vc;
//高度
+ (float)CellHeight;
//刷新
- (void)refreshWithPackageName:(NSString *)packageName peisName:(NSString *)peisName status:(NSString *)status date:(NSString *)date;



@end
