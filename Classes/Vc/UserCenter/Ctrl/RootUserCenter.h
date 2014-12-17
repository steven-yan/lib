/**
 *
 *  RootUserCenter
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

#import "TabBarContentPanel.h"
#import "GTMBase64.h"

@protocol RootUserCenterDelegate <NSObject>
@optional
@end

@interface RootUserCenter : TabBarContentPanel <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

//tv
@property (nonatomic, strong) UITableView *ctrlTableView;
//user img
@property (nonatomic, strong) UIImageView *ctrlUserImg;

//img
@property (nonatomic, strong) UIImage *image;
//state
@property (nonatomic) EN_LOGIN_STATE_T userState;

//upgradeUrl
@property (nonatomic, strong) NSString *upgradeUrl;

//init
- (id)initWithVc:(BaseLayoutVc *)vc;



@end
