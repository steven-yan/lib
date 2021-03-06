/**
 *
 * ReservationListCell
 * @author steven.yan
 * @date Otc 7 2014
 *
 **/

#import "ReservationListCellData.h"

@protocol ReservationListCellDelegate <NSObject>
@optional
@end

@interface ReservationListCell : UIView

//代理
@property (weak) NSObject<ReservationListCellDelegate> *delegate;
//页面
@property (weak) BaseVc *nrVc;

//体检号
@property (nonatomic, strong) UILabel *ctrlPeMasterId;
//套餐名称
@property (nonatomic, strong) UILabel *ctrlPackageName;
//体检中心名称
@property (nonatomic, strong) UILabel *ctrlPeisName;
//预约状态
@property (nonatomic, strong) UILabel *ctrlStatus;
//预约时间
@property (nonatomic, strong) UILabel *ctrlDate;

//初始化
- (id)initWithVc:(BaseLayoutVc *)vc;
//高度
+ (float)CellHeight;
//刷新
- (void)refreshWithCellData:(ReservationListCellData *)d;



@end
