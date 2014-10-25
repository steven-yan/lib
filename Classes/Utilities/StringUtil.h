/**
 *
 *  HanZiUtil
 *  @author steven
 *  @date August 14 2014
 *
 **/

@interface StringUtil:NSObject
//trim
+ (NSString *)trimStr:(NSString *)str;
//
+ (NSString *)intToStr:(int)i;
+ (NSString *)boolToStr:(BOOL)b;
+ (NSString *)floatToStr:(float)i;
+ (NSString *)doubleToStr:(double)i;
+ (NSString *)filterHtml:(NSString *)html;



@end
