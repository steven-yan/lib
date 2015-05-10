/**
 *
 *  LockPatternLine
 *  @author steven
 *  @date April 29 2015
 *
 **/

@class LockPatternLine;

@protocol LockPatternLineDelegate <NSObject>
@optional
@end

@interface LockPatternLine : NSObject

typedef NS_ENUM(NSUInteger, LockPatternLineState) {
    LockPatternLineStateNormal = 0,
    LockPatternLineStateFailed,
};

//delegate
@property (weak) NSObject<LockPatternLineDelegate> *delegate;
//dotState
@property (nonatomic) LockPatternLineState lineState;

//init
- (id)init;
//line width (default 2)
- (void)setLineWidth:(CGFloat)lineWidth;

//line color
//default
- (void)setDefaultLineColor:(UIColor *)color;
//failed
- (void)setFailedLineColor:(UIColor *)color;

//draw line
- (void)addPoint:(CGPoint)point;
//finish
- (void)finish;

@end
