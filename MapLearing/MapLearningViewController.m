//
//  MapLearningViewController.m
//  MapLearing
//
//  Created by 邱扬 on 14-3-20.
//  Copyright (c) 2014年 邱扬. All rights reserved.
//

#import "MapLearningViewController.h"
#import "MyAnnotation.h"
#import "MyAnnotationView.h"
#import "DetailedViewController.h"

@interface MapLearningViewController ()

@end

@implementation MapLearningViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D baltimoreLocation = CLLocationCoordinate2DMake(39.303, 116.204);
    self.mapView.region = MKCoordinateRegionMakeWithDistance(baltimoreLocation, 10000, 10000);
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.mapView.showsUserLocation = YES;
        [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
        //[self.mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
    }
    
    MKUserTrackingBarButtonItem *trackingButton = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    [self.mapToolbar setItems:[NSArray arrayWithObject:trackingButton] animated:YES];
    
    self.userLocationLabel.text = @"getting location...";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//    self.userLocationLabel.text = [NSString stringWithFormat:@"邱扬: %.5f°, %.5f°", userLocation.coordinate.latitude, userLocation.coordinate.longitude];
//    NSLog(@"%@", self.userLocationLabel.text);
    
    //添加标注
//    MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc]init];
//    annotation1.title = @"Miami";
//    annotation1.subtitle = @"Peter";
//    annotation1.coordinate = userLocation.coordinate;
//    
//    [self.mapView addAnnotation:annotation1];
    
    //添加自定义标注
    MyAnnotation *ann1 = [[MyAnnotation alloc] initWithCoordinate:userLocation.coordinate title:@"邱扬" subtitle:@"peter" contactInformation:@"peter 在哪里"];
    NSArray *annotations = [NSArray arrayWithObjects:ann1, nil];
    [self.mapView addAnnotations:annotations];
    
    CLLocation *newLocation = userLocation.location;
    _geocoder = [[CLGeocoder alloc]init];
    CLGeocodeCompletionHandler handler = ^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0) {
            CLPlacemark *foundPlacemark = [placemarks objectAtIndex:0];
            NSDictionary *address = foundPlacemark.addressDictionary;
            
            NSString *Country = [address objectForKey:@"Country"];
            NSString *State = [address objectForKey:@"State"];
            NSString *SubLocality = [address objectForKey:@"SubLocality"];
//            NSString *Street = [address objectForKey:@"Street"];
//            NSString *SubThoroughfare = [address objectForKey:@"SubThoroughfare"];
           // NSString *Name = [address objectForKey:@"Name"];
            NSString *Thoroughfare = [address objectForKey:@"Thoroughfare"];
            
            self.userLocationLabel.text = [NSString stringWithFormat:@"邱扬：%@,%@,%@,%@",Country, State, SubLocality, Thoroughfare];
            NSLog(@"%@", self.userLocationLabel.text);
        }
    };
    [_geocoder reverseGeocodeLocation:newLocation completionHandler:handler];
	
	
	
	/*
		[_geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error){
            if ([placemarks count] > 0) {
                CLPlacemark *foundPlacemark = [placemarks objectAtIndex:0];
                double lat = newLocation.coordinate.latitude;  //纬度
                double log = newLocation.coordinate.longitude; //经度
                NSString *urlLocation = [[NSString alloc] initWithFormat:@"http://www.zdoz.net/api/daohang.aspx?TravelType=walking&startLat=%f&startLng=%f&endLat=%f&endLng=%f", lat, log, lat, log];
                [self.mapWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlLocation]]];
                NSDictionary *address = foundPlacemark.addressDictionary;
                NSString *name = [address objectForKey:@"Name"];
                _localLabel.text = name;
                
                //根据地点获取坐标
//                NSString *name = [[NSString alloc] initWithFormat:@"安和小区"];
//                [_geocoder geocodeAddressString:name completionHandler:^(NSArray *place, NSError *error){
//                    if ([place count] > 0) {
//                        CLPlacemark *foundplace = [place objectAtIndex:0];
//                        _localLabel.text = [NSString stringWithFormat:@"%f,%f",foundplace.location.coordinate.latitude, foundplace.location.coordinate.longitude];
//                    }
//                }];
            }
        }];
		*/
    
}

//修改标注颜色
- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        static NSString *userPinAnnotationId = @"userPinAnnotation";
//        MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:userPinAnnotationId];
//        if (annotationView) {
//            annotationView.annotation = annotation;
//        } else {
//            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:userPinAnnotationId];
//            
//            annotationView.pinColor = MKPinAnnotationColorGreen;
//            annotationView.draggable = YES;
//        }
//        return annotationView;
        
        //自定义
        MyAnnotationView *annotationView = (MyAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:userPinAnnotationId];
        if (annotationView) {
            annotationView.annotation = annotation;
        } else {
            annotationView = [[MyAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:userPinAnnotationId];
            
            //可拖拽
            annotationView.draggable = YES;
        }
        return annotationView;
    }
    return nil;
}

//显示一个模态视图控制器
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    DetailedViewController *dvc = [[DetailedViewController alloc]initWithAnnotation:view.annotation];
    dvc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:dvc animated:YES completion:^{}];
}

//绘制大头针时拦截，并在新位置显示
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
    if (newState == MKAnnotationViewDragStateEnding) {
        MKPointAnnotation *annotation = view.annotation;
        NSLog(@"\nPin Location: %f, %f (Lat, Long)", annotation.coordinate.latitude, annotation.coordinate.longitude);
    }
}

/*
//为覆盖图层提供视图
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKCircle class]]) {
        MKCircleView *view = [[MKCircleView alloc] initWithOverlay:overlay];
        view.lineWidth = 1;
        view.strokeColor = [UIColor blueColor];
        view.fillColor = [[UIColor blueColor]colorWithAlphaComponent:0.5];
        return view;
    } else if ([overlay isKindOfClass:[MKPolygon class]]) {
        MKPolygonView *view = [[MKPolygonView alloc] initWithOverlay:overlay];
        view.lineWidth = 1;
        view.strokeColor = [UIColor blueColor];
        view.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        return view;
    } else if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineView *view = [[MKPolylineView alloc] initWithOverlay:overlay];
        view.lineWidth = 3;
        view.strokeColor = [UIColor blueColor];
        return view;
    }
    return nil;
}
*/

@end
