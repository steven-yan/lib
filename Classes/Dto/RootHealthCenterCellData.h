/**
 *
 *  RootHealthCenterCellData
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

@interface RootHealthCenterCellData : NSObject

//id
@property (nonatomic, strong) NSString *centerId;
//图片地址
@property (nonatomic, strong) NSString *imgUrl;
//名称
@property (nonatomic, strong) NSString *name;
//地址
@property (nonatomic, strong) NSString *addr;
//电话
@property (nonatomic, strong) NSString *tel;

- (id)initWithObj:(NSDictionary *)obj;



@end
