//
//  BabyInfoContentView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-13.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoContentView.h"

@implementation BabyInfoContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        rightView = [[UIView alloc] init];
        [rightView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:rightView];
        leftView = [[UIView alloc] init];
        [leftView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:leftView];
        [self setScrollEnabled:NO];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        showAndHiddenBtn = [[BabyInfoPageControlButton alloc] init];
        [showAndHiddenBtn addTarget:self action:@selector(showOrHidden) forControlEvents:UIControlEventTouchUpInside];
        [leftView addSubview:showAndHiddenBtn];
        
    }
    return self;
}

- (void)showOrHidden
{
    if (showAndHiddenBtn.isFold) {
        [self unfold];
    }else{
        [self fold];
    }
}

- (void)fold
{
    [showAndHiddenBtn foldWithDuration:0.5];
    
  
    
}

- (void)unfold
{
    [showAndHiddenBtn unfoldWithDuration:0.5];
  
}

-(void)setVerticalFrame
{
    
    [self setFrame:CGRectMake(80, 176, 608, 848)];
    [rightView setFrame:CGRectMake(0, 0, 608, 848)];
}

-(void)setHorizontalFrame
{
    [self setFrame:CGRectMake(80, 176, 864, 592)];
    [rightView setFrame:CGRectMake(0, 0, 864, 592)];
}


@end
