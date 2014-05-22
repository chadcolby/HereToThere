//
//  CCDrawableView.h
//  HereToThere
//
//  Created by Chad D Colby on 5/22/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCLine.h"

@interface CCDrawableView : UIView

@property (strong, nonatomic) CCLine *line;

@property (strong, nonatomic) NSMutableArray *completedLines;
@property (strong, nonatomic) NSMutableDictionary *linesInProgress;

- (void)theEndOfDrawing:(NSSet *)touches;
- (void)clearAllLines;

@end
