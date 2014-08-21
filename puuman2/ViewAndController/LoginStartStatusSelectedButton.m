//
//  LoginStartStatusSelectedButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-15.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "LoginStartStatusSelectedButton.h"
#import "UniverseConstant.h"

@implementation LoginStartStatusSelectedButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [iconView setFrame:CGRectMake(58, 32, 140, 140)];
        [self.title setFrame:CGRectMake(58, 176, 140, 48)];
        [self.title setFont:PMFont2];
        [self.title setTextColor:PMColor1];
        [self.title setBackgroundColor:[UIColor clearColor]];
        
        [self setBackgroundColor:PMColor5];
        [self bringSubviewToFront:self.title];

    }
    return self;
}


@end
