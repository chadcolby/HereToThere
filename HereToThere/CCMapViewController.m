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
}

#pragma mark - IBActions

- (IBAction)moreButtonPressed:(CCRoundButton *)sender
{
    
}
@end
