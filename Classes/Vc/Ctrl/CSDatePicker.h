/**
 *
 *  CSDatePicker
 *  @author steven.yan
 *  @date Otc 12 2014
 *
 **/

@class CSDatePicker;

@protocol CSDatePickerDelegate <NSObject>
- (void)onCSDatePickerDelegate:(CSDatePicker *)picker;
@optional
@end

@interface CSDatePicker : UIView

//代理
@property (weak) NSObject<CSDatePickerDelegate> *delegate;
//页面
@property (weak) BaseVc *nrVc;

//datePicker
@property (nonatomic, strong) UIDatePicker *ctrlDatePicker;

//init
- (id)initWithTitle:(NSString *)title;

- (void)show;
- (NSString *)getDateStr;



@end
