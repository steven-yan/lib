/**
 *
 * @author  steven.yan
 * @create date 2014-5-27
 *
 */

#import "Cache.h"

@implementation Cache



+ (instancetype)instance {
    static Cache *c = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        c = [[self alloc] init];
    });
    
    return c;
}

- (instancetype)init {
    if (self = [super init]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

        NSString *dbDir = [paths objectAtIndex:0];
        NSString *dbPath = [dbDir stringByAppendingPathComponent:@"cache.db"];
        
        //创建数据库
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            if (db.open) {
                //创建通用数据表(保存简单数据)
                [db executeUpdate:@"create table if not exists generaltb (generalid integer primary key autoincrement, cdir text, ckey text, csavetime text, cvalue text)"];
                [db executeUpdate:@"create index if not exists idx_cdir on generaltb(cdir)"];
                [db executeUpdate:@"create index if not exists idx_kdir on generaltb(ckey)"];
                [db executeUpdate:@"create index if not exists idx_save_time on generaltb(csavetime)"];
            }
        }];
    }
    
    return self;
}

- (void)dealloc {
	//关闭数据库
    [self.dbQueue close];
}



#pragma mark -
#pragma mark -----------------------------generaltb---------------------------------
/*----------------------------------------------------------------------------------
 |  generaltb
 |
 ---------------------------------------------------------------------------------*/
- (void)storeWithDir:(NSString *)cdir key:(NSString *)ckey dic:(NSDictionary *)dic {
    [self storeWithDir:cdir key:ckey obj:dic];
}

- (void)storeWithDir:(NSString *)cdir key:(NSString *)ckey list:(NSArray *)list {
    [self storeWithDir:cdir key:ckey obj:list];
}

- (void)storeWithDir:(NSString *)cdir key:(NSString *)ckey obj:(id)obj {
    NSString *value = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    [self storeWithDir:cdir key:ckey value:value];
}

- (void)storeWithDir:(NSString *)cdir key:(NSString *)ckey value:(NSString *)cvalue {
    [self storeWithDir:cdir key:ckey value:cvalue forceTag:YES];
}

- (void)storeWithDir:(NSString *)cdir key:(NSString *)ckey value:(NSString *)cvalue forceTag:(BOOL)forceTag {
    //trim string
    NSString *cleanDir = [StringUtil trimStr:cdir];
    NSString *cleanKey = [StringUtil trimStr:ckey];
    NSString *cleanValue = [StringUtil trimStr:cvalue];
    
    //容错
    if ([ChkUtil isEmptyStr:cleanDir] || [ChkUtil isEmptyStr:cleanKey] || [ChkUtil isEmptyStr:cleanValue]) {
        return;
    }
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        int i = [db intForQuery:@"select count(*) from generaltb where cdir=? and ckey=?",cleanDir,cleanKey];
        if (i>0) {
            if (forceTag) {         //更新
                [db executeUpdate:@"delete from generaltb where cdir=? and ckey=?",cleanDir,cleanKey];
            } else {            //不需更新
                return;
            }
        }
        
        [db executeUpdate:@"insert into generaltb(cdir, ckey, cvalue, csavetime) VALUES(?,?,?,?)", cleanDir, cleanKey, cleanValue, [TimeUtil timeStamp]];
    }];
}

- (NSDictionary *)readDicWithDir:(NSString *)cdir key:(NSString *)ckey {
    return [self readObjWithDir:cdir key:ckey];
}

- (NSArray *)readListWithDir:(NSString *)cdir key:(NSString *)ckey {
    return [self readObjWithDir:cdir key:ckey];
}

- (id)readObjWithDir:(NSString *)cdir key:(NSString *)ckey {
    NSString *value = [self readWithDir:cdir key:ckey];
    if ([ChkUtil isEmptyStr:value] == NO) {
        return [NSJSONSerialization JSONObjectWithData:[value dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    }
    
    return nil;
}

- (NSString *)readWithDir:(NSString *)cdir key:(NSString *)ckey {
    //trim string
    NSString *cleanDir = [StringUtil trimStr:cdir];
    NSString *cleanKey = [StringUtil trimStr:ckey];
    
    //容错
    if ([ChkUtil isEmptyStr:cleanDir] || [ChkUtil isEmptyStr:cleanKey]) {
        return nil;
    }
    
    __block NSString *result = nil;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select cvalue from generaltb where cdir=? and ckey=?", cleanDir, cleanKey];
        if (rs != nil) {
            while ([rs next]) {
                result = [rs stringForColumn:@"cvalue"];
                break;
            }
        }
        [rs close];
    }];
    
    return result;
}

- (BOOL)removeWithDir:(NSString *)cdir key:(NSString *)ckey {
    //trim string
    NSString *cleanDir = [StringUtil trimStr:cdir];
    NSString *cleanKey = [StringUtil trimStr:ckey];
    
    //容错
    if ([ChkUtil isEmptyStr:cleanDir] || [ChkUtil isEmptyStr:cleanKey]) {
        return NO;
    }
    
    __block BOOL r;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        r = [db executeUpdate:@"delete from generaltb where cdir=? and ckey=?", cleanDir, cleanKey];
    }];
    
    return r;
}



@end
