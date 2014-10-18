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



#pragma mark -
#pragma mark ----------------------------业务相关--------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
//general color
NSString * const kGeneralColor = @"#43ce50";
//host and port
#if kAppDebugTag
NSString *const kHealthHostName = @"http://114.80.79.37/peis/";
#else
NSString *const kHealthHostName = @"http://180.166.93.195:8888/";
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


