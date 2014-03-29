//
//  ChildMenuButton.m
//  puman
//
//  Created by 祁文龙 on 13-11-16.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "SubTypeButton.h"
#import "ColorsAndFonts.h"

@implementation SubTypeButton
@synthesize subIndex;
@synthesize typeIndex;
@synthesize isSelected;
- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)str
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.isSelected = NO;
        title = [[UILabel alloc] initWithFrame:CGRectMake(0, 26, frame.size.width, 16)];
        [title setFont:PMFont3];
        [title setTextColor:[UIColor whiteColor]];
        [title setBackgroundColor:[UIColor clearColor]];
        [title setTextAlignment:NSTextAlignmentCenter];
        [title setText:str];
        [self addSubview:title];
//        selectedEffect = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        
//        [selectedEffect setAlpha:0];
//        [selectedEffect setBackgroundColor:PMColor1];
//        [self addSubview:selectedEffect];
        [self setAdjustsImageWhenHighlighted:NO];
    }
    return self;
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
         [title setTextColor:[UIColor whiteColor]];
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
