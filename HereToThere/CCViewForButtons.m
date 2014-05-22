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

- (void)buttonsSetUp
{
    self.settingsButton = [[CCRoundedButton alloc]initWithOrigin:CGPointMake((self.bounds.size.width / 2) - 60,
                                                                             self.bounds.origin.y + 20)];
    [self.settingsButton setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
    [self addSubview:self.settingsButton];
    
    self.currentLocationButton = [[CCRoundedButton alloc]initWithOrigin:CGPointMake((self.bounds.size.width / 2) + 10,
                                                                             self.bounds.origin.y + 20)];
    [self.currentLocationButton setImage:[UIImage imageNamed:@"currentLocation"] forState:UIControlStateNormal];
    [self addSubview:self.currentLocationButton];
}
@end
