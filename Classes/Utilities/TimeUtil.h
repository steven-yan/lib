/**
 *
 *  TimeUtil
 *  @author steven.yan
 *  @date Otc 10 2014
 *
 **/

@interface TimeUtil : NSObject

+ (NSString *)timeStamp;
+ (NSString *)timeWithFormat:(NSString *)format date:(NSDate *)date;
+ (NSDate*)localDateFromTimeStamp:(NSTimeInterval)time_stamp;



@end
