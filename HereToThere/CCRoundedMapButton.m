//
//  CCRoundedMapButton.m
//  HereToThere
//
//  Created by Chad D Colby on 5/16/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCRoundedMapButton.h"

@implementation CCRoundedMapButton

- (id)initWithOrigin:(CGPoint)buttonOrigin Name:(NSString *)buttonName
{
    CGRect frame = CGRectMake(buttonOrigin.x, buttonOrigin.y, 50, 50);
    self = [super initWithFrame:frame];
    if (self) {
        self.name = buttonName;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 25.f;
        [self setTitle:self.name forState:UIControlStateNormal];
        self.backgroundColor = [UIColor lightGrayColor];
        self.titleLabel.textColor = [UIColor redColor];
        
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
