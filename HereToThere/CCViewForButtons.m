//
//  CCViewForButtons.m
//  HereToThere
//
//  Created by Chad D Colby on 5/22/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCViewForButtons.h"

@implementation CCViewForButtons

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self buttonsSetUp];
    }
    return self;
}
- (id)initForDrawingView:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self drawingableViewSetUp];
    }
    
    return self;
}

- (void)buttonsSetUp
{
    self.settingsButton = [[CCRoundedButton alloc]initWithOrigin:CGPointMake((self.bounds.size.width / 2) + 10,
                                                                             self.bounds.origin.y + 20)];
    [self.settingsButton setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
    [self addSubview:self.settingsButton];
    
    self.currentLocationButton = [[CCRoundedButton alloc]initWithOrigin:CGPointMake((self.bounds.size.width / 2) - 60,
                                                                             self.bounds.origin.y + 20)];
    [self.currentLocationButton setImage:[UIImage imageNamed:@"currentLocation"] forState:UIControlStateNormal];
    [self addSubview:self.currentLocationButton];
}

- (void)drawingableViewSetUp
{
    self.forwardButton = [[CCRoundedButton alloc]initWithOrigin:CGPointMake((self.bounds.size.width / 2) - 105,
                                                                             self.bounds.origin.y + 20)];
    [self.forwardButton setImage:[UIImage imageNamed:@"Upload"] forState:UIControlStateNormal];
    [self addSubview:self.forwardButton];
    
    self.routeButton= [[CCRoundedButton alloc]initWithOrigin:CGPointMake((self.bounds.size.width / 2) - 25,
                                                                             self.bounds.origin.y + 20)];
    [self.routeButton setImage:[UIImage imageNamed:@"Map_Path"] forState:UIControlStateNormal];
    [self addSubview:self.routeButton];
    self.routeButton.enabled = NO;
    
    self.closeButton= [[CCRoundedButton alloc]initWithOrigin:CGPointMake((self.bounds.size.width / 2) + 55,
                                                                         self.bounds.origin.y + 20)];
    [self.closeButton setImage:[UIImage imageNamed:@"Multiply"] forState:UIControlStateNormal];
    [self addSubview:self.closeButton];
    
    self.forwardButton.enabled = NO;
}

- (void)updateMapViewForRoute
{
    if (!self.forwardButton) {
        self.forwardButton = [[CCRoundedButton alloc] initWithOrigin:CGPointMake((self.bounds.origin.x + 24) ,
                                                                                 self.bounds.origin.y + 20)];
        [self.forwardButton setImage:[UIImage imageNamed:@"Upload"] forState:UIControlStateNormal];
        [self addSubview:self.forwardButton];

    }
    
    if (!self.stepsButton) {
        self.stepsButton = [[CCRoundedButton alloc] initWithOrigin:CGPointMake((self.bounds.size.width / 2) + 14,
                                                                                 self.bounds.origin.y + 20)];
        [self.stepsButton setImage:[UIImage imageNamed:@"steps"] forState:UIControlStateNormal];
        [self addSubview:self.stepsButton];

    }
    self.settingsButton.center = CGPointMake( self.bounds.size.width - 49, self.bounds.origin.y + 45);

    self.currentLocationButton.center = CGPointMake((self.bounds.size.width / 2) - 39 , self.bounds.origin.y + 45);

    
}
@end
