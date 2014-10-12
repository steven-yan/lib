/**
 *
 *  ChkUtil
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/
#import "ChkUtil.h"

@implementation ChkUtil

//是否是空字符串
+ (BOOL)isEmptyStr:(NSString *)str {
    if (str == nil || [str isEqualToString:@""]) {
        return YES;
    }
    
    return NO;
}

//是否是整型
+ (BOOL)isIntStr:(NSString *)str {
    if ([ChkUtil isEmptyStr:str]==NO) {
        NSScanner* scan = [NSScanner scannerWithString:str]; 
        int val; 
        return[scan scanInt:&val] && [scan isAtEnd];        
    }
    return NO;
}

//是否是double型
+ (BOOL)isDoubleStr:(NSString *)str {
    if ([ChkUtil isEmptyStr:str]==NO) {
        NSScanner* scan = [NSScanner scannerWithString:str]; 
        double val; 
        return[scan scanDouble:&val] && [scan isAtEnd];        
    }
    return NO;
}

+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (NSString *)handleNil:(NSString *)str {
    if (str == nil) {
        str = kEmptyStr;
    }
    
    return str;
}



@end
