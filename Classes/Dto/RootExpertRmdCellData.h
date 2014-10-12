/**
 *
 *  RootExpertRmdCellData
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

@interface RootExpertRmdCellData : NSObject

//专家id
@property (nonatomic, strong) NSString *expertId;
//专家名字
@property (nonatomic, strong) NSString *name;
//专家简介
@property (nonatomic, strong) NSString *desp;
//图片地址
@property (nonatomic, strong) NSString *imgUrl;

- (id)initWithObj:(NSDictionary *)obj;



@end
