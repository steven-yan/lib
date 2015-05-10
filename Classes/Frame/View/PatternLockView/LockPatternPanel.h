/**
 *
 *  LockPatternPanel
 *  @author steven
 *  @date April 28 2015
 *
 **/

@class LockPatternPanel;

typedef NS_ENUM(NSUInteger, LockPatternPanelError) {
    LockPatternPanelErrorPassCodeAuthFailed = 0,
    LockPatternPanelErrorDotMinNum,
};

@protocol LockPatternPanelDelegate <NSObject>
@optional
- (void)onLockPatternPanel:(LockPatternPanel *)panel didFinishWithPassCode:(NSString *)passCode;
- (BOOL)onLockPatternPanel:(LockPatternPanel *)panel needShowErrorWithPassCode:(NSString *)passCode;
@end

@interface LockPatternPanel : UIView

//delegate
@property (weak) NSObject<LockPatternPanelDelegate> *delegate;

//init
- (id)initWithFrame:(CGRect)frame;
//default dots in center
- (void)setDotsTopOffset:(CGFloat)offfset;



@end
