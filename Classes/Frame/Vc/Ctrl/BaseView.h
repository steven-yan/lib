/**
 *
 * BaseView
 * @author steven.yan
 * @date Otc 18 2014
 *
 **/

@interface BaseView : UIView

//content
@property (nonatomic, strong) UIView *content;

//init
- (id)initWithFrame:(CGRect)rect;
//create
- (void)_onCreateBegain;



@end
