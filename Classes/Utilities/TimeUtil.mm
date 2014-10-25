/**
 *
 *  TimeUtil.h
 *  @author steven.yan
 *  @date Otc 10 2014
 *
 **/

#import "TimeUtil.h"

@implementation TimeUtil

+ (NSString *)timeStamp {
    return [TimeUtil timeStampDate:[NSDate date]];
}

+ (NSString *)timeStampDate:(NSDate*)date {
    return [NSString stringWithFormat:@"%f", [date timeIntervalSince1970]];
}

+ (NSDate*)localDateFromTimeStamp:(NSTimeInterval)timeStamp {
	return [NSDate dateWithTimeIntervalSince1970:timeStamp];
}

+ (NSString *)timeWithFormat:(NSString *)format date:(NSDate *)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    
    return [dateFormat stringFromDate:date];
}

+ (NSDate*)dateFrom:(NSDate*)date afterMonth:(int)month withDay:(int)day andHour:(int)hour {
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setMonth:month];
	[comps setDay:day];
	[comps setHour:hour];
	NSCalendar* calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	return [calender dateByAddingComponents:comps toDate:date options:0];
}



@end
