/**
 *
 * BaseHttpView
 * @author steven.yan
 * @date Otc 10 2014
 *
 **/

@interface BaseHttpView : BaseView

//加载提示
@property (nonatomic, strong) UIActivityIndicatorView *ctrlIndicator;
//失败提示
@property (nonatomic, strong) UIButton *ctrlFailedHint;

//get 请求
@property (nonatomic, strong) ASIHTTPRequest *httpGetReq;
//post 请求
@property (nonatomic, strong) ASIFormDataRequest *httpPostReq;

//get请求参数
@property (nonatomic, strong) NSMutableDictionary *getQueryParams;
//post请求参数
@property (nonatomic, strong) NSMutableDictionary *postQueryParams;

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

//alert--------
- (void)alert:(NSString *)msg;
- (void)alert:(NSString *)msg tag:(NSInteger)tag;
- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg;
- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg tag:(NSInteger)tag;
- (void)alertWithTitle:(NSString *)title cancel:(NSString *)cancel msg:(NSString *)msg tag:(NSInteger)tag;
- (void)alertWithTitle:(NSString *)title cancel:(NSString *)cancel msg:(NSString *)msg cmfTitle:(NSString *)title tag:(NSInteger)tag;
- (void)alertView:(UIAlertView *)alertView dismissWithBtnIndex:(NSInteger)index tag:(NSInteger)tag;
- (void)alertView:(UIAlertView *)alertView dismissWithBtnIndex:(NSInteger)index;
- (void)confirmAlert:(UIAlertView *)alertView tag:(NSInteger)tag;
- (void)confirmAlert:(UIAlertView *)alertView;


@end
