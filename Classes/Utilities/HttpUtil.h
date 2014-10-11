/**
 *
 *  HttpUtil
 *  @author steven.yan
 *  @date Otc 10 2014
 *
 **/

@interface HttpUtil : NSObject


+ (ASIHTTPRequest *)httpGet:(NSString *)url
                     params:(NSDictionary *)params
                   postData:(NSData *)data
                    timeOut:(NSTimeInterval)sec
          didFinishSelector:(SEL)didFinishSelector
              didFaillector:(SEL)didFailSelector
                   delegate:(id)delegate
                        tag:(NSInteger)tag;


@end
