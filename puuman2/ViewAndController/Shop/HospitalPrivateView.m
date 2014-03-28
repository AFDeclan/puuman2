//
//  HospitalPrivateView.m
//  puman
//
//  Created by 祁文龙 on 13-12-3.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "HospitalPrivateView.h"
#import "ColorsAndFonts.h"

@implementation HospitalPrivateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}
- (void)initialization
{
    [self setContentSize:CGSizeMake(742, 360)];
    [self setScrollEnabled:NO];
    [self setShowsHorizontalScrollIndicator:NO];
    [self setShowsVerticalScrollIndicator:NO];
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 742, 360)];
    [bgImg setImage:[UIImage imageNamed:@"pic6_insure_shop.png"]];
    [self addSubview:bgImg];
    
    sheep  = [[UIImageView alloc] initWithFrame:CGRectMake(742, 59, 279, 301)];
    [sheep setImage:[UIImage imageNamed:@"sheep_insure_shop.png"]];
    [self addSubview:sheep];
    
    tellImg =[[UIImageView alloc] initWithFrame:CGRectMake(280, 110, 173, 163)];
    [tellImg setImage:[UIImage imageNamed:@"bubble_insure_shop.png"]];
    [tellImg setAlpha:0];
    [self addSubview:tellImg];

    UILabel *numLabel  = [[UILabel alloc] initWithFrame:CGRectMake(45, 79, 56, 24)];
    [numLabel setNumberOfLines:1];
    [numLabel setTextColor:PMColor1];
    [numLabel setTextAlignment:NSTextAlignmentCenter];
    [numLabel setFont:PMFont1];
    [numLabel setText:[NSString stringWithFormat:@"%d",rand()%1000+2000]];
    [tellImg addSubview:numLabel];
    [numLabel setBackgroundColor:[UIColor clearColor]];
    [self performSelector:@selector(goIn) withObject:nil afterDelay:1];
    
    
    
}
- (void)goIn
{
    [UIView animateWithDuration:2 animations:^{
            [self setContentOffset:CGPointMake(102, 0)];
        
    }];
    [UIView animateWithDuration:3 animations:^{
         [sheep setFrame:CGRectMake(463, 59, 279, 301)];
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            [tellImg setAlpha:1];
        }];
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
