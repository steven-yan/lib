/**
 *
 *  HealthReportWebVc
 *  @author steven
 *  @date Sep 22 2014
 *
 **/

@interface HealthReportWebVc : BaseLayoutVc <UIWebViewDelegate>

//webView
@property (nonatomic, strong) UIWebView *ctrlWebView;
//peMasterId
@property (nonatomic, strong) NSString *peMasterId;



@end
