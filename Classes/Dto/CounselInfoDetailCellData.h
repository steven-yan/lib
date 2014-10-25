/**
 *
 *  CounselInfoDetailCellData
 *  @author steven.yan
 *  @date Otc 19 2014
 *
 **/

@interface CounselInfoDetailCellData : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *photoPath;
@property (nonatomic, strong) NSString *sendFrom;
@property (nonatomic, strong) NSString *sendFromName;
@property (nonatomic, strong) NSString *sendTime;

- (id)initWithObj:(NSDictionary *)obj;



@end
