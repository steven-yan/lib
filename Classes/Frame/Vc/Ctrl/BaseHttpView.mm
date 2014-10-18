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
- (void)_onCreateBegain {
    [super _onCreateBegain];
    
    //加载提示
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.ctrlIndicator = indicator;
    //失败提示
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    [btn addTarget:self action:@selector(btnClicked:)];
    [btn setTitle:@"加载失败,点击重新加载"];
    btn.hidden = YES;
    [self.content addSubview:btn];
    self.ctrlFailedHint = btn;
    
    //请求参数
    self.getQueryParams = [[NSMutableDictionary alloc] init];
    self.postQueryParams = [[NSMutableDictionary alloc] init];
}

//隐藏
- (void)_onClose {
    if (self.httpGetReq) {
        [self.httpGetReq clearDelegatesAndCancel];
        self.httpGetReq = nil;
    }
    if (self.httpPostReq) {
        [self.httpPostReq clearDelegatesAndCancel];
        self.httpPostReq = nil;
    }
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
    [self httpGet:url params:params postData:nil timeOut:5 tag:tag];
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
    if (code == ASIConnectionFailureErrorType) {
        
    } else if (code == ASIRequestTimedOutErrorType) {
        
    } else {
        
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
#pragma mark ------------------------------alert----------------------------------
/*------------------------------------------------------------------------------
 |  alert
 |
 -----------------------------------------------------------------------------*/
- (void)alert:(NSString *)msg {
    [self alert:msg tag:0];
}
- (void)alert:(NSString *)msg tag:(NSInteger)tag {
    [self alertWithTitle:@"提示" msg:msg tag:tag];
}
- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg {
    [self alertWithTitle:title msg:msg tag:0];
}
- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg tag:(NSInteger)tag {
    [self alertWithTitle:title cancel:@"取消" msg:msg tag:tag];
}
- (void)alertWithTitle:(NSString *)title cancel:(NSString *)cancel msg:(NSString *)msg tag:(NSInteger)tag {
    [self alertWithTitle:title cancel:cancel msg:msg cmfTitle:@"确认" tag:tag];
}
- (void)alertWithTitle:(NSString *)title cancel:(NSString *)cancel msg:(NSString *)msg cmfTitle:(NSString *)cmfTitle tag:(NSInteger)tag {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancel otherButtonTitles:cmfTitle, nil];
    alert.tag = tag;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self alertView:alertView dismissWithBtnIndex:buttonIndex tag:alertView.tag];
    [self alertView:alertView dismissWithBtnIndex:buttonIndex];
    if (buttonIndex == 1) {
        [self confirmAlert:alertView tag:alertView.tag];
        [self confirmAlert:alertView];
    }
}

- (void)alertView:(UIAlertView *)alertView dismissWithBtnIndex:(NSInteger)index tag:(NSInteger)tag {
}
- (void)alertView:(UIAlertView *)alertView dismissWithBtnIndex:(NSInteger)index {
}
- (void)confirmAlert:(UIAlertView *)alertView tag:(NSInteger)tag {
}
- (void)confirmAlert:(UIAlertView *)alertView {
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)btnClicked:(UIButton *)btn {
    
}



@end
