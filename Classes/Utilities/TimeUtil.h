/**
 *
 *  TimeUtil
 *  @author steven.yan
 *  @date Otc 10 2014
 *
 **/

//TODO:
@interface TimeUtil : NSObject

+ (NSString *)timeWithFormat:(NSString *)format timeStamp:(NSTimeInterval)timeStamp;
+ (NSDate*)localDateFromUTC:(NSDate *)date;
+ (NSDate*)localNow;
+ (NSDate*)localDateFromTimeStamp:(NSTimeInterval)time_stamp;
+ (long)timeStampFromLocalDate:(NSDate*)date;
+ (NSString *)timeStampStrFromNow;
+ (NSString *)timeStampStrFromLocalDate:(NSDate*)date;
+ (NSDate*)dateFrom:(NSDate*)date afterMonth:(int)month withDay:(int)day andHour:(int)hour;



@end
