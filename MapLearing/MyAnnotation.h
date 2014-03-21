//
//  MyAnnotation.h
//  MapLearing
//
//  Created by 邱扬 on 14-3-21.
//  Copyright (c) 2014年 邱扬. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MyAnnotation : MKPointAnnotation

@property (nonatomic, strong) NSString *contactInformation;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coord title:(NSString *)title subtitle:(NSString*)subtitle contactInformation:(NSString *)contactInfo;

@end
