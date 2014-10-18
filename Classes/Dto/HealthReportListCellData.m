/**
 *
 *  HealthReportListCellData
 *  @author steven.yan
 *  @date Otc 14 2014
 *
 **/

#import "HealthReportListCellData.h"

@implementation HealthReportListCellData

- (id)initWithObj:(NSDictionary *)obj {
    if (self = [super init]) {
        //转换------------------------------
        //用户名
        self.userName = [obj valueForKey:@"userName"];
        //体检号
        self.peMasterId = [obj valueForKey:@"peMasterId"];
        //预约时间
        self.peDate = [obj valueForKey:@"peDate"];
        //体检中心
        self.peisName = [obj valueForKey:@"peisName"];
    }
        
    //容错------------------------------
    self.userName = [ChkUtil handleNil:self.userName];
    self.peMasterId = [ChkUtil handleNil:self.peMasterId];
    self.peDate = [ChkUtil handleNil:self.peDate];
    self.peisName = [ChkUtil handleNil:self.peisName];
    
	return self;
}



@end
