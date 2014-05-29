//
//  CCDrawView.h
//  HereToThere
//
//  Created by Chad D Colby on 5/29/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCDrawView : UIView

@property (strong, nonatomic) NSMutableArray *completedLines;
@property (strong, nonatomic) NSMutableDictionary *linesInProgress;

- (void) clearLines;
- (void) drawingDidEnd:(NSSet *)touches;

@end
