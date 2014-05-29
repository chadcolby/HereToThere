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
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.mapView];
    
    [self.view bringSubviewToFront:self.moreButton];
    [self.view bringSubviewToFront:self.currentLocationButton];
    
    self.menuView = [[CCMenuView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height, self.view.
                                                                 bounds.size.width, 100)];
    [self.view addSubview:self.menuView];
    self.closeMenuTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeMenu:)];
    
    self.longPressToDraw = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressForDrawing:)];
    self.longPressToDraw.delegate = self;
    self.longPressToDraw.minimumPressDuration = 0.8f;
    self.longPressToDraw.allowableMovement = 10.0;
    self.longPressToDraw.numberOfTouchesRequired = 1;
    [self.mapView addGestureRecognizer:self.longPressToDraw];
}

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
                                         self.view.bounds.size.height);
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

- (void)updateMapWithLineForRoute:(CCLine *)finishedLine
{
    if (finishedLine) {
        NSLog(@"line recieved: %f and %f", finishedLine.endPoint.x, finishedLine.endPoint.y);
    }
    [self hideDrawingViewController];
    [self animateButtonFadeIn];
}
@end
