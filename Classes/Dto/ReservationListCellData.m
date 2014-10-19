/**
 *
 *  ReservationListCellData
 *  @author steven.yan
 *  @date Otc 12 2014
 *
 **/

#import "ReservationListCellData.h"

@implementation ReservationListCellData

- (id)initWithObj:(NSDictionary *)obj {
    if (self = [super init]) {
        //转换------------------------------
        if (obj!=nil) {
            //体检号
            self.peMasterId = [obj valueForKey:@"peMasterId"];
            //预约时间
            self.peDate = [obj valueForKey:@"peDate"];
            //体检中心
            self.peisName = [obj valueForKey:@"peisName"];
            //套餐名称
            self.packageName = [obj valueForKey:@"packageName"];
            //状态名称
            self.statusText = [obj valueForKey:@"statusText"];
            //状态
            self.status = [obj valueForKey:@"status"];
        }
        
        //容错------------------------------
        self.peMasterId = [ChkUtil handleNil:self.peMasterId];
        self.peDate = [ChkUtil handleNil:self.peDate];
        self.peisName = [ChkUtil handleNil:self.peisName];
        self.packageName = [ChkUtil handleNil:self.packageName];
        self.statusText = [ChkUtil handleNil:self.statusText];
        self.status = [ChkUtil handleNil:self.status];
    }
    
	return self;
}



@end
