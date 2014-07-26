/**
 * 
 *@author steven.yan
 *
 */

#import "RootVcPanel1.h"

@implementation RootVcPanel1



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithVc:(BaseVC *)vc {
    if (self = [super initWithFrame:CGRectMake(0, 0, vc.view.width, vc.view.height - [SysInfo instance].bottomPanelHeight)]) {
        //页面
        self.nrVc = vc;
        //-

        //控件-------------------
        TopPanel *tp = [[TopPanel alloc] init];
        tp.delegate = self;
        [tp changeLeftBtnWithTitle:@""];
        tp.ctrlRightBtn.hidden = YES;
        [tp changeTitle:@"体检中心"];
        [self addSubview:tp];
        //搜索----------
        //提示
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
        img.center = tp.ctrlLeftBtn.center;
        img.image = [UIImage imageNamed:@"search_icon.png"];
        [tp addSubview:img];
        //面板
        SearchPanel *sp = [[SearchPanel alloc] initWithVc:self.nrVc];
        sp.ctrlTf.placeholder = @"搜索医院";
        [self addSubview:sp];
        self.ctrlSearchPanel = sp;
        
        //mapView
        MKMapView *mv = [[MKMapView alloc] initWithFrame:vc.contentPanel.bounds];
        mv.showsUserLocation = YES;
        mv.mapType = MKMapTypeStandard;
        mv.height = vc.contentPanel.height - [SysInfo instance].bottomPanelHeight;
        mv.top = tp.bottom;
        [self addSubview:mv];
        self.ctrlMapView = mv;
        
        CLLocationManager *lm = [[CLLocationManager alloc] init];
        lm.delegate = self;
        self.manager = lm;
        [lm startUpdatingLocation];
        //数据-------------------
    }
    
    return self;
}



#pragma mark -
#pragma mark ------------------------------方法----------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/
//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
//    [self.manager stopUpdatingLocation];
//    
//    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(newLocation.coordinate.latitude,newLocation.coordinate.longitude);
//    float zoomLevel = 0.02;
//    MKCoordinateRegion region = MKCoordinateRegionMake(coords,MKCoordinateSpanMake(zoomLevel, zoomLevel));
//    [self.ctrlMapView setRegion:[self.ctrlMapView regionThatFits:region] animated:YES];
//}
//
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
//}



#pragma mark -
#pragma mark ------------------------------方法----------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/



#pragma mark -
#pragma mark ------------------------TopPanelDelegate---------------------------
/*------------------------------------------------------------------------------
 |  TopPanelDelegate
 |
 -----------------------------------------------------------------------------*/
-(void)onTopPanelLeftBtnClicked {
    [self.ctrlSearchPanel openPanel];
}


-(void)onTopPanelRightBtnClicked {
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/



@end
