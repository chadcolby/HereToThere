//
//  CCRoundButton.m
//  HereToThere
//
//  Created by Chad D Colby on 5/28/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCRoundButton.h"

@implementation CCRoundButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 25.0f;
//        self.layer.borderColor = [[UIColor whiteColor] CGColor];
//        self.layer.borderWidth = 1.0;

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.clipsToBounds = YES;
//        self.layer.cornerRadius = 25.0f;
    }
    
    return self;
}

/*
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
