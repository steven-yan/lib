/**
 *
 *  JsonUtil
 *  @author steven
 *  @date Nov 29 2014
 *
 **/

#import "JsonUtil.h"

@implementation JsonUtil

//json to obj------
+ (id)transObjFromStr:(NSString *)str {
    return [self transObjFromStr:str encoding:NSUTF8StringEncoding];
}

+ (id)transObjFromStr:(NSString *)str encoding:(NSStringEncoding)encoding {
    return [self transObjFromData:[str dataUsingEncoding:encoding]];
}

+ (id)transObjFromData:(NSData *)data {
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONWritingPrettyPrinted error:nil];
}

//fill obj
+ (id)fillObjWithClass:(id)obj str:(NSString *)str {
    /*
    object_setInstanceVariable
    class_getProperty
    class_copyPropertyList*/
    return nil;
}


@end
