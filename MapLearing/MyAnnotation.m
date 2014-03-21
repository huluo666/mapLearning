//
//  MyAnnotation.m
//  MapLearing
//
//  Created by 邱扬 on 14-3-21.
//  Copyright (c) 2014年 邱扬. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coord title:(NSString *)title subtitle:(NSString *)subtitle contactInformation:(NSString *)contactInfo {
    self = [super init];
    if (self) {
        self.coordinate = coord;
        self.title = title;
        self.subtitle = subtitle;
        self.contactInformation = contactInfo;
    }
    return self;
}

@end
