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

//组合名称
@property (nonatomic, strong) UILabel *ctrlGroupName;
//详情
@property (nonatomic, strong) UILabel *ctrlDetail;

//初始化
- (id)initWithVc:(BaseLayoutVc *)vc;
//高度
+ (float)CellHeight;



@end
