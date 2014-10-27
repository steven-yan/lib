/**
 *
 *  Toast
 *  @author steven.yan
 *  @date Otc 25 2014
 *
 **/

@interface Toast : NSObject

//bg
@property (nonatomic, strong) UIView *ctrlToastBg;
//hint
@property (nonatomic, strong) UILabel *ctrlToastHint;

//instance
+ (instancetype)instance;
//show
- (void)show:(NSString *)text;



@end
