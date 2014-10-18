/**
 *
 * BaseView
 * @author steven.yan
 * @date Otc 18 2014
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
       //content
        UIView *content = [[UIView alloc] initWithFrame:rect];
        [self addSubview:content];
        
        //create
        [self _onCreateBegain];
    }
    
    return self;
}

- (void)dealloc {
    [self _onClose];
}

- (void)_onCreateBegain {
}
- (void)_onClose{
}



#pragma mark -
#pragma mark ------------------------------方法----------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
