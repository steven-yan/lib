/**
 * xxxx
 *
 */
#import "BaseVC.h"

@class SearchPanel;

@protocol SearchPanelDelegate <NSObject>
@optional
@end

@interface SearchPanel : UIView <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

//代理
@property (weak) NSObject<SearchPanelDelegate> *delegate;

//页面
@property (weak) BaseVC *nrVc;

//背景
@property (nonatomic, strong) UIScrollView *ctrlBg;
//搜索框
@property (nonatomic, strong) UIView *ctrlSearchBar;
//textfiled
@property (nonatomic, strong) UITextField *ctrlTf;
//tableView
@property (nonatomic, strong) UITableView *ctrlTableView;
//搜索提示
@property (nonatomic, strong) UILabel *ctrlHint;

//搜索结果
@property (nonatomic, strong) NSMutableArray *searchResult;
//搜索标志
@property BOOL searchTag;



-(id)initWithVc:(BaseVC *)vc;
-(void)openPanel;



@end
