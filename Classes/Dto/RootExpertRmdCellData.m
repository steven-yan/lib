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
        //转换------------------------------
        if (obj!=nil) {
            //专家id
            self.expertId = [obj valueForKey:@"doctorId"];
            //图片地址
            self.imgUrl = [obj valueForKey:@"photoPath"];
            //专家名字
            self.name = [obj valueForKey:@"doctorName"];
            //专家简介
            self.desp = [obj valueForKey:@"summary"];
        }
        
        //容错------------------------------
        //图片地址
        if ([ChkUtil isEmptyStr:self.imgUrl]) {
            self.imgUrl = kEmptyStr;
        }
        //专家名字
        if ([ChkUtil isEmptyStr:self.name]) {
            self.name = kEmptyStr;
        }
        //专家简介
        if ([ChkUtil isEmptyStr:self.desp]) {
            self.desp = kEmptyStr;
        }
    }
    
	return self;
}

- (void)unitTest {
    self.imgUrl = @"http://www.news.cn/politics/static/ldrtp/001.jpg";
    self.name = @"王二";
    self.desp = @"奇偶撒旦奇偶撒旦奇偶撒旦奇奇偶撒旦奇偶撒旦奇偶撒旦奇奇偶撒旦奇偶撒旦奇偶撒旦奇奇偶撒旦奇偶撒旦奇偶撒旦奇奇偶撒旦奇奇偶撒旦奇偶撒旦教佛i是打发";
}



@end
