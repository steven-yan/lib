/**
 *
 * BaseView
 * @author steven.yan
 * @date Otc 10 2014
 *
 **/

@interface BaseView : UIView


//alert--------
- (void)alert:(NSString *)msg;
- (void)alert:(NSString *)msg tag:(NSInteger)tag;
- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg;
- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg tag:(NSInteger)tag;
- (void)alertWithTitle:(NSString *)title cancel:(NSString *)cancel msg:(NSString *)msg tag:(NSInteger)tag;
- (void)alertWithTitle:(NSString *)title cancel:(NSString *)cancel msg:(NSString *)msg cmfTitle:(NSString *)title tag:(NSInteger)tag;
- (void)alertView:(UIAlertView *)alertView dismissWithBtnIndex:(NSInteger)index tag:(NSInteger)tag;
- (void)alertView:(UIAlertView *)alertView dismissWithBtnIndex:(NSInteger)index;
- (void)confirmAlert:(UIAlertView *)alertView tag:(NSInteger)tag;
- (void)confirmAlert:(UIAlertView *)alertView;

//init
- (id)init;
- (id)initWithFrame:(CGRect)rect;

- (void)onInit;



@end
