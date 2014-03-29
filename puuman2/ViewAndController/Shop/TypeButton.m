//
//  ParentMenuButton.m
//  puman
//
//  Created by 祁文龙 on 13-11-16.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "TypeButton.h"
#import "ColorsAndFonts.h"

@implementation TypeButton
@synthesize typeIndex;
@synthesize state;
@synthesize isSelected;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.isSelected = NO;
        icon = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-24)/2, 12,24, 24)];
        [self addSubview:icon];
        title = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, frame.size.width, 16)];
        [title setBackgroundColor:[UIColor clearColor]];
        [title setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:title];
//        selectedEffect = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        [selectedEffect setAlpha:0];
//        [selectedEffect setBackgroundColor:PMColor1];
//        [self addSubview:selectedEffect];
//        [self setAdjustsImageWhenHighlighted:NO];
    }
    return self;
}


- (void)initWithIconImg:(UIImage *)img andTitle:(NSString *)str andTitleColor:(UIColor *)color andTitleFont:(UIFont *)font
{
    [icon setImage:img];
    [title setFont:font];
    [title setTextColor:color];
    [title setText:str];
    _color = color;
    
}
- (void)selected
{
    [UIView animateWithDuration:0.5 animations:^{
       //  [selectedEffect setAlpha:0.5];
         [title setTextColor:PMColor7];
    }];
   
}
- (void)unSelected
{
    [UIView animateWithDuration:0.5 animations:^{
        // [selectedEffect setAlpha:0];
         [title setTextColor:_color];
    }];
  
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
