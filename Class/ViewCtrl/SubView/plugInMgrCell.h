/**
 *
 *  plugInMgrCell
 *  @author steven
 *  @date   July 2 2014
 *
 **/

#import "BaseVC.h"
#import "ASIHTTPRequest.h"

@protocol plugInMgrCellDelegate <NSObject>
@optional
@end

typedef enum {
    STATE_NONE,
    STATE_NO_VER,       //没有插件
    STATE_DOWNLOADING,  //下载中
    STATE_DOWNLOADED,   //下载完成
    STATE_DELETE,       //显示删除
    STATE_UPDATE,       //显示更新
} State_T;

@interface plugInMgrCell : UIView

//代理
@property (weak) NSObject<plugInMgrCellDelegate> *delegate;
//页面
@property (weak) BaseVC *nrVc;

//背景
@property (nonatomic, strong) UIView *ctrlBg;
//插件图片
@property (nonatomic, strong) UIImageView *ctrlImg;
//插件名称
@property (nonatomic, strong) UILabel *ctrlLabelName;
//版本号
@property (nonatomic, strong) UILabel *ctrlLabelVerHint;
@property (nonatomic, strong) UILabel *ctrlLabelVer;
//按钮
@property (nonatomic, strong) UIButton *ctrlBtn;
//进度条
@property (nonatomic, strong) UIProgressView *ctrlPv;

//插件名称
@property (nonatomic, strong) NSString *plugInName;
//最新版本
@property (nonatomic, strong) NSString *latestVer;
//下载地址
@property (nonatomic, strong) NSString *latestVerUrl;

//下载状态
@property State_T downloadState;



//初始化
- (id)initWithVc:(BaseVC *)vc;

//高度
+ (float)CellHeight;
//刷新
- (void)refreshCellWith:(UIImage *)img
                   name:(NSString *)name
                version:(NSString *)ver
              pluginUrl:(NSString *)pluginUrl;



@end
