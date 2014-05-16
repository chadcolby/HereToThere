//
//  CCRoundedMapButton.h
//  HereToThere
//
//  Created by Chad D Colby on 5/16/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCRoundedMapButton : UIButton

@property (strong, nonatomic) NSString *name;

- (id)initWithOrigin:(CGPoint)buttonOrigin Name:(NSString *)buttonName;

@end
