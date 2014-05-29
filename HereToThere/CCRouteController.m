//
//  CCRouteController.m
//  HereToThere
//
//  Created by Chad D Colby on 5/28/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCRouteController.h"

@interface CCRouteController ()

@property (strong, nonatomic) CLGeocoder *geoCoder;
@property (strong, nonatomic) MKRoute *requestedRoute;

@end

@implementation CCRouteController

+ (CCRouteController *)sharedController
{
    static dispatch_once_t pred;
    static CCRouteController *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[CCRouteController alloc] init];
    });
    
    return shared;
}

@end
