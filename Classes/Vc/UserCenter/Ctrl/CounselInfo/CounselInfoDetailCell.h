/**
 *
 * CounselInfoDetailCell
 * @author steven.yan
 * @date Oct 19 2014
 *
 **/

@protocol CounselInfoDetailCellDelegate <NSObject>
@optional
@end

@interface CounselInfoDetailCell : UIView

//代理
@property (weak) NSObject<CounselInfoDetailCellDelegate> *delegate;
//页面
@property (weak) BaseVc *nrVc;



@end
