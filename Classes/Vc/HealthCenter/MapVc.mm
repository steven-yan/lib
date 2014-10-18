/**
 *
 *  MapVc
 *  @author steven
 *  @date Otc 18 2014
 *
 **/

#import "MapVc.h"

@implementation MapVc



#pragma mark -
#pragma mark ------------------------------窗体----------------------------------
/*------------------------------------------------------------------------------
 |  窗体
 |
 -----------------------------------------------------------------------------*/
//窗体创建
- (void)onCreate {
    //顶部面板-----------
    [self changeTopTitle:@"地图"];
    [self hideTopRightBtn];
    //内容面板-----------
    MKMapView *mv = [[MKMapView alloc] initWithFrame:self.contentPanel.bounds];
    mv.delegate = self;
    [self.contentPanel addSubview:mv];
    self.ctrlMapView = mv;
    
    //底部面板-----------
    //其他--------------
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
//    NSString *city = [params valueForKey:@"city"];
    NSString *address = [params valueForKey:@"address"];
    NSLog(@"%@", address);
    
    CLGeocoder *ge = [[CLGeocoder alloc] init];
    [ge geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error){
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            //定位
            [self.ctrlMapView setRegion:MKCoordinateRegionMake(placemark.location.coordinate, MKCoordinateSpanMake(0.005, 0.005)) animated:YES];
            //anno----
            CSMapAnno *anno = [[CSMapAnno alloc] initWithCoordinate:CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude)];
            anno.title = placemark.locality;
            anno.subtitle = placemark.subLocality;
            [self.ctrlMapView addAnnotation:anno];
        }
    }];
}

//解析导航返回
- (void)onPraseNavBackParams:(NSDictionary *)params {
}

//窗体将要显示------
- (void)onWillShow {
    
}

//窗体显示
- (void)onShow {
}

//隐藏------
- (void)onWillHide {
}

//导航栏------
- (void)topLeftBtnClicked {
    [self navBack];
}

- (void)topRightBtnClicked {
}



#pragma mark -
#pragma mark --------------------------获取和提交数据-----------------------------
/*------------------------------------------------------------------------------
 |  获取和提交数据
 |
 -----------------------------------------------------------------------------*/
- (void)loadData {
    [self httpGet:[AppUtil healthUrl:@""]];
}

- (void)onHttpRequestSuccessObj:(NSDictionary *)dic {
}

//完善参数
- (void)completeQueryParams {
}



#pragma mark -
#pragma mark ------------------------MKMapViewDelegate--------------------------
/*------------------------------------------------------------------------------
 |  MKMapViewDelegate
 |
 -----------------------------------------------------------------------------*/
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    MKPinAnnotationView *annoView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MKPinAnnotationView"];
    annoView.pinColor = MKPinAnnotationColorRed;
    annoView.animatesDrop = YES;
    
    return annoView;
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
