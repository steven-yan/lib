/**
 *
 *  HttpUtil
 *  @author steven.yan
 *  @date Otc 10 2014
 *
 **/

#import "HttpUtil.h"

@implementation HttpUtil

+ (ASIHTTPRequest *)httpGet:(NSString *)url
                     params:(NSDictionary *)params
                   postData:(NSData *)data
                    timeOut:(NSTimeInterval)sec
          didFinishSelector:(SEL)didFinishSelector
              didFaillector:(SEL)didFailSelector
                   delegate:(id)delegate
                        tag:(NSInteger)tag {
    //获取完整url
    NSString *relUrl = [self compelteQueryString:url params:params];
    //req
    ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:relUrl]];
    req.delegate = delegate;
    req.tag = tag;
    //超时设置
    if (sec <= 5) {
        sec = 5;
    }
    req.timeOutSeconds = sec;
    //User-Agent
    [req addRequestHeader:@"User-Agent" value:[NSString stringWithFormat:@"Apple iOS"]];
    //设置data
    if (data) {
        [req appendPostData:data];
    }
    //TODO:
//    [req setShouldAttemptPersistentConnection:NO];
    //设置选择器
    if (didFinishSelector) {
        req.didFinishSelector = didFinishSelector;
    }
    if (didFailSelector) {
        req.didFailSelector = didFailSelector;
    }
    //开始异步请求
    [req startAsynchronous];
    
    return req;
}

+ (NSString *)compelteQueryString:(NSString *)url params:(NSDictionary *)params {
    NSString *result = kEmptyStr;
    //拼接参数
    if (params) {
        BOOL tag = NO;
        ASIFormDataRequest *fromDataRequest = [ASIFormDataRequest requestWithURL:nil];
        for (id key in params) {
            NSString *value = [params valueForKey:key];
            value = [fromDataRequest encodeURL:value];
            result = [result stringByAppendingFormat:@"%@=%@&", key, value];
            tag = YES;
        }
        if (tag) {
            result = [result substringToIndex:result.length - 1];
        }
    }
    
    //拼接url
    NSString *re = [StringUtil trimStr:url];
    if ([ChkUtil isEmptyStr:result] == NO) {
        NSRange range = [re rangeOfString:@"?"];
        if (range.length > 0 && range.location > 0) {
            re = [re stringByAppendingFormat:@"&%@", result];
        } else {
            re = [re stringByAppendingFormat:@"?%@", result];
        }
    }
    
    return re;
}



@end
