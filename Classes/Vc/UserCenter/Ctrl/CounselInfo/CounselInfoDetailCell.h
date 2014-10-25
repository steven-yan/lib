/**
 *
 * CounselInfoDetailCell
 * @author steven.yan
 * @date Oct 19 2014
 *
 **/

#import "CounselInfoDetailCellData.h"

@protocol CounselInfoDetailCellDelegate <NSObject>
@optional
@end

@interface CounselInfoDetailCell : UIView

//代理
@property (weak) NSObject<CounselInfoDetailCellDelegate> *delegate;
//页面
@property (weak) BaseVc *nrVc;

//iv
@property (nonatomic, strong) UIImageView *ctrlIvUser;
//name
@property (nonatomic, strong) UILabel *ctrlName;
//bg
@property (nonatomic, strong) UIImageView *ctrlContentBg;
//content
@property (nonatomic, strong) UILabel *ctrlContent;
//time
@property (nonatomic, strong) UILabel *ctrlTime;
//line
@property (nonatomic, strong) UIView *ctrlLine;

//init
- (id)initWithVc:(BaseLayoutVc *)vc;
//cellHeight
+ (float)CellHeight:(CounselInfoDetailCellData *)d;
//刷新
- (void)refreshWithCellData:(CounselInfoDetailCellData *)d;



@end
