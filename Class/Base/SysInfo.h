/**
 *
 * @author steven.yan
 *
 **/


@interface SysInfo : NSObject

//------默认尺寸------
//bounds
@property CGRect bounds;
//顶部面板
@property float topPanelHeight;
//内容面板
@property float contentHeight;
//底部面板
@property float bottomPanelHeight;

//------设备信息------
//iPhone5或iPhone5s
@property BOOL isIphone5Tag;
//iPhone4或iPhone4s
@property BOOL isIphone4Tag;

//------系统信息------
//系统版本
@property float iosVersion;
//ios7
@property BOOL isIos7Tag;


+ (instancetype)instance;



@end
