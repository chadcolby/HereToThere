//
//  CCViewController.m
//  HereToThere
//
//  Created by Chad D Colby on 5/15/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCViewController.h"
#import "CCRoundedMapButton.h"

@interface CCViewController ()

@end

@implementation CCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CCRoundedMapButton *settingsButton = [[CCRoundedMapButton alloc] initWithOrigin:CGPointMake(self.view.bounds.origin.x + 20, self.view.bounds.size.height - 70) Name:@"Settings"];
    [settingsButton addTarget:self action:@selector(settingsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingsButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)settingsButtonPressed:(CCRoundedMapButton *)sender
{
    NSLog(@"settings");
}

@end
