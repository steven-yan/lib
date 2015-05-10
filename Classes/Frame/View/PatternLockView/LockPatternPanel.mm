/**
 *
 *  LockPatternPanel
 *  @author steven
 *  @date April 28 2015
 *
 **/

#import "LockPatternDot.h"
#import "LockPatternLine.h"
#import "LockPatternPanel.h"

@interface LockPatternPanel()

//bg
@property (nonatomic, strong) UIView *ctrlBg;
//row num of dots
@property (nonatomic, readonly) NSInteger rowNum;
//row gap
@property (nonatomic, readonly) CGFloat rowGap;
//column num of dots
@property (nonatomic, readonly) NSInteger columnNum;
//column gap
@property (nonatomic, readonly) CGFloat columnGap;
//line
@property (nonatomic, strong) LockPatternLine *ctrlLine;
//selecetd dots
@property (nonatomic, strong) NSMutableArray *arrayOfSelectedDots;
//addition point
@property (nonatomic) CGPoint trackPoint;
//finish flag
@property (nonatomic) BOOL finishedFlag;
//failed flag
@property (nonatomic) BOOL failedFlag;
//topOffset
@property (nonatomic) CGFloat topOffset;

@end

@implementation LockPatternPanel
static NSInteger kDefaultNum = 3;



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //self--
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_lock"]];
        
        //控件------
        //bg
        _ctrlBg = [[UIView alloc] init];
        [self addSubview:_ctrlBg];
        
        //line
        _ctrlLine = [[LockPatternLine alloc] init];
        
        //数据------
        //row
        _rowNum = kDefaultNum;
        _rowGap = 0;
        //column
        _columnNum = kDefaultNum;
        _columnGap = 0;
        //dots
        _arrayOfSelectedDots = [NSMutableArray array];
        
        //其他------
    }
    
    return self;
}

/*
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    [super drawLayer:layer inContext:ctx];
    
    //line
    if (_arrayOfSelectedDots.count > 0) {
        //line
        LockPatternLine *line = [[LockPatternLine alloc] init];
        for (LockPatternDot *dot in _arrayOfSelectedDots) {
            [line addPoint:[self convertPoint:dot.center fromView:_ctrlBg]];
        }
        
        //TODO: fix me
        //        LockPatternDot *d = nil;
        //        for (LockPatternDot *dot in [self getDots]) {
        //            if (![_arrayOfSelectedDots containsObject:dot] && [line containsPoint:[self convertPoint:dot.center fromView:_ctrlBg]]) {
        //                d = dot;
        //            }
        //        }
        //        if (d) {
        //            [d setDotState:LockPatternDotStateHighlighted];
        //            [_arrayOfSelectedDots insertObject:d atIndex:_arrayOfSelectedDots.count - 1];
        //            [self drawLine];
        //        }
        
        //track
        if (!CGPointEqualToPoint(CGPointZero, _trackPoint)) {
            [line addPoint:_trackPoint];
        }
        
//        CGPathRef ref = [line getLinePath];
        CAShapeLayer *layer1 = [CAShapeLayer layer];
        layer1.path = [line getLinePath];
        layer1.strokeColor = [UIColor redColor].CGColor;
        layer1.lineWidth = 2;
        [layer insertSublayer:layer1 atIndex:0];
//        [line finish];
    }
}*/

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //draw dots
    [self setLockPatternDots];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (_arrayOfSelectedDots.count > 0) {
        //line
        LockPatternLine *line = [[LockPatternLine alloc] init];
        if (_failedFlag) {
            [line setLineState:LockPatternLineStateFailed];
        }
        for (LockPatternDot *dot in _arrayOfSelectedDots) {
            [line addPoint:[self convertPoint:dot.center fromView:_ctrlBg]];
        }
        
        //TODO: fix me
        //        LockPatternDot *d = nil;
        //        for (LockPatternDot *dot in [self getDots]) {
        //            if (![_arrayOfSelectedDots containsObject:dot] && [line containsPoint:[self convertPoint:dot.center fromView:_ctrlBg]]) {
        //                d = dot;
        //            }
        //        }
        //        if (d) {
        //            [d setDotState:LockPatternDotStateHighlighted];
        //            [_arrayOfSelectedDots insertObject:d atIndex:_arrayOfSelectedDots.count - 1];
        //            [self drawLine];
        //        }
        
        //track
        if (!CGPointEqualToPoint(CGPointZero, _trackPoint) && !_finishedFlag) {
            [line addPoint:_trackPoint];
        }
        
        [line finish];
    }
}



#pragma mark -
#pragma mark ------------------------------方法----------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/
- (void)setWithNum:(NSInteger)num gap:(CGFloat)gap {
    [self setWithRowNum:num rowGap:gap columnNum:num columnGap:gap];
}

