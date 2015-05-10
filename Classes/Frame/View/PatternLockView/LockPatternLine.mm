/**
 *
 *  LockPatternLine
 *  @author steven
 *  @date April 29 2015
 *
 **/

#import "LockPatternLine.h"

@interface LockPatternLine ()

//path
@property (nonatomic, strong) UIBezierPath *bezierPath;

//line color --
//default
@property (nonatomic, strong) UIColor *defaultColor;
//failed
@property (nonatomic, strong) UIColor *failedColor;

//line width
@property (nonatomic) CGFloat lineWidth;

@end

@implementation LockPatternLine
static NSString *kDefaultLineColor = @"#1ab5ed";
static NSString *kFailedLineColor = @"#d60c0c";
static CGFloat kDefaultLineWidth = 2;



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)init {
    if (self = [super init]) {
        //控件------
        
        //数据------
        _defaultColor = [UIColor colorWithHexStr:kDefaultLineColor alpha:0.8];
        _failedColor = [UIColor colorWithHexStr:kFailedLineColor alpha:0.8];
        _lineWidth = kDefaultLineWidth;
        
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
- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
}

//line color --
//default
- (void)setDefaultLineColor:(UIColor *)color {
    _defaultColor = color;
}
//failed
- (void)setFailedLineColor:(UIColor *)color {
    _failedColor = color;
}

- (void)addPoint:(CGPoint)point {
    if (!_bezierPath) {
        _bezierPath = [UIBezierPath bezierPath];
        _bezierPath.lineWidth = _lineWidth;
        _bezierPath.lineJoinStyle = kCGLineJoinRound;
        [_bezierPath moveToPoint:point];
    } else {
        [_bezierPath addLineToPoint:point];
    }
}

- (void)finish {
    if (_lineState == LockPatternLineStateFailed) {
        [_failedColor setStroke];
    } else {
        [_defaultColor setStroke];
    }
    
    [_bezierPath stroke];
    [_bezierPath closePath];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
