/**
 *
 *  LockPatternDot
 *  @author steven
 *  @date April 28 2015
 *
 **/

#import "LockPatternDot.h"

@interface LockPatternDot ()

//arrow
@property (nonatomic, strong) UIImageView *ctrlArrow;
//angle
@property (nonatomic) CGFloat angle;

@end

@implementation LockPatternDot
static NSString *kNorImgName = @"btn_lockdefault";
static NSString *kHlImgName = @"btn_lockdefault_blue";
static NSString *kFailedImgName = @"btn_lockdefault_red";



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)init {
    if (self = [super init]) {
        //控件------
        UIImage *norImg = [UIImage imageNamed:kNorImgName];
        UIImage *hlImg = [UIImage imageNamed:kHlImgName];
        self.frame = CGRectMake(0, 0, norImg.size.width, norImg.size.height);
        [self setImage:norImg];
        [self setHighlightedImage:hlImg];
        
        //箭头--
        _ctrlArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_lock"]];
        _ctrlArrow.left = self.width * 0.80;
        _ctrlArrow.centerY = self.height/2;
        _ctrlArrow.hidden = YES;
        [self addSubview:_ctrlArrow];
        
        //数据------
        _angle = CGFLOAT_MAX;
        
        //其他------
    }
    
    return self;
}



#pragma mark -
#pragma mark ------------------------------方法----------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/
- (void)reset {
    [self setDotState:LockPatternDotStateNormal];
    _angle = CGFLOAT_MAX;
}

- (void)setDotState:(LockPatternDotState)state {
    _dotState = state;
    _ctrlArrow.hidden = YES;
    self.highlighted = NO;
    
    switch (state) {
        case LockPatternDotStateNormal:
            [self setImage:[UIImage imageNamed:kNorImgName]];
            break;
        case LockPatternDotStateHighlighted:
            self.highlighted = YES;
            break;
        case LockPatternDotStateFailed:
            [self setImage:[UIImage imageNamed:kFailedImgName]];
            if (_angle != CGFLOAT_MAX) {
                _ctrlArrow.hidden = NO;
            }
            break;
        default:
            break;
    }
}

//set uniqueId
- (void)setUniqueIdWithRow:(NSInteger)row column:(NSInteger)column {
    _uniqueId = [NSString stringWithFormat:@"%ld-%ld", (long)row, (long)column];
}

//show arraw
- (void)setArrowWithAngle:(CGFloat)angle {
    [_ctrlArrow rotateWithPoint:CGPointMake(self.width/2, self.height/2) angle:angle];
    _angle = angle;
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
