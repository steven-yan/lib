/**
 *
 *  CounselInfoDetailVc
 *  @author steven
 *  @date Otc 7 2014
 *
 **/

#import "CounselInfoDetailCellData.h"
#import "CounselInfoDetailCell.h"
#import "CounselInfoPanel.h"

@interface CounselInfoDetailVc : BaseSingleListVc <CounselInfoPanelDelegate>

//bg
@property (nonatomic, strong) UIView *ctrlBg;
//Counsel Panel
@property (nonatomic, strong) CounselInfoPanel *ctrlCounsel;

//messageId
@property (nonatomic, strong) NSString *messageId;
@property (nonatomic, strong) NSString *text;

//cd
@property (nonatomic, strong) NSMutableArray *arrayOfCellData;



@end
