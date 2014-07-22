//
//  AFSelectedTextImgButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFSelectedTextImgButton.h"
#import "UniverseConstant.h"

@implementation AFSelectedTextImgButton
@synthesize selectedImg = _selectedImg;
@synthesize selectedColor = _selectedColor;
@synthesize unSelectedColor= _unSelectedColor;
@synthesize unSelectedImg = _unSelectedImg;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.adjustsImageWhenDisabled = NO;
        
        
    }
    return self;
}

- (void)setSelectedImg:(UIImage *)selectedImg
{
    _selectedImg = selectedImg;
    [self setIconImg:_selectedImg];
}

- (void)setUnSelectedImg:(UIImage *)unSelectedImg
{
    _unSelectedImg = unSelectedImg;
    [self setIconImg:_unSelectedImg];

}


- (void)selected
{
    self.enabled = NO;
    [self setIconImg:_selectedImg];
    [self.title setTextColor:_selectedColor];
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)unSelected
{
    self.enabled = YES;
    [self setIconImg:_unSelectedImg];
    [self.title setTextColor:_unSelectedColor];
    [self setBackgroundColor:[UIColor clearColor]];

}

@end
