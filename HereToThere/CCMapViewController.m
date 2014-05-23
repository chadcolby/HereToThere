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

@interface CCMapViewController () <RouteLineDrawingDelegate, MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) CCViewForButtons *buttonsView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CCDrawableView *drawingView;

@property (nonatomic) CLLocationCoordinate2D starCoord;
@property (nonatomic) CLLocationCoordinate2D endCoord;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) MKPlacemark *endPlacemark;
@property (strong, nonatomic) MKRoute *routeDetails;

@property (strong, nonatomic) NSOperationQueue *drawingQueue;

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
    self.mapView.delegate = self;
    
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

    
    UILongPressGestureRecognizer *longPressForDrawing = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(drawRouteLine:)];
    longPressForDrawing.minimumPressDuration = 0.8f;
    longPressForDrawing.allowableMovement = 10.0;
    longPressForDrawing.numberOfTouchesRequired = 1;
    [self.mapView addGestureRecognizer:longPressForDrawing];
    
    self.drawingQueue = [[NSOperationQueue alloc] init];
    [self.drawingQueue addOperationWithBlock:^{
        self.drawingView = [[CCDrawableView alloc] initWithFrame:self.view.bounds];
        self.drawingView.hidden = YES;
        [self.view addSubview:self.drawingView];
        self.drawingView.delegate = self;
        
    }];
    

    
}



#pragma mark - Bottom buttons methods

- (void)settingsButtonPressed:(CCRoundedButton *)sender
{

    [self performSegueWithIdentifier:@"pushToSettings" sender:self.buttonsView.settingsButton];
    self.navigationController.navigationBarHidden = NO;
}

- (void)currentLocationButtonPressed:(CCRoundedButton *)sender
{
//    self.mapView.centerCoordinate = self.locationManager.location.coordinate;
    MKCoordinateRegion locationCenteredRegion;
    locationCenteredRegion.center.latitude = self.locationManager.location.coordinate.latitude;
    locationCenteredRegion.center.longitude = self.locationManager.location.coordinate.longitude;
    locationCenteredRegion.span = self.mapView.region.span;
    [self.mapView setRegion:locationCenteredRegion animated:YES];
    
}

#pragma mark - Gesture Recognizer methods

- (void)drawRouteLine:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.drawingView.hidden = NO;
        self.buttonsView.hidden = YES;
        self.drawingView.buttonsView.routeButton.enabled = NO;
    }
}

#pragma mark - RouteLineDrawingDelegate methods

- (void)drawingViewClosedWithoutRoute
{
    self.drawingView.hidden = YES;
    self.buttonsView.hidden = NO;
}

- (void)mapPointsFromDrawnLine:(CCLine *)line
{
    NSLog(@"i have coordinates");
    self.starCoord = [self.mapView convertPoint:line.startPoint toCoordinateFromView:self.mapView];
    self.endCoord = [self.mapView convertPoint:line.endPoint toCoordinateFromView:self.mapView];
    self.drawingView.buttonsView.routeButton.enabled = YES;

}

- (void)routeFromDrawnLine
{
    if (!self.geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }

    CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:self.endCoord.latitude longitude:self.endCoord.longitude];
    //CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:self.startCoordinate.latitude longitude:self.startCoordinate.longitude];
    [self.geocoder reverseGeocodeLocation:endLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            self.endPlacemark = [[MKPlacemark alloc] initWithPlacemark:[placemarks lastObject]];
            MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc] init];
            [directionsRequest setSource:[MKMapItem mapItemForCurrentLocation]];
            [directionsRequest setDestination:[[MKMapItem alloc] initWithPlacemark:self.endPlacemark]];
            directionsRequest.transportType = MKDirectionsTransportTypeAutomobile;
            MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
            [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
                if (error) {
                    NSLog(@"Error >> %@", error.description);
                } else {
                    self.routeDetails = response.routes.lastObject;
                    [self.mapView addOverlay:self.routeDetails.polyline];
                    self.buttonsView.hidden = NO;
                }
            }];
        }
    }];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *routeLineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:self.routeDetails.polyline];
    routeLineRenderer.strokeColor = [UIColor colorWithRed:23.f/255 green:20.f/255 blue:70.f/255 alpha:1.f];
    routeLineRenderer.lineWidth = 3;
    return routeLineRenderer;
}

#pragma mark - MapViewDelegate methods


@end
