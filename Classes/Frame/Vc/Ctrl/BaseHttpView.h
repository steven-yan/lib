/**
 *
 * BaseHttpView
 * @author steven.yan
 * @date Otc 10 2014
 *
 **/

@interface BaseHttpView : UIView

//get 请求
@property (nonatomic, strong) ASIHTTPRequest *httpGetReq;
//post 请求
@property (nonatomic, strong) ASIFormDataRequest *httpPostReq;

//get请求参数
@property (nonatomic, strong) NSMutableDictionary *getQueryParams;
//post请求参数
@property (nonatomic, strong) NSMutableDictionary *postQueryParams;

//页面隐藏是否取消请求
@property (nonatomic) BOOL closeHttpReqOnHideTag;

//get ------
- (void)httpGet:(NSString *)url;
- (void)httpGet:(NSString *)url tag:(NSInteger)tag;
- (void)httpGet:(NSString *)url params:(NSDictionary *)params tag:(NSInteger)tag;
- (void)httpGet:(NSString *)url timeOut:(NSTimeInterval)timeOut tag:(NSInteger)tag;
//success
- (void)onHttpRequestSuccess:(NSString *)response;
- (void)onHttpRequestSuccess:(NSString *)response tag:(NSInteger)tag;
//fail
- (void)onHttpRequestFailed:(EnHttpRequestFailed)err;
- (void)onHttpRequestFailed:(EnHttpRequestFailed)err tag:(NSInteger)tag;


- (UIView *)initWithFrame:(CGRect)rect;



@end
