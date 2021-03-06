/**
 *
 *  ReservationDetailVc
 *  @author steven
 *  @date Otc 7 2014
 *
 **/
#import "ReservationDetailData.h"
#import "CSDatePicker.h"

@interface ReservationDetailVc : BaseLayoutVc <CSDatePickerDelegate>

//体检号
@property (nonatomic, strong) UILabel *ctrlPeMasterId;
//体检中心名称
@property (nonatomic, strong) UILabel *ctrlPeisName;
//地址
@property (nonatomic, strong) UILabel *ctrlAddr;
//电话
@property (nonatomic, strong) UILabel *ctrlPhone;
//套餐名称
@property (nonatomic, strong) UILabel *ctrlPackageName;
//套餐详情
@property (nonatomic, strong) UILabel *ctrlPackageDetail;
//预约时间
@property (nonatomic, strong) UILabel *ctrlDate;
//预约状态
@property (nonatomic, strong) UILabel *ctrlStatus;

//取消
@property (nonatomic, strong) UIButton *ctrlBtnCancel;
//修改日期
@property (nonatomic, strong) UIButton *ctrlBtnModifyDate;
//修改套餐
@property (nonatomic, strong) UIButton *ctrlBtnModifyPackage;
//查看报告
@property (nonatomic, strong) UIButton *ctrlBtnCheckReport;

//picker
@property (nonatomic, strong) CSDatePicker *ctrlDatePicker;

//peMasterId
@property (nonatomic, strong) NSString *peMasterId;
//status
@property (nonatomic, strong) NSString *status;
//data
@property (nonatomic, strong) ReservationDetailData *data;



@end
