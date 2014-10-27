/**
 *
 * BaseHttpView
 * @author steven.yan
 * @date Otc 10 2014
 *
 **/

@interface BaseHttpView : BaseView

//get 请求
@property (nonatomic, strong) ASIHTTPRequest *httpGetReq;
//post 请求
@property (nonatomic, strong) ASIFormDataRequest *httpPostReq;

//请求参数
@property (nonatomic, strong) NSMutableDictionary *queryParams;

//get ------
- (void)httpGet:(NSString *)url;
- (void)httpGet:(NSString *)url tag:(NSInteger)tag;
- (void)httpGet:(NSString *)url params:(NSDictionary *)params tag:(NSInteger)tag;
- (void)httpGet:(NSString *)url timeOut:(NSTimeInterval)timeOut tag:(NSInteger)tag;
//success
- (void)onHttpRequestSuccess:(NSString *)response;
- (void)onHttpRequestSuccess:(NSString *)response tag:(NSInteger)tag;
//fail
- (void)onHttpRequestFailed:(EnHttpRequestFailed)err hint:(NSString *)hint;
- (void)onHttpRequestFailed:(EnHttpRequestFailed)err hint:(NSString *)hint tag:(NSInteger)tag;

//init
- (id)init;
- (id)initWithFrame:(CGRect)rect;
//关闭
- (void)onClose;



@end
