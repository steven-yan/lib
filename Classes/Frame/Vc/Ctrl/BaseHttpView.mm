/**
 *
 * BaseHttpView
 * @author steven.yan
 * @date Otc 10 2014
 *
 **/

#import "BaseHttpView.h"

@implementation BaseHttpView



#pragma mark -
#pragma mark ------------------------------页面----------------------------------
/*------------------------------------------------------------------------------
|  页面
|
 ------------------------------------------------------------------------------*/
//创建--
- (UIView *)initWithFrame:(CGRect)rect {
    BaseHttpView *v  =[super initWithFrame:rect];
    
    //请求参数
    self.getQueryParams = [[NSMutableDictionary alloc] init];
    self.postQueryParams = [[NSMutableDictionary alloc] init];
    //页面隐藏是否取消请求
    self.closeHttpReqOnHideTag = YES;
    
    return v;
}

//隐藏
- (void)_onDidHide {
//    if (self.closeHttpReqOnHideTag) {
//        if (self.httpGetReq) {
//            [self.httpGetReq clearDelegatesAndCancel];
//            self.httpGetReq = nil;
//        }
//        if (self.httpPostReq) {
//            [self.httpPostReq clearDelegatesAndCancel];
//            self.httpPostReq = nil;
//        }
//    }
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
    [self httpGet:url params:[self makeQueryParams] tag:tag];
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

//请求失败
- (void)requestFailed:(ASIHTTPRequest *)req {
    //TODO:
    NSInteger code = [[req error] code];
    if (code == 1) {
        
    }
}

//设置参数-----
- (NSDictionary *)makeQueryParams {
    return [self makeQueryParamsWithTag:-1];
}
- (NSDictionary *)makeQueryParamsWithTag:(NSInteger)tag{
    //清空参数
    [self.getQueryParams removeAllObjects];
    //完善参数
    [self completeQueryParams];
    [self completeQueryParams:tag];
    return self.getQueryParams;
}
- (void)completeQueryParams {
}
- (void)completeQueryParams:(NSInteger)tag {
}


//success
- (void)onHttpRequestSuccess:(NSString *)response {
}
- (void)onHttpRequestSuccess:(NSString *)response tag:(NSInteger)tag {
}
//fail
- (void)onHttpRequestFailed:(EnHttpRequestFailed)err {
}
- (void)onHttpRequestFailed:(EnHttpRequestFailed)err tag:(NSInteger)tag {
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
