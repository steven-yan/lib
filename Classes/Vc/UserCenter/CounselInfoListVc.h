/**
 *
 *  CounselInfoVc
 *  @author steven
 *  @date Oct 7 2014
 *
 **/

#import "CounselInfoCell.h"
#import "CounselInfoPanel.h"

@interface CounselInfoListVc : BaseSingleListVc <CounselInfoPanelDelegate>

//cp
@property (nonatomic, strong) CounselInfoPanel *ctrlCounselPanel;
//cd
@property (nonatomic, strong) NSMutableArray *arrayOfCellData;

//text
@property (nonatomic, strong) NSString *text;



@end
