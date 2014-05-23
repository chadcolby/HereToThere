//
//  CCPinAnnotation.m
//  HereToThere
//
//  Created by Chad D Colby on 5/23/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCPinAnnotation.h"

@implementation CCPinAnnotation

@synthesize coordinate;

- (instancetype)initWithPoint:(CLLocationCoordinate2D)coord
{
    self = [super init];
    if (self) {
        coordinate = coord;
    }
    
    return self;
}

@end
