//
//  CCMapViewController.m
//  HereToThere
//
//  Created by Chad D Colby on 5/16/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCMapViewController.h"
#import "CCViewForButtons.h"
#import "CCDrawableView.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CCMapViewController ()

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) CCViewForButtons *buttonsView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CCDrawableView *drawingView;

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)initialSetUp
{
    self.navigationController.navigationBarHidden = YES;
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager startUpdatingLocation];

    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.mapView.showsUserLocation = YES;
    
    MKCoordinateRegion region;
    region.center.latitude = self.locationManager.location.coordinate.latitude;
    region.center.longitude = self.locationManager.location.coordinate.longitude;
    region.span = MKCoordinateSpanMake(0.05, 0.05);
    [self.mapView setRegion:region];

    [self.view addSubview:self.mapView];
    [self.locationManager stopUpdatingLocation];
    
    self.buttonsView = [[CCViewForButtons alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 80,
                                                                          self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.mapView addSubview:self.buttonsView];
    
    [self.buttonsView.settingsButton addTarget:self action:@selector(settingsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonsView.currentLocationButton addTarget:self action:@selector(currentLocationButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.drawingView = [[CCDrawableView alloc] initWithFrame:self.view.bounds];
    self.drawingView.hidden = YES;
    [self.view addSubview:self.drawingView];
    
    UILongPressGestureRecognizer *longPressForDrawing = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(drawRouteLine:)];
    longPressForDrawing.minimumPressDuration = 0.8f;
    longPressForDrawing.allowableMovement = 10.0;
    longPressForDrawing.numberOfTouchesRequired = 1;
    [self.mapView addGestureRecognizer:longPressForDrawing];
    
}



#pragma mark - Bottom buttons methods

- (void)settingsButtonPressed:(CCRoundedButton *)sender
{

    [self performSegueWithIdentifier:@"pushToSettings" sender:self.buttonsView.settingsButton];
    self.navigationController.navigationBarHidden = NO;
}

- (void)currentLocationButtonPressed:(CCRoundedButton *)sender
{

    
}

#pragma mark - Gesture Recognizer methods

- (void)drawRouteLine:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.drawingView.hidden = NO;
    }
}
@end
