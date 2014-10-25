/**
 *
 *  HealthReportListVc
 *  @author steven
 *  @date Sep 22 2014
 *
 **/
#import "HealthReportListCell.h"

@interface HealthReportListVc : BaseSingleListVc <UITableViewDataSource, UITableViewDelegate>

//iv
@property (nonatomic, strong) UIImageView *ctrlIv;

//array
@property (nonatomic, strong) NSMutableArray *arrayOfCellData;



@end
