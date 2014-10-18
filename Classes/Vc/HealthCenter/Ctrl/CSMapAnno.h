/**
 *
 * CSMapAnno
 * @author steven.yan
 * @date Otc 18 2014
 *
 **/

@protocol CSMapAnnoDelegate <NSObject>
@optional
@end

@interface CSMapAnno : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
}

-(id) initWithCoordinate:(CLLocationCoordinate2D) coords;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


@end
