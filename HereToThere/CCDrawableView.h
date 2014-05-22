//
//  CCDrawableView.h
//  HereToThere
//
//  Created by Chad D Colby on 5/22/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCLine.h"

@protocol RouteLineDrawingDelegate <NSObject>

- (void)drawingViewClosedWithoutRoute;

@end

@interface CCDrawableView : UIView

@property (unsafe_unretained) id <RouteLineDrawingDelegate> delegate;

@property (strong, nonatomic) CCLine *line;

@property (strong, nonatomic) NSMutableArray *completedLines;
@property (strong, nonatomic) NSMutableDictionary *linesInProgress;

- (void)theEndOfDrawing:(NSSet *)touches;
- (void)clearAllLines;

@end
