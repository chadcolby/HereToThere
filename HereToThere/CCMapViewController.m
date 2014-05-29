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

@interface CCMapViewController ()

@property (strong, nonatomic) CCMenuView *menuView;
@property (weak, nonatomic) IBOutlet CCRoundButton *moreButton;
@property (weak, nonatomic) IBOutlet CCRoundButton *currentLocationButton;
@property (strong, nonatomic) UITapGestureRecognizer *closeMenuTap;

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
    self.mapView = [[MKMapView alloc] init];
    
    self.menuView = [[CCMenuView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height, self.view.bounds.size.width, 100)];
    [self.view addSubview:self.menuView];
    
    self.closeMenuTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeMenu:)];
}

- (void)showMenuViewAnimated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.4f animations:^{
            self.menuView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height - 100, self.view.bounds.size.width,
                                             self.view.bounds.size.height);
        } completion:^(BOOL finished) {
            self.moreButton.hidden = YES;
            self.currentLocationButton.hidden = YES;
            [self.view addGestureRecognizer:self.closeMenuTap];
        }];
    }
}

- (void)closeMenu:(UITapGestureRecognizer *)sender
{
    [UIView animateWithDuration:0.4f animations:^{
        self.menuView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height, self.view.bounds.size.width,
                                         self.view.bounds.size.height);
    } completion:^(BOOL finished) {
        self.moreButton.hidden = NO;
        self.currentLocationButton.hidden = NO;
        [self.view removeGestureRecognizer:self.closeMenuTap];
    }];
    
}

#pragma mark - IBActions

- (IBAction)moreButtonPressed:(CCRoundButton *)sender
{
    [self showMenuViewAnimated:YES];
}
@end
