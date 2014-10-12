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
        //默认------------------------------
        //体检中心名称
        self.peisName = kEmptyStr;
        //地址
        self.addr = kEmptyStr;
        //电话
        self.phone = kEmptyStr;
        //套餐名称
        self.packageName = kEmptyStr;
        //套餐详情
        self.packageDetail = kEmptyStr;
        //预约时间
        self.date = kEmptyStr;
        //预约状态
        self.status = kEmptyStr;
        
        //转换------------------------------
        if (obj!=nil) {
//            //体检中心名称
//            self.peisName = kEmptyStr;
//            //地址
//            self.addr = kEmptyStr;
//            //电话
//            self.phone = kEmptyStr;
//            //套餐名称
//            self.packageName = kEmptyStr;
//            //套餐详情
//            self.packageDetail = kEmptyStr;
//            //预约时间
//            self.date = kEmptyStr;
//            //预约状态
//            self.status = kEmptyStr;
        }
        
        //test
        [self unitTest];
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
- (void)unitTest {
    //体检中心名称
    self.peisName = @"体检中心名称";
    //地址
    self.addr = @"地址";
    //电话
    self.phone = @"电话";
    //套餐名称
    self.packageName = @"套餐名称";
    //套餐详情
    self.packageDetail = @"套餐详情";
    //预约时间
    self.date = @"2014 08-26";
    //预约状态
    self.status = @"预约状态";
}



@end
