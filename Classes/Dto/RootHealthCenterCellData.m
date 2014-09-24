/**
 *
 *  RootHealthCenterCellData
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "RootHealthCenterCellData.h"

@implementation RootHealthCenterCellData

- (id)initWithObj:(NSDictionary *)obj {
    if (self = [super init]) {
        //默认------------------------------
        //id
        self.centerId = kEmptyStr;
        //图片地址
        self.imgUrl = kEmptyStr;
        //名称
        self.name = kEmptyStr;
        //地址
        self.addr = kEmptyStr;
        //电话
        self.tel = kEmptyStr;
        
        //转换------------------------------
        if (obj!=nil) {
            //id
            self.centerId = [obj valueForKey:@"peisCenterId"];
            //图片地址
            self.imgUrl = [obj valueForKey:@"photoPath"];
            //名称
            self.name = [obj valueForKey:@"peisName"];
            //地址
            self.addr = [obj valueForKey:@"address"];
            //电话
            self.tel = [obj valueForKey:@"tel"];
        }
    }
    
    //单元测试
//    [self unitTest];
    
	return self;
}

- (void)unitTest {
    self.imgUrl = @"http://img0.bdstatic.com/img/image/shouye/dmhzw002.jpg";
    self.name = @"测试体检中心名字";
    self.addr = @"asdfsajdoifj奇i时代复分偶圣诞节佛撒娇的飞洒";
    self.tel = @"021-6666666";
}



@end
