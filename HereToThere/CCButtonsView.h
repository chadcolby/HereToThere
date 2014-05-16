//
//  CCButtonsView.h
//  HereToThere
//
//  Created by Chad D Colby on 5/16/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCRoundedMapButton.h"

@interface CCButtonsView : UIView

@property (strong, nonatomic) NSArray *buttonsArray;
@property (strong, nonatomic) NSString *name;
@property (nonatomic) NSInteger tagID;

- (id)initWithFrame:(CGRect)frame andName:(NSString *)viewName andTagID:(NSInteger)tagNumber;

@end
