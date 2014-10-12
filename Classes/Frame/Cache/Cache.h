/**
 *
 * @author  steven.yan
 * @time    2014-5-27
 *
 */

#import "FMDB.h"
#import "ChkUtil.h"

@interface Cache : NSObject

//db
@property (nonatomic, strong) FMDatabase *db;

+ (instancetype)instance;

//generaltb
- (void)storeWithDir:(NSString *)cdir key:(NSString *)ckey dic:(NSDictionary *)dic;
- (void)storeWithDir:(NSString *)cdir key:(NSString *)ckey list:(NSArray *)list;
- (void)storeWithDir:(NSString *)cdir key:(NSString *)ckey value:(NSString *)cvalue;
- (void)storeWithDir:(NSString *)cdir key:(NSString *)ckey value:(NSString *)cvalue forceTag:(BOOL)fTag;
- (NSDictionary *)readDicWithDir:(NSString *)cdir key:(NSString *)ckey;
- (NSArray *)readListWithDir:(NSString *)cdir key:(NSString *)ckey;
- (NSString *)readWithDir:(NSString *)cdir key:(NSString *)ckey;
- (BOOL)removeWithDir:(NSString *)cdir key:(NSString *)ckey;



@end
