/**
 *
 *  TimeUtil.h
 *  @author steven.yan
 *  @date Otc 10 2014
 *
 **/

#import "TimeUtil.h"

@implementation TimeUtil

+ (NSDate*)localNow {
	return [NSDate date];
}

+ (NSString *)timeWithFormat:(NSString *)format timeStamp:(NSTimeInterval)timeStamp {
    NSDate *date = [TimeUtil localDateFromTimeStamp:timeStamp];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    
    return [dateFormat stringFromDate:date];
}

+ (NSString *)timeStampStrFromNow {
    return [TimeUtil timeStampStrFromLocalDate:[TimeUtil localNow]];
}

+ (NSString *)timeStampStrFromLocalDate:(NSDate*)date {
    return [NSString stringWithFormat:@"%ld", [TimeUtil timeStampFromLocalDate:date]];
}

+ (NSDate*)localDateFromTimeStamp:(NSTimeInterval)time_stamp {
	return [NSDate dateWithTimeIntervalSince1970:time_stamp];
}

+ (long)timeStampFromLocalDate:(NSDate*)date {
    return [date timeIntervalSince1970];
}



+ (NSDate*)dateFrom:(NSDate*)date afterMonth:(int)month withDay:(int)day andHour:(int)hour {
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setMonth:month];
	[comps setDay:day];
	[comps setHour:hour];
	NSCalendar* calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	return [calender dateByAddingComponents:comps toDate:date options:0];
}

+ (NSDate*)localDateFromUTC:(NSDate *)date {
    NSInteger interval = [[NSTimeZone localTimeZone] secondsFromGMTForDate:date];
    NSDate* dest_date = [NSDate dateWithTimeInterval:interval sinceDate:date];
    return dest_date;
}



@end
