/**
 *
 *  RootVc
 *  @author steven
 *  @date   July 10 2014
 *
 **/

#import "BaseVC.h"
#import "BottomPanel.h"

@interface RootVc : BaseVC <BottomPanelDelegate>

//bottom
@property (nonatomic, strong) BottomPanel *ctrlBottomPanel;



@end
