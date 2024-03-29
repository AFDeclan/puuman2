//
//  ShopContentView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ShopContentView.h"
#import "MainTabBarController.h"
#import "UniverseConstant.h"

@implementation ShopContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        [self setScrollEnabled:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
        contentView = [[ShopShowContentView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self addSubview:contentView];
        
       
        
        menuMask = [[UIView alloc] init];
        [menuMask setBackgroundColor:[UIColor clearColor]];
        [self addSubview:menuMask];
        
        menuShowed = NO;
        showAndHiddenBtn = [[ChangePageControlButton alloc] init];
        [showAndHiddenBtn addTarget:self action:@selector(showOrHidden) forControlEvents:UIControlEventTouchUpInside];
        [menuMask addSubview:showAndHiddenBtn];
        [showAndHiddenBtn setIsLeft:YES];
        SetViewLeftUp(showAndHiddenBtn, 256, 452);
        menu  =[[ShopMenuView alloc] initWithFrame:CGRectMake(0, 0, 256, 0)];
        [menuMask addSubview:menu];
        UITapGestureRecognizer *gestureRecognizer= [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
        [gestureRecognizer setDelegate:self];
        [menuMask addGestureRecognizer:gestureRecognizer];
       
      
        
        [MyNotiCenter addObserver:self selector:@selector(fold) name:Noti_HiddenMenu object:nil];
      
        
    }
    return self;
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self restartTimer];
    }else{
        if (_timerToFoldDrawer) {
            [_timerToFoldDrawer invalidate];
            _timerToFoldDrawer = nil;
        }
    }
    return YES;
}

- (void)restartTimer
{
    if (_timerToFoldDrawer) {
        [_timerToFoldDrawer invalidate];
        _timerToFoldDrawer = nil;
    }
    _timerToFoldDrawer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(fold) userInfo:nil repeats:NO];
}


- (void)hiddenMenuWithTapPoint:(CGPoint)pos;
{
    if (menuShowed == YES && !CGRectContainsPoint(menuMask.frame, pos)) {
      [self fold];
    }
    
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
    if ([MainTabBarController sharedMainViewController].isVertical) {
        menuShowed = NO;
        if (_timerToFoldDrawer) {
            [_timerToFoldDrawer invalidate];
            _timerToFoldDrawer = nil;
        }
        [showAndHiddenBtn foldWithDuration:0.5];
        [UIView animateWithDuration:0.5 animations:^{
            SetViewLeftUp(menuMask, -256, 0);
        }];
    }

    
}

- (void)unfold
{
    menuShowed = YES;
    [self restartTimer];
    [showAndHiddenBtn unfoldWithDuration:0.5];
    [UIView animateWithDuration:0.5 animations:^{
        SetViewLeftUp(menuMask, 0, 0);
    }];
}



- (void)setVerticalFrame
{
 
    [contentView setFrame:CGRectMake(0, 0, 608, 944)];
    [contentView setVerticalFrame];
    [menuMask setFrame:CGRectMake(-256, 0, 296, 944)];
    [menu setFrame:CGRectMake(0, 0, 256, 944)];
    [showAndHiddenBtn setAlpha:1];
    [self fold];
    [menu setVerticalFrame];
}

- (void)setHorizontalFrame
{
    [contentView setFrame:CGRectMake(256, 0, 608, 688)];
    [contentView setHorizontalFrame];
    [menuMask setFrame:CGRectMake(0, 0, 256, 688)];
    [showAndHiddenBtn setAlpha:0];
    [menu setFrame:CGRectMake(0, 0, 256, 688)];
    [menu setHorizontalFrame];

    if (_timerToFoldDrawer) {
        [_timerToFoldDrawer invalidate];
        _timerToFoldDrawer = nil;
    }
}

- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}
@end
