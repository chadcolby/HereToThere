//
//  CCMapViewController.m
//  HereToThere
//
//  Created by Chad D Colby on 5/28/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCMapViewController.h"
#import "CCRoundButton.h"
#import "CCMenuView.h"
#import "CCDrawingViewController.h"

@interface CCMapViewController () <UIGestureRecognizerDelegate, MKMapViewDelegate, DrawingVCDelegate>

@property (strong, nonatomic) CCMenuView *menuView;
@property (weak, nonatomic) IBOutlet CCRoundButton *moreButton;
@property (weak, nonatomic) IBOutlet CCRoundButton *currentLocationButton;

@property (strong, nonatomic) UITapGestureRecognizer *closeMenuTap;
@property (strong, nonatomic) UILongPressGestureRecognizer *longPressToDraw;

@property (strong, nonatomic) CCDrawingViewController *drawableViewController;

@property (strong, nonatomic) MKRoute *returnedRoute;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D mainLocation;
@property (nonatomic) MKCoordinateSpan mapSpan;

- (IBAction)moreButtonPressed:(CCRoundButton *)sender;

@end 

@implementation CCMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initialMapSetUp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - helper methods

- (void)initialMapSetUp
{
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager startUpdatingLocation];
    self.mainLocation = self.locationManager.location.coordinate;
    [self.locationManager stopUpdatingLocation];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self mapViewRegion];
    [self.view addSubview:self.mapView];
    
    [self.view bringSubviewToFront:self.moreButton];
    [self.view bringSubviewToFront:self.currentLocationButton];
    
    self.menuView = [[CCMenuView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height, self.view.
                                                                 bounds.size.width, 100)];
    [self.menuView.directionsButton addTarget:self action:@selector(showDirections:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.menuView];
    self.closeMenuTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeMenu:)];
    self.longPressToDraw = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressForDrawing:)];
    self.longPressToDraw.delegate = self;
    self.longPressToDraw.minimumPressDuration = 0.8f;
    self.longPressToDraw.allowableMovement = 10.0;
    self.longPressToDraw.numberOfTouchesRequired = 1;
    [self.mapView addGestureRecognizer:self.longPressToDraw];
}

- (void)mapViewRegion
{
    if (self.mainLocation.latitude) {
        MKCoordinateRegion mapRegion;
        mapRegion.center.latitude = self.mainLocation.latitude;
        mapRegion.center.longitude = self.mainLocation.longitude;
        self.mapSpan = MKCoordinateSpanMake(0.07, 0.07);
        mapRegion.span = self.mapSpan;
        [self.mapView setRegion:mapRegion];
    }
}

#pragma mark - animations

- (void)showMenuViewAnimated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.4f animations:^{
            self.menuView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height - 100, self.view.bounds.size.width,
                                             100);
            self.moreButton.alpha = 0.5f;
            self.currentLocationButton.alpha = 0.5;
        } completion:^(BOOL finished) {
            self.moreButton.alpha = 0.0f;
            self.currentLocationButton.alpha = 0.0f;
            [self.view addGestureRecognizer:self.closeMenuTap];
        }];
    }
}

- (void)hideDrawingViewController
{
    [self.drawableViewController removeFromParentViewController];
    [self.drawableViewController.view removeFromSuperview];
}

- (void)animateButtonFadeIn
{
    [UIView animateWithDuration:0.4f animations:^{
        self.moreButton.alpha = 1.0f;
        self.currentLocationButton.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - gesture recognizers

- (void)closeMenu:(UITapGestureRecognizer *)sender
{
    [UIView animateWithDuration:0.4f animations:^{
        self.menuView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height, self.view.bounds.size.width,
                                         100);
        self.moreButton.alpha = 1.0f;
        self.currentLocationButton.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [self.view removeGestureRecognizer:self.closeMenuTap];
    }];
    
}

- (void)longPressForDrawing:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.moreButton.alpha = 0.0f;
        self.currentLocationButton.alpha = 0.0f;

        if (!self.drawableViewController) {
            self.drawableViewController = [self createDrawableViewFromStoryboard];
        } else
        {
            [self addChildViewController:self.drawableViewController];
            [self.view addSubview:self.drawableViewController.view];
            [self.drawableViewController didMoveToParentViewController:self];
        }
    }
}

#pragma mark - IBActions

- (IBAction)moreButtonPressed:(CCRoundButton *)sender
{
    [self showMenuViewAnimated:YES];
}

#pragma mark - Menu button methods

- (void)showDirections:(CCRoundButton *)sender
{
    [UIView animateWithDuration:0.4 animations:^{
        self.view.frame = CGRectMake(self.view.bounds.size.width - 107, self.view.bounds.origin.y + 100, 107, 368);
        self.menuView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height - 64.7f, self.view.bounds.size.width,
                                         64.7f);
        self.menuView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.closeMenuTap.enabled = NO;
        [self updateViewConstraints];
    }];
}

#pragma mark - drawable view methods

- (CCDrawingViewController *)createDrawableViewFromStoryboard
{
    CCDrawingViewController *drawViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"routeDrawingVC"];
    [self addChildViewController:drawViewController];
    drawViewController.view.frame = self.view.bounds;
    [self.view addSubview:drawViewController.view];
    [drawViewController didMoveToParentViewController:self];
    drawViewController.delegate = self;
    
    return drawViewController;
}

#pragma mark - DrawingVCDelegateMethods

- (void)endDrawingWithNoLine
{
    [self hideDrawingViewController];
    [self animateButtonFadeIn];
}

- (void)updateMapWithLineForRoute:(CCLine *)finishedLine    //actual addition of route polyline
{
    if (finishedLine) {
        NSLog(@"this is where there would be a route");
    }
    [self hideDrawingViewController];
    [self animateButtonFadeIn];
}

- (void)doThis:(id)sender
{
    [UIView animateWithDuration:0.4 animations:^{
        self.view.frame = [[UIScreen mainScreen] bounds];
        self.moreButton.alpha = 1.0f;
        self.currentLocationButton.alpha = 1.0f;
    } completion:^(BOOL finished) {
        self.closeMenuTap.enabled = YES;
        self.menuView.alpha = 1.0;
        self.menuView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height, self.view.bounds.size.width, 100);
    }];
    
}

@end
