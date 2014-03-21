//
//  DetailedViewController.m
//  MapLearing
//
//  Created by 邱扬 on 14-3-21.
//  Copyright (c) 2014年 邱扬. All rights reserved.
//

#import "DetailedViewController.h"

@interface DetailedViewController ()

@end

@implementation DetailedViewController

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
    self.titleLabel.text = self.annotation.title;
    self.subtitleLabel.text = self.annotation.subtitle;
    self.contactInfoLabel.text = self.annotation.contactInformation;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithAnnotation:(MyAnnotation *)annotation {
    self = [super init];
    if (self) {
        self.annotation = annotation;
    }
    return self;
}

@end
