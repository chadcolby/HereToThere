//
//  CCDrawingViewController.m
//  HereToThere
//
//  Created by Chad D Colby on 5/28/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCDrawingViewController.h"
#import "CCDrawView.h"

@interface CCDrawingViewController ()


- (IBAction)routeButtonPressed:(id)sender;
- (IBAction)backToMapButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet CCRoundButton *backToMapButton;
@property (weak, nonatomic) IBOutlet CCRoundButton *routeButton;
@property (strong, nonatomic) CCDrawView *drawView;

@end

@implementation CCDrawingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initialSetUp];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self easeButtonsIn];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self easeButtonsOut];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)initialSetUp
{
    self.drawView = (CCDrawView *)self.view;
    self.backToMapButton.alpha = 0.0f;
    self.routeButton.alpha = 0.0f;
    
}

#pragma mark - IBActions

- (IBAction)routeButtonPressed:(id)sender
{
    
}

- (IBAction)backToMapButtonPressed:(id)sender
{
    [self.delegate endDrawingWithNoLine];
    [self.drawView clearLines];
}

#pragma mark - Animations

- (void)easeButtonsIn
{
    [UIView animateWithDuration:0.4f animations:^{
        self.backToMapButton.alpha = 1.0f;
        self.routeButton.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)easeButtonsOut
{
    [UIView animateWithDuration:0.4f animations:^{
        self.backToMapButton.alpha = 0.0f;
        self.routeButton.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
    }];
}
@end
