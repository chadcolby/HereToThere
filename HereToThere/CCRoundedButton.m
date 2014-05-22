//
//  CCRoundedButton.m
//  HereToThere
//
//  Created by Chad D Colby on 5/22/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCRoundedButton.h"

@implementation CCRoundedButton

- (id)initWithOrigin:(CGPoint)origin
{
    CGSize buttonSize = CGSizeMake(50, 50);
    CGRect frame = CGRectMake(origin.x, origin.y, buttonSize.width, buttonSize.height);
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 25.f;
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [[UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeColor"]] CGColor];
        self.layer.borderWidth = 1.5f;
        [self setImage:[UIImage imageNamed:@"edgeColor"] forState:UIControlStateHighlighted];
    }
    return self;
}

@end
