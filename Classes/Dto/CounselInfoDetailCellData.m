/**
 *
 *  CounselInfoDetailCellData
 *  @author steven.yan
 *  @date Otc 19 2014
 *
 **/

#import "CounselInfoDetailCellData.h"

@implementation CounselInfoDetailCellData

- (id)initWithObj:(NSDictionary *)obj {
    if (self = [super init]) {
        //转换------------------------------
        if (obj!=nil) {
            self.content = [obj valueForKey:@"content"];
            self.photoPath = [obj valueForKey:@"photoPath"];
            self.sendFrom = [obj valueForKey:@"sendFrom"];
            self.sendFromName = [obj valueForKey:@"sendFromName"];
            self.sendTime = [obj valueForKey:@"sendTime"];
        }
        
        //容错------------------------------
        self.content = [ChkUtil handleNil:self.content];
        self.photoPath = [ChkUtil handleNil:self.photoPath];
        self.sendFrom = [ChkUtil handleNil:self.sendFrom];
        self.sendFromName = [ChkUtil handleNil:self.sendFromName];
        self.sendTime = [ChkUtil handleNil:self.sendTime];
    }
    
	return self;
}



@end
