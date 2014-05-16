//
//  CCRoundedMapButton.m
//  HereToThere
//
//  Created by Chad D Colby on 5/16/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCRoundedMapButton.h"

@implementation CCRoundedMapButton

- (id)initWithOrigin:(CGPoint)buttonOrigin Name:(NSString *)buttonName andImageNamed:(NSString *)imageName
{
    CGRect frame = CGRectMake(buttonOrigin.x, buttonOrigin.y, 60, 60);
    self = [super initWithFrame:frame];
    if (self) {
        self.name = buttonName;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 30.f;
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [[UIColor colorWithRed:23/255 green:20/255 blue:70/255 alpha:1.f] CGColor];
        self.layer.borderWidth = 3.0;

        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"Checkbox"] forState:UIControlStateHighlighted];
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

@end
