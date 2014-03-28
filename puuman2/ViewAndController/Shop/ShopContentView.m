//
//  ShopContentView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ShopContentView.h"
#import "MainTabBarController.h"

@implementation ShopContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setScrollEnabled:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
        
        menuMask = [[UIView alloc] init];
        [menuMask setBackgroundColor:[UIColor clearColor]];
        [self addSubview:menuMask];
        
        showAndHiddenBtn = [[BabyInfoPageControlButton alloc] init];
        [showAndHiddenBtn addTarget:self action:@selector(showOrHidden) forControlEvents:UIControlEventTouchUpInside];
        [menuMask addSubview:showAndHiddenBtn];
        
        menu  =[[ShopMenuView alloc] initWithFrame:CGRectMake(0, 0, 216, 0)];
        [menuMask addSubview:menu];
        
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


- (void)goToAllShop
{
    if (!allView) {
        allView = [[AllWareView alloc] initWithFrame:CGRectMake(80, 80, 0, 0)];
        
        [self addSubview:allView];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
    }
    
    [allView setAlpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        [allView setAlpha:1];
        if (rectView) {
            [rectView setAlpha:0];
            
        }
        
    }];

}

- (void)goToRectShop
{
    if (!rectView) {
        rectView = [[RectWareView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self addSubview:rectView];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
    }
    
    [rectView setAlpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        [rectView setAlpha:1];
        if (allView) {
            [allView setAlpha:0];
            
        }
        
    }];

}

- (void)setVerticalFrame
{
    [menuMask setFrame:CGRectMake(0, 0, 256, 944)];
    [menu setFrame:CGRectMake(0, 0, 216, 944)];
    [showAndHiddenBtn setAlpha:1];
    [menu setVerticalFrame];
    if (rectView) {
        [rectView setFrame:CGRectMake(0, 0, 608, 944)];
        [rectView setVerticalFrame];
    }
    
    if (allView) {
        [allView setFrame:CGRectMake(0, 0, 608, 944)];
        [allView setVerticalFrame];
    }
}

- (void)setHorizontalFrame
{
    [menuMask setFrame:CGRectMake(0, 0, 216, 688)];
    [showAndHiddenBtn setAlpha:0];
    [menu setFrame:CGRectMake(0, 0, 216, 688)];
    [menu setHorizontalFrame];
    if (rectView) {
        [rectView setFrame:CGRectMake(216, 0, 648, 688)];
        [rectView setHorizontalFrame];
    }
    
    if (allView) {
        [allView setFrame:CGRectMake(216, 0, 648, 688)];
        [allView setHorizontalFrame];
    }
}

@end
