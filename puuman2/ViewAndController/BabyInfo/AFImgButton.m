//
//  AFImgButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-12.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFImgButton.h"

@implementation AFImgButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization codes
        [self setAdjustsImageWhenDisabled:NO];
    }
    return self;
}

- (id)init
{

    return  [self initWithFrame:CGRectMake(0, 0, 64, 96)];
}

- (void)setSelectedImg:(UIImage *)imgOne andUnselectedImg:(UIImage *)imgTwo;
{
    selectedImg = imgOne;
    unSelectedImg = imgTwo;
    
}

- (void)selected
{
    [self setEnabled:NO];
    [self setImage:selectedImg forState:UIControlStateNormal];
}

- (void)unSelected
{
    [self setEnabled:YES];
    [self setImage:unSelectedImg forState:UIControlStateNormal];
}

@end
