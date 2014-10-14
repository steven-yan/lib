/**
 *
 * BaseHttpVc
 * @author steven.yan
 * @date Otc 8 2014
 *
 **/
#import "BaseHttpVc.h"

@implementation BaseHttpVc



#pragma mark -
#pragma mark ------------------------------页面----------------------------------
/*------------------------------------------------------------------------------
|  页面
|
 ------------------------------------------------------------------------------*/
//创建--
- (void)_onCreateBegin {
    [super _onCreateBegin];
    
    //参数
    self.queryParams = [[NSMutableDictionary alloc] init];
    //页面隐藏是否取消请求
    self.closeHttpReqOnHideTag = YES;
}

- (void)onClose {
    if (self.closeHttpReqOnHideTag) {
        if (self.httpGetReq) {
            [self.httpGetReq clearDelegatesAndCancel];
            self.httpGetReq = nil;
        }
        if (self.httpPostReq) {
            [self.httpPostReq clearDelegatesAndCancel];
            self.httpPostReq = nil;
        }
    }
    [super onClose];
}



#pragma mark -
#pragma mark ------------------------------http----------------------------------
/*-------------------------------------------------------------------------------
|  http
|
 -------------------------------------------------------------------------------*/
- (void)httpGet:(NSString *)url {
    [self httpGet:url tag:-1];
}
- (void)httpGet:(NSString *)url tag:(NSInteger)tag {
    [self httpGet:url params:[self makeQueryParamsWithTag:tag] tag:tag];
}
- (void)httpGet:(NSString *)url params:(NSDictionary *)params tag:(NSInteger)tag {
    [self httpGet:url params:params postData:nil timeOut:10 tag:tag];
}
- (void)httpGet:(NSString *)url  timeOut:(NSTimeInterval)timeOut tag:(NSInteger)tag {
    [self httpGet:url params:[self makeQueryParamsWithTag:tag] postData:nil timeOut:timeOut tag:tag];
}
- (void)httpGet:(NSString *)url params:(NSDictionary *)params postData:(NSData *)postData timeOut:(NSTimeInterval)timeOut tag:(NSInteger)tag {
    //请求
    self.httpGetReq = [HttpUtil httpGet:url
                                 params:params
                               postData:postData
                                timeOut:timeOut
                      didFinishSelector:@selector(requestFinished:)
                          didFaillector:@selector(requestFailed:)
                               delegate:self
                                    tag:tag];
}

//请求成功
- (void)requestFinished:(ASIHTTPRequest *)req {
    [self onHttpRequestSuccess:req.responseString];
    [self onHttpRequestSuccess:req.responseString tag:req.tag];
}
- (void)onHttpRequestSuccess:(NSString *)response {
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    if (dic) {
        NSString *err = [dic valueForKey:@"error"];
        if ([ChkUtil isEmptyStr:err] == NO) {
            [self onHttpRequestFailed:EnHttpResponseErrorHintTag hint:err];
        } else {
            [self onHttpRequestSuccessObj:dic];
        }
    } else {
        [self onHttpRequestFailed:EnHttpResponseContentErrorTag hint:@"返回格式错误"];
    }
}
- (void)onHttpRequestSuccess:(NSString *)response tag:(NSInteger)tag {
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    if (dic) {
        NSString *err = [dic valueForKey:@"error"];
        if ([ChkUtil isEmptyStr:err] == NO) {
            [self onHttpRequestFailed:EnHttpResponseErrorHintTag hint:err tag:tag];
        } else {
            [self onHttpRequestSuccessObj:dic tag:tag];
        }
    } else {
        [self onHttpRequestFailed:EnHttpResponseContentErrorTag hint:@"返回格式错误" tag:tag];
    }
}

//请求失败
- (void)requestFailed:(ASIHTTPRequest *)req {
    NSInteger code = [[req error] code];
    if (code == 1) {
        [self onHttpRequestFailed:EnHttpConnectErrorTag hint:@"请求失败,请检查网络"];
        [self onHttpRequestFailed:EnHttpConnectErrorTag hint:@"请求失败,请检查网络" tag:req.tag];
    } else if (code == 2) {
        [self onHttpRequestFailed:EnHttpConnectErrorTag hint:@"请求超时"];
        [self onHttpRequestFailed:EnHttpConnectErrorTag hint:@"请求超时" tag:req.tag];
    }
}

//设置参数-----
- (NSDictionary *)makeQueryParams {
    return [self makeQueryParamsWithTag:-1];
}
- (NSDictionary *)makeQueryParamsWithTag:(NSInteger)tag{
    //清空参数
    [self.queryParams removeAllObjects];
    //完善参数
    [self completeQueryParams];
    [self completeQueryParams:tag];
    return self.queryParams;
}
- (void)completeQueryParams {
}
- (void)completeQueryParams:(NSInteger)tag {
}

//覆盖方法------
//请求成功--
- (void)onHttpRequestSuccessObj:(NSDictionary *)obj {
}
- (void)onHttpRequestSuccessObj:(NSDictionary *)obj tag:(NSInteger)tag {
}
//请求失败--
- (void)onHttpRequestFailed:(EnHttpRequestFailed)err hint:(NSString *)hint {
}
- (void)onHttpRequestFailed:(EnHttpRequestFailed)err hint:(NSString *)hint tag:(NSInteger)tag{
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
