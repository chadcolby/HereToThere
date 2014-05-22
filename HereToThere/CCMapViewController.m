//
//  CCMapViewController.m
//  HereToThere
//
//  Created by Chad D Colby on 5/16/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCMapViewController.h"
#import "CCViewForButtons.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CCMapViewController ()

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) CCViewForButtons *buttonsView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation CCMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialSetUp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)initialSetUp
{
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.mapView];
    
    self.buttonsView = [[CCViewForButtons alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 80,
                                                                          self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.mapView addSubview:self.buttonsView];
}

@end
