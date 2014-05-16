//
//  CCButtonsView.m
//  HereToThere
//
//  Created by Chad D Colby on 5/16/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCButtonsView.h"

@implementation CCButtonsView

- (id)initWithFrame:(CGRect)frame andName:(NSString *)viewName andTagID:(NSInteger)tagNumber
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor lightGrayColor];
        //self.alpha = 0.4f;
        self.name = viewName;
        
        self.tagID = tagNumber;
        switch (self.tagID) {
            case 0:
                [self searchMapButtonsView];
                break;
            case 1:
                [self drawableButtonsView];
                break;
            case 2:
                [self mapWithRouteButtonsView];
                break;
            default:
                NSLog(@"No buttons view available");
                break;
        }

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)searchMapButtonsView
{
    CCRoundedMapButton *settingsButton = [[CCRoundedMapButton alloc] initWithOrigin:CGPointMake((self.bounds.size.width / 2) - 70, 10) Name:@"settings" andImageNamed:@"Cog"];
    [self addSubview:settingsButton];
    CCRoundedMapButton *currentLocationButton = [[CCRoundedMapButton alloc] initWithOrigin:CGPointMake(self.bounds.size.width / 2 + 20, 10) Name:@"currentLocation" andImageNamed:@"Location"];
    [self addSubview:currentLocationButton];
    
}

- (void)drawableButtonsView
{
    CCRoundedMapButton *settingsButton = [[CCRoundedMapButton alloc] initWithOrigin:CGPointMake(self.bounds.size.width / 2 - 130, 10) Name:@"settings" andImageNamed:@"Cog"];
    [self addSubview:settingsButton];
    CCRoundedMapButton *currentLocationButton = [[CCRoundedMapButton alloc] initWithOrigin:CGPointMake(self.bounds.size.width / 2 - 30, 10) Name:@"currentLocation" andImageNamed:@"Location"];
    [self addSubview:currentLocationButton];
    CCRoundedMapButton *checkButton = [[CCRoundedMapButton alloc] initWithOrigin:CGPointMake(self.bounds.size.width / 2 + 70, 10) Name:@"check" andImageNamed:@"Checkbox"];
    [self addSubview:checkButton];
    
}

- (void)mapWithRouteButtonsView
{
    
}
@end
