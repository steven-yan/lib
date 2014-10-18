/**
 *
 *  MapVc
 *  @author steven
 *  @date Otc 18 2014
 *
 **/

#import "CSMapAnno.h"

@interface MapVc : BaseLayoutVc <MKMapViewDelegate>

//map
@property (nonatomic, strong) MKMapView *ctrlMapView;
//mark
@property (nonatomic, strong) CLPlacemark *placemark;



@end
