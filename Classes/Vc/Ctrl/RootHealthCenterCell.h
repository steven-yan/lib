/**
 *
 * RootHealthCenterCell
 * @author steven.yan
 * @date Sep 21 2014
 *
 **/

#import "RootHealthCenterCellData.h"

@protocol RootHealthCenterCellDelegate <NSObject>
@optional
@end

@interface RootHealthCenterCell : UIView

//代理
@property (weak) NSObject<RootHealthCenterCellDelegate> *delegate;
//页面
@property (weak) BaseVc *nrVc;

//图片
@property (nonatomic, strong) UIImageView *ctrlImg;
//名称
@property (nonatomic, strong) UILabel *ctrlLabelName;
//地址
@property (nonatomic, strong) UILabel *ctrlLabelAddr;
//电话
@property (nonatomic, strong) UILabel *ctrlLabelPhone;

//data
@property (nonatomic, strong) RootHealthCenterCellData *data;

//初始化
- (id)initWithVc:(BaseVc *)vc;

//高度
+ (float)CellHeight;
//刷新
- (void)refreshWithCellData:(RootHealthCenterCellData *)data;


@end
