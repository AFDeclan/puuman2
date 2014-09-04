//
//  AFSelectedButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-15.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFSelectedButton.h"

@implementation AFSelectedButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        mark  =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [mark setBackgroundColor:[UIColor blackColor]];
        [mark setAlpha:0];
        [self addSubview:mark];
    }
    return self;
}


- (void)selectedButton
{
    [mark setAlpha:0.3];
}

- (void)unSelectedButton
{
    [mark setAlpha:0];
}

@end