- (void)setWithRowNum:(NSInteger)rowNum
               rowGap:(CGFloat)rowGap
            columnNum:(NSInteger)columnNum
            columnGap:(CGFloat)columnGap {
    //properity
    _rowNum = rowNum;
    _rowGap = rowGap;
    _columnNum = columnNum;
    _columnGap = columnGap;
    
    //refresh
    [self setNeedsLayout];
}

- (void)setDotsTopOffset:(CGFloat)offfset {
    _topOffset = offfset;
}



#pragma mark -
#pragma mark ----------------------------touches--------------------------------
/*------------------------------------------------------------------------------
 |  touches
 |
 -----------------------------------------------------------------------------*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_finishedFlag) {
        return;
    }
    
    LockPatternDot *dot = [self getDotWithTouch:[touches anyObject]];
    if (dot) {
        [_arrayOfSelectedDots addObject:dot];
        [dot setDotState:LockPatternDotStateHighlighted];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_finishedFlag) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    LockPatternDot *dot = [self getDotWithTouch:touch];
    if (dot && [_arrayOfSelectedDots containsObject:dot] == NO) {
        [dot setDotState:LockPatternDotStateHighlighted];
        if (_arrayOfSelectedDots.count > 0) {
            LockPatternDot *tmpDot = [_arrayOfSelectedDots lastObject];
            if (tmpDot != dot) {
                CGPoint p0 = [self convertPoint:tmpDot.center fromView:_ctrlBg];
                CGPoint p1 = [self convertPoint:dot.center fromView:_ctrlBg];
                CGFloat angle = atan((p1.y-p0.y)/(p1.x-p0.x));
                if (p1.x < p0.x) {
                    angle += M_PI;
                }
                [tmpDot setArrowWithAngle:angle];
            }
        }
        [_arrayOfSelectedDots addObject:dot];
    } else {
        _trackPoint = [touch locationInView:self];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_finishedFlag) {
        return;
    }
    
    [self finish];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_failedFlag) {
        return;
    }
    
    [self finish];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)finish {
    _finishedFlag = YES;
    NSInteger t = 0;
    
    NSString *passCode = [self getPassCode];
    if ([ChkUtil isEmptyStr:passCode] == NO) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onLockPatternPanel:didEndWithPassCode:)]) {
            [self.delegate onLockPatternPanel:self didFinishWithPassCode:passCode];
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(onLockPatternPanel:needShowErrorWithPassCode:)]) {
            if ([self.delegate onLockPatternPanel:self needShowErrorWithPassCode:passCode]) {
                t = 1;
                _failedFlag = YES;
                for (LockPatternDot *dot in _arrayOfSelectedDots) {
                    [dot setDotState:LockPatternDotStateFailed];
                }
            }
        }
        
        [self setNeedsDisplay];
    }

    [self performSelector:@selector(reset) withObject:nil afterDelay:t];
}

- (void)reset {
    for (LockPatternDot *dot in _arrayOfSelectedDots) {
        [dot reset];
    }
    [_arrayOfSelectedDots removeAllObjects];
    _trackPoint = CGPointMake(0, 0);
    _finishedFlag = NO;
    _failedFlag = NO;
    
    [self setNeedsDisplay];
}

- (void)setLockPatternDots {
    //bg
    [_ctrlBg removeAllSubViews];
    LockPatternDot *tmpDot = [[LockPatternDot alloc] init];
    _rowGap = tmpDot.width * 1.3;
    _columnGap = tmpDot.height * 1.3;
    [_ctrlBg setFrame:CGRectMake(0, 0, _rowGap * (_rowNum - 1), _columnGap * (_columnNum- 1))];
    //center
    _ctrlBg.centerX = self.width/2;
    _ctrlBg.centerY = self.height/2 + _topOffset;
    
    for (int i = 0; i < _rowNum; i++) {
        for (int j = 0; j < _columnNum; j++) {
            LockPatternDot *dot = [[LockPatternDot alloc] init];
            dot.centerX = _rowGap * j;
            dot.centerY = _columnGap * i;
            [dot setUniqueIdWithRow:i column:j];
            [_ctrlBg addSubview:dot];
        }
    }
}

- (LockPatternDot *)getDotWithTouch:(UITouch *)touch {
    for (LockPatternDot *dot in [self getDots]) {
        CGPoint point = [touch locationInView:dot];
        if ((point.x > 0 && point.x < dot.width) && (point.y > 0 && point.y < dot.height)) {
            return dot;
        }
    }
    
    return nil;
}

- (NSArray *)getDots {
    return [_ctrlBg subviews];
}

- (NSString *)getPassCode {
    if (_arrayOfSelectedDots.count <= 0) {
        return nil;
    }
    
    NSString *passCode = @"";
    for (LockPatternDot *dot in _arrayOfSelectedDots) {
        passCode = [passCode stringByAppendingFormat:@"%@|", dot.uniqueId];
    }
    
    return [passCode stringByReplacingCharactersInRange:NSMakeRange(passCode.length - 1, 1) withString:@""];
}



@end
