/**
 *
 *  @author steven.yan
 *  @date August 3 2014
 *
 **/
//#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface BaseHttpVc : BaseVc <TopPanelDelegate>

//get 请求
@property (nonatomic, strong) ASIHTTPRequest *httpGetReq;
//post 请求
@property (nonatomic, strong) ASIFormDataRequest *httpPostReq;



@end
