/**
 *
 * HealthReportListCell
 * @author steven.yan
 * @date Sep 28 2014
 *
 **/

#import "HealthReportListCellData.h"

@protocol HealthReportListCellDelegate <NSObject>
@optional
@end

@interface HealthReportListCell : UIView

//代理
@property (weak) NSObject<HealthReportListCellDelegate> *delegate;
//页面
@property (weak) BaseVc *nrVc;

//用户名
@property (nonatomic, strong) UILabel *ctrlName;
//体检号
@property (nonatomic, strong) UILabel *ctrlPeMasterId;
//体检中心名称
@property (nonatomic, strong) UILabel *ctrlPeisName;
//预约时间
@property (nonatomic, strong) UILabel *ctrlDate;

//初始化
- (id)initWithVc:(BaseLayoutVc *)vc;
//高度
+ (float)CellHeight;
//刷新
- (void)refreshWithCellData:(HealthReportListCellData *)d;



@end
