/**
 *
 *  LockPatternDot
 *  @author steven
 *  @date April 28 2015
 *
 **/

@class LockPatternDot;

@protocol LockPatternDotDelegate <NSObject>
@optional
@end

@interface LockPatternDot : UIImageView

typedef NS_ENUM(NSUInteger, LockPatternDotState) {
    LockPatternDotStateNormal = 0,
    LockPatternDotStateHighlighted,
    LockPatternDotStateFailed,
};

//delegate
@property (weak) NSObject<LockPatternDotDelegate> *delegate;
//dotState
@property (nonatomic, readonly) LockPatternDotState dotState;
//uniqueId
@property (nonatomic, strong, readonly) NSString *uniqueId;

//init
- (id)init;
//set state
- (void)setDotState:(LockPatternDotState)state;
//set uniqueId
- (void)setUniqueIdWithRow:(NSInteger)row column:(NSInteger)column;
//show arraw
- (void)setArrowWithAngle:(CGFloat)angle;
//reset
- (void)reset;

@end
