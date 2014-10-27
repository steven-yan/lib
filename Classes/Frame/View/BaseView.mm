/**
 *
 * BaseView
 * @author steven.yan
 * @date Otc 10 2014
 *
 **/

#import "BaseView.h"

@implementation BaseView



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithFrame:(CGRect)rect {
    if (self = [super initWithFrame:rect]) {
        [self onInit];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self onInit];
    }
    return self;
}

- (void)onInit {
}



#pragma mark -
#pragma mark ------------------------------alert----------------------------------
/*------------------------------------------------------------------------------
 |  alert
 |
 -----------------------------------------------------------------------------*/
- (void)alert:(NSString *)msg {
    [self alert:msg tag:0];
}
- (void)alert:(NSString *)msg tag:(NSInteger)tag {
    [self alertWithTitle:@"提示" msg:msg tag:tag];
}
- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg {
    [self alertWithTitle:title msg:msg tag:0];
}
- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg tag:(NSInteger)tag {
    [self alertWithTitle:title cancel:@"取消" msg:msg tag:tag];
}
- (void)alertWithTitle:(NSString *)title cancel:(NSString *)cancel msg:(NSString *)msg tag:(NSInteger)tag {
    [self alertWithTitle:title cancel:cancel msg:msg cmfTitle:@"确认" tag:tag];
}
- (void)alertWithTitle:(NSString *)title cancel:(NSString *)cancel msg:(NSString *)msg cmfTitle:(NSString *)cmfTitle tag:(NSInteger)tag {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancel otherButtonTitles:cmfTitle, nil];
    alert.tag = tag;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self alertView:alertView dismissWithBtnIndex:buttonIndex tag:alertView.tag];
    [self alertView:alertView dismissWithBtnIndex:buttonIndex];
    if (buttonIndex == 1) {
        [self confirmAlert:alertView tag:alertView.tag];
        [self confirmAlert:alertView];
    }
}

- (void)alertView:(UIAlertView *)alertView dismissWithBtnIndex:(NSInteger)index tag:(NSInteger)tag {
}
- (void)alertView:(UIAlertView *)alertView dismissWithBtnIndex:(NSInteger)index {
}
- (void)confirmAlert:(UIAlertView *)alertView tag:(NSInteger)tag {
}
- (void)confirmAlert:(UIAlertView *)alertView {
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
