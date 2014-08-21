//
//  AFSelectedImgButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-15.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFSelectedImgButton.h"

@implementation AFSelectedImgButton
@synthesize selectedImg = _selectedImg;
@synthesize unSelectedImg = _unSelectedImg;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        self.adjustsImageWhenDisabled = NO;

    }
    return self;
}

- (void)selected
{
    self.enabled = NO;
    [self setImage:_selectedImg forState:UIControlStateNormal];
}

- (void)unSelected
{
    self.enabled = YES;
    [self setImage:_unSelectedImg forState:UIControlStateNormal];

    
}

@end
