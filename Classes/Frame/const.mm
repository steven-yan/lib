/**
 *
 *  const
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#pragma mark -
#pragma mark -----------------------------通用-----------------------------------
/*------------------------------------------------------------------------------
 |  通用
 |
 -----------------------------------------------------------------------------*/
//debug状态
#define kAppDebugTag 1

//空字符串
NSString * const kEmptyStr = @"";
//app 信息地址
NSString * const kAppInfoUrl = @"http://itunes.apple.com/lookup?id=";
//app 评价地址
NSString * const kAppRateUrl = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", kAppId];
//appstore下载url
NSString * const kAppDetailUrl = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/ding-can-xiao-mi-shu/id%@?mt=8&uo=4", kAppId];



#pragma mark -
#pragma mark ----------------------------业务相关--------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
//general color
NSString * const kGeneralColor = @"#43ce50";
//app version
NSString * const kAppVersion = @"1.0";
//app id
NSString * const kAppId = @"776882837";
//host and port
#if kAppDebugTag
NSString * const kAppHost = @"http://114.80.79.37/peis/";
#else
NSString * const kAppHost = @"http://180.166.93.195:8888/";
#endif



#pragma mark -
#pragma mark -----------------------------Cache---------------------------------
/*------------------------------------------------------------------------------
 |  Cache
 |
 -----------------------------------------------------------------------------*/
//dir------
NSString * const kGlobalDir = @"kDirConst";
//key------
//用户信息
NSString * const kGlobalKeyUser = @"kGlobalKeyUser";


