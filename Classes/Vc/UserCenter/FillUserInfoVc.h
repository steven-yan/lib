/**
 *
 *  FillUserInfoVc
 *  @author steven
 *  @date Sep 22 2014
 *
 **/

@interface FillUserInfoVc : BaseLayoutVc <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *ctrlTfName;
@property (nonatomic, strong) UITextField *ctrlTfPhone;
@property (nonatomic, strong) UITextField *ctrlTfMail;
@property (nonatomic, strong) UISegmentedControl *ctrlSegSex;
@property (nonatomic, strong) UISegmentedControl *ctrlSegMarrage;
@property (nonatomic, strong) UISegmentedControl *ctrlSegIdType;
@property (nonatomic, strong) UITextField *ctrlTfId;



@end
