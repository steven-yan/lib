/**
 *
 *  RootExpertRmdCellData
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "RootExpertRmdCellData.h"

@implementation RootExpertRmdCellData

- (id)initWithObj:(NSDictionary *)obj {
    if (self = [super init]) {
        //默认------------------------------
        //图片地址
        self.imgUrl = kEmptyStr;
        //专家名字
        self.name = kEmptyStr;
        //专家简介
        self.desp = kEmptyStr;
        
        //转换------------------------------
        if (obj!=nil) {
            
        }
    }
    
    //测试
    [self unitTest];
    
	return self;
}

- (void)unitTest {
    self.imgUrl = @"http://www.news.cn/politics/static/ldrtp/001.jpg";
    self.name = @"王二";
    self.desp = @"奇偶撒旦奇偶撒旦奇偶撒旦奇奇偶撒旦奇偶撒旦奇偶撒旦奇奇偶撒旦奇偶撒旦奇偶撒旦奇奇偶撒旦奇偶撒旦奇偶撒旦奇奇偶撒旦奇奇偶撒旦奇偶撒旦教佛i是打发";
}



@end
