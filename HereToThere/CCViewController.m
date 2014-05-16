//
//  CCViewController.m
//  HereToThere
//
//  Created by Chad D Colby on 5/15/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCViewController.h"
#import "CCButtonsView.h"

@interface CCViewController ()

@property (strong, nonatomic) CCButtonsView *mapButtonsView;
@property (strong, nonatomic) CCButtonsView *drawableButtonsView;

@end

@implementation CCViewController

- (void)viewDidLoad
{
    self.mapButtonsView = [[CCButtonsView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height - 80,
                                                                self.view.bounds.size.width, self.view.bounds.size.height)
                                                                 andName:@"mapButtonsView" andTagID:0];
    self.drawableButtonsView = [[CCButtonsView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height - 80,
                                                                                                                        self.view.bounds.size.width, self.view.bounds.size.height)
                                                                                                     andName:@"drawableView" andTagID:1];

    self.drawableButtonsView.hidden = YES;
    [self.view addSubview:self.mapButtonsView];
    [self.view addSubview:self.drawableButtonsView];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    longPress.minimumPressDuration = 0.75;
    longPress.numberOfTouchesRequired = 1;
    longPress.allowableMovement = 15.0;
    [self.view addGestureRecognizer:longPress];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)longPressed:(UILongPressGestureRecognizer *)sender
{
    NSLog(@"press");
    if (self.drawableButtonsView.hidden) {
        self.drawableButtonsView.hidden = NO;
        self.mapButtonsView.hidden = YES;
    } else {
        self.mapButtonsView.hidden = NO;
        self.drawableButtonsView.hidden = YES;
    }


    
}

@end
