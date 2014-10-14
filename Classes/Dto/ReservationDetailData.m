/**
 *
 *  ReservationDetailData
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "ReservationDetailData.h"

@implementation ReservationDetailData



#pragma mark -
#pragma mark ------------------------------初始---------------------------------
/*------------------------------------------------------------------------------
 |  初始
 |
 -----------------------------------------------------------------------------*/
- (id)initWithObj:(NSDictionary *)obj {
    if (self = [super init]) {
        //转换------------------------------
        if (obj!=nil) {
            //体检中心
            self.peisCenterId = [obj valueForKey:@"peisCenterId"];
            //体检号
            self.peMasterId = [obj valueForKey:@"peMasterId"];
            //体检中心名称
            self.peisName = [obj valueForKey:@"peisName"];
            //地址
            self.address = [obj valueForKey:@"address"];
            //电话
            self.tel = [obj valueForKey:@"tel"];
            //套餐名称
            self.packageName = [obj valueForKey:@"packageName"];
            //套餐详情
            self.packageDetail = [obj valueForKey:@"packageDetail"];
            //预约时间
            self.peDate = [obj valueForKey:@"peDate"];
            //预约状态
            self.statusText = [obj valueForKey:@"statusText"];
            //预约状态代码
            self.status = [obj valueForKey:@"status"];
        }
        
        //容错------------------------------
        //体检中心
        self.peisCenterId = [ChkUtil handleNil:self.peisCenterId];
        //体检号
        self.peMasterId = [ChkUtil handleNil:self.peMasterId];
        //体检中心名称
        self.peisName = [ChkUtil handleNil:self.peisName];
        //地址
        self.address = [ChkUtil handleNil:self.address];
        //电话
        self.tel = [ChkUtil handleNil:self.tel];
        //套餐名称
        self.packageName = [ChkUtil handleNil:self.packageName];
        //套餐详情
        self.packageDetail = [ChkUtil handleNil:self.packageDetail];
        //预约时间
        self.peDate = [ChkUtil handleNil:self.peDate];
        //预约状态
        self.statusText = [ChkUtil handleNil:self.statusText];
        //预约状态代码
        self.status = [ChkUtil handleNil:self.status];
    }
    
	return self;
}



#pragma mark -
#pragma mark ------------------------------方法---------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/



#pragma mark -
#pragma mark ------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
