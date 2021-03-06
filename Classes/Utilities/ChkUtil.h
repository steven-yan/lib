/**
 *
 *  RootHealthCenterCellData
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

@interface ChkUtil : NSObject

+ (BOOL)isEmptyStr:(NSString *)str;
+ (BOOL)isIntStr:(NSString *)str;
+ (BOOL)isDoubleStr:(NSString *)str;
+ (BOOL)isValidEmail:(NSString *)email;
+ (BOOL)isValidPhoneNum:(NSString *)phoneNum;

+ (NSString *)handleNil:(NSString *)str;


@end
