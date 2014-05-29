//
//  CCDrawingViewController.h
//  HereToThere
//
//  Created by Chad D Colby on 5/28/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCRoundButton.h"

@protocol RouteDrawingDelegate <NSObject>

- (void)endDrawingWithNoLine;

@end

@interface CCDrawingViewController : UIViewController

@property (unsafe_unretained) id <RouteDrawingDelegate> delegate;

@end
