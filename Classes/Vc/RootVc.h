/**
 *
 *  RootVc
 *  @author steven
 *  @date   July 10 2014
 *
 **/

@interface RootVc : BaseVc <BottomPanelDelegate>

//panel
//@property (nonatomic, strong) RootVcPanel0 *ctrlRvcPanel0;
//@property (nonatomic, strong) RootVcPanel1 *ctrlRvcPanel1;
//@property (nonatomic, strong) RootVcPanel2 *ctrlRvcPanel2;
//@property (nonatomic, strong) RootVcPanel3 *ctrlRvcPanel3;
//@property (nonatomic, strong) RootVcPanel4 *ctrlRvcPanel4;
@property (nonatomic, strong) NSMutableArray *panelArray;

//bottom
@property (nonatomic, strong) BottomPanel *ctrlBottomPanel;



@end
