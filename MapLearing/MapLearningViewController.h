//
//  MapLearningViewController.h
//  MapLearing
//
//  Created by 邱扬 on 14-3-20.
//  Copyright (c) 2014年 邱扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
//#import <CoreLocation/CoreLocation.h>

@interface MapLearningViewController : UIViewController<MKMapViewDelegate> {
    CLGeocoder *_geocoder;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *userLocationLabel;
@property (weak, nonatomic) IBOutlet UIToolbar *mapToolbar;

@end
