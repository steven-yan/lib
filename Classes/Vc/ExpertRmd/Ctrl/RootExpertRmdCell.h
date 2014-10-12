/**
 *
 *  RootExpertRmdCell
 *  @author steven
 *  @date   July 10 2014
 *
 **/

#import "RootExpertRmdCellData.h"

@protocol RootExpertRmdCellDelegate <NSObject>
@optional
@end

@interface RootExpertRmdCell : UIView

//代理
@property (weak) NSObject<RootExpertRmdCellDelegate> *delegate;
//页面
@property (weak) BaseVc *nrVc;

//图片
@property (nonatomic, strong) UIImageView *ctrlImg;
//名称
@property (nonatomic, strong) UILabel *ctrlLabelName;
//简介
@property (nonatomic, strong) UILabel *ctrlLabelDsp;

//初始化
- (id)initWithVc:(BaseVc *)vc;
//高度
+ (float)CellHeight;
//刷新
- (void)refreshWithCellData:(RootExpertRmdCellData *)data;



@end
