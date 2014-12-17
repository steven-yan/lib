/**
 *
 *  JsonUtil
 *  @author steven
 *  @date Nov 29 2014
 *
 **/

@interface JsonUtil : NSObject

+ (id)transObjFromStr:(NSString *)str;
+ (id)transObjFromStr:(NSString *)str encoding:(NSStringEncoding)encoding;
+ (id)transObjFromData:(NSData *)data;



@end
