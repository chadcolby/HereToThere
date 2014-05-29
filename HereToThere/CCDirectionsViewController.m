//
//  CCDirectionsViewController.m
//  HereToThere
//
//  Created by Chad D Colby on 5/28/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCDirectionsViewController.h"

@interface CCDirectionsViewController ()

- (IBAction)doneButtonPressed:(id)sender;

@end

@implementation CCDirectionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self mapViewSetUp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)mapViewSetUp
{
    self.mapViewVC = [self.storyboard instantiateViewControllerWithIdentifier:@"mapViewController"];
    [self addChildViewController:self.mapViewVC];
    
    self.mapViewVC.view.frame = self.view.frame;
    [self.view addSubview:self.mapViewVC.view];
    [self.mapViewVC didMoveToParentViewController:self];
}

- (IBAction)doneButtonPressed:(id)sender
{
    [self.mapViewVC performSelectorOnMainThread:@selector(doThis:) withObject:nil waitUntilDone:NO];
}
@end
