/**
 *
 *  StringUtil
 *  @author steven
 *  @date August 14 2014
 *
 **/

#import "StringUtil.h"

@implementation StringUtil

//trim
+ (NSString *)trimStr:(NSString *)astr {
    if (astr==nil) {
        return @"";
    } else {
        return  [astr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
}

//整型转换成字符串
+ (NSString *)intToStr:(int)i {
    return [NSString stringWithFormat:@"%d",i];
}

+ (NSString *)boolToStr:(BOOL)b {
    if (b) {
        return @"YES";
    } else {
        return @"NO";
    }
}

+ (NSString *)floatToStr:(float)i {
    return [NSString stringWithFormat:@"%f",i];
}

+ (NSString *)doubleToStr:(double)i {
    return [NSString stringWithFormat:@"%f",i];
}

+ (NSString *)filterHtml:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}



@end