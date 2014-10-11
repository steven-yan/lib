/**
 *
 * BaseHttpVc
 * @author steven.yan
 * @date Otc 8 2014
 *
 **/

typedef enum {
    EnHttpConnectErrorTag = 100,
    EnHttpConnectTimeOutTag,
    EnHttpResponseContentErrorTag,  //内容格式错误 (非json格式)
    EnHttpResponseErrorHintTag,     //有出错信息
} EnHttpRequestFailed;

@interface BaseHttpVc : BaseVc <TopPanelDelegate>

//get 请求
@property (nonatomic, strong) ASIHTTPRequest *httpGetReq;
//post 请求
@property (nonatomic, strong) ASIFormDataRequest *httpPostReq;

//get请求参数
@property (nonatomic, strong) NSMutableDictionary *queryParams;

//页面隐藏是否取消请求
@property (nonatomic) BOOL closeHttpReqOnHideTag;

//get ------
- (void)httpGet:(NSString *)url;
- (void)httpGet:(NSString *)url tag:(NSInteger)tag;
- (void)httpGet:(NSString *)url params:(NSDictionary *)params tag:(NSInteger)tag;
- (void)httpGet:(NSString *)url timeOut:(NSTimeInterval)timeOut tag:(NSInteger)tag;
//请求成功--
- (void)onHttpRequestSuccessObj:(NSDictionary *)obj;
- (void)onHttpRequestSuccessObj:(NSDictionary *)obj tag:(NSInteger)tag;
//请求失败--
- (void)onHttpRequestFailed:(EnHttpRequestFailed)err hint:(NSString *)hint;
- (void)onHttpRequestFailed:(EnHttpRequestFailed)err hint:(NSString *)hint tag:(NSInteger)tag;
//设置参数--
- (void)completeQueryParams;
- (void)completeQueryParams:(NSInteger)tag;



@end
