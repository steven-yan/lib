/**
 *
 *  RootExpertRmdCellData
 *  @author steven.yan
 *  @date Sep 21 2014
 *
 **/

@interface RootExpertRmdCellData : NSObject

//图片地址
@property (nonatomic, strong) NSString *imgUrl;
//专家名字
@property (nonatomic, strong) NSString *name;
//专家简介
@property (nonatomic, strong) NSString *desp;

- (id)initWithObj:(NSMutableDictionary *)obj;



@end
