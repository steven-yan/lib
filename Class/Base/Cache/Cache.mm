/**
 *
 * @author  steven.yan
 * @time    2014-5-27
 *
 */

#import "Cache.h"

@implementation Cache
//static int kMaxNum = 200;



+ (instancetype)instance {
    static Cache *c = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        c = [[self alloc] init];
    });

    return c;
}

//TODO: 增加业务时抽象表创建
- (instancetype)init {
    if (self = [super init]) {
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//
//        NSString *dbDir = [paths objectAtIndex:0];
//        NSString *dbPath = [dbDir stringByAppendingPathComponent:@"cache.db"];
//        
//        //创建数据库
//        self.db = [FMDatabase databaseWithPath:dbPath];
//        if (self.db.open) {
//            //创建表
//            [self.db executeUpdate:@"create table if not exists msgtb (pid integer primary key autoincrement, user_jid text, dev_jid text, push_time_stamp text, save_time_stamp text, value text)"];
//            [self.db executeUpdate:@"create index if not exists idx_user_jid on msgtb(user_jid)"];
//            [self.db executeUpdate:@"create index if not exists dev_jid on msgtb(dev_jid)"];
//            [self.db executeUpdate:@"create index if not exists idx_push_time_stamp on msgtb(push_time_stamp)"];
//            [self.db executeUpdate:@"create index if not exists idx_save_time on msgtb(save_time)"];
//        }
    }
    
    return self;
}

- (void)dealloc{
//	//关闭数据库
//    [self.db close];
}

//存储信息
- (void)storeWithUserJid:(NSString *)user_jid devJid:(NSString *)dev_jid value:(NSString *)value pushTimeStamp:(NSString *)push_time_stamp {
//    //trim string
//    NSString *clean_user_jid = [self trimStr:user_jid];
//    NSString *clean_dev_jid = [self trimStr:dev_jid];
//    NSString *clean_value = [self trimStr:value];
//    NSString *clean_push_time_stamp = [self trimStr:push_time_stamp];
//
//    //容错
//    if ([ChkUtil isEmptyStr:clean_user_jid] || [ChkUtil isEmptyStr:clean_dev_jid] || [ChkUtil isEmptyStr:clean_value] || [ChkUtil isEmptyStr:clean_push_time_stamp]) {
//        return;
//    }
//    
//    //处理历史数据
//    int count = [self.db intForQuery:@"select count(*) from msgtb where user_jid=?", user_jid];
//    if (count >= kMaxNum) {
//        //删除一半数据
//        [self.db executeUpdate:[NSString stringWithFormat:@"delete from msgtb where pid in (select pid from msgtb limit %d)", kMaxNum / 2], user_jid];
//    }
//    
//    long now_time_stamp = [DateTimeUtil timeStampFromLocalDate:[DateTimeUtil localNow]];;
//    //插入数据
//    [self.db executeUpdate:@"insert into msgtb (user_jid, dev_jid, value, push_time_stamp, save_time_stamp) VALUES (?,?,?,?,?)", clean_user_jid, clean_dev_jid, clean_value, clean_push_time_stamp, [NSString stringWithFormat:@"%ld", now_time_stamp]];
}

- (NSArray *)readWithUserJid:(NSString *)user_jid offset:(int)offset number:(int)number {
//    //trim string
//    NSString *clean_user_jid = [self trimStr:user_jid];
//    
//    //容错
//    if ([ChkUtil isEmptyStr:clean_user_jid]) {
//        return nil;
//    }
//    
//    //查询
//    FMResultSet *rs=[self.db executeQuery:@"select dev_jid,value,push_time_stamp from msgtb where user_jid=? order by pid limit ? offset ?", user_jid, [NSString stringWithFormat:@"%d", number], [NSString stringWithFormat:@"%d", offset]];
//    NSMutableArray *arr = [[NSMutableArray alloc] init];
//    if (rs != nil) {
//        while ([rs next]) {
//            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//            
//            NSString *dev_jid = [rs stringForColumn:@"dev_jid"];
//            [dic setValue:dev_jid forKey:@"dev_jid"];
//            NSString *value = [rs stringForColumn:@"value"];
//            [dic setValue:value forKey:@"value"];
//            NSString *push_time_stamp = [rs stringForColumn:@"push_time_stamp"];
//            [dic setValue:push_time_stamp forKey:@"push_time_stamp"];
//
//            [arr addObject:dic];
//        }
//    }
//    
//    return arr;
    return nil;
}

//trim
- (NSString *)trimStr:(NSString *)str {
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}



@end
