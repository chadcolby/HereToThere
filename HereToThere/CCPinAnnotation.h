//
//  CCPinAnnotation.h
//  HereToThere
//
//  Created by Chad D Colby on 5/23/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CCPinAnnotation : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (instancetype)initWithPoint:(CLLocationCoordinate2D)coord;

@end
