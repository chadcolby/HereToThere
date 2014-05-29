//
//  CCDrawingViewController.m
//  HereToThere
//
//  Created by Chad D Colby on 5/28/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCDrawingViewController.h"

@interface CCDrawingViewController ()


- (IBAction)routeButtonPressed:(id)sender;
- (IBAction)backToMapButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet CCRoundButton *backToMapButton;
@property (weak, nonatomic) IBOutlet CCRoundButton *routeButton;


@end

@implementation CCDrawingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.backToMapButton.alpha = 0.0f;
    self.routeButton.alpha = 0.0f;
    
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


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//
//}


#pragma mark - IBActions

- (IBAction)routeButtonPressed:(id)sender
{
    
}

- (IBAction)backToMapButtonPressed:(id)sender
{
  [self.delegate endDrawingWithNoLine];
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
