//
//  IDValidate.m
//  SmartCollar
//
//  Created by foolbear on 14-4-10.
//
//

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



@end
