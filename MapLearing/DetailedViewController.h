//
//  DetailedViewController.h
//  MapLearing
//
//  Created by 邱扬 on 14-3-21.
//  Copyright (c) 2014年 邱扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAnnotation.h"

@interface DetailedViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactInfoLabel;

@property (strong, nonatomic) MyAnnotation *annotation;

- (id)initWithAnnotation:(MyAnnotation *)annotation;

@end
