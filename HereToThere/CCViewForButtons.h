//
//  CCViewForButtons.h
//  HereToThere
//
//  Created by Chad D Colby on 5/22/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCRoundedButton.h"

@interface CCViewForButtons : UIView

@property (strong, nonatomic) CCRoundedButton *settingsButton;
@property (strong, nonatomic) CCRoundedButton *currentLocationButton;
@property (strong, nonatomic) CCRoundedButton *forwardButton;
@property (strong, nonatomic) CCRoundedButton *routeButton;
@property (strong, nonatomic) CCRoundedButton *closeButton;

- (id)initForDrawingView:(CGRect)frame;
- (void)updateMapViewForRoute;

@end
