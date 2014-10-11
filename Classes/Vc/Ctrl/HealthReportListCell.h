/**
 *
 * HealthReportListCell
 * @author steven.yan
 * @date Sep 28 2014
 *
 **/

@protocol HealthReportListCellDelegate <NSObject>
@optional
@end

@interface HealthReportListCell : UIView

//代理
@property (weak) NSObject<HealthReportListCellDelegate> *delegate;
//页面
@property (weak) BaseVc *nrVc;

//名称
@property (nonatomic, strong) UILabel *ctrlName;
//日期
@property (nonatomic, strong) UILabel *ctrlDate;

//初始化
- (id)initWithVc:(BaseLayoutVc *)vc;
//高度
+ (float)CellHeight;
//刷新
- (void)refreshWith:(NSString *)name date:(NSString *)date;


@end
