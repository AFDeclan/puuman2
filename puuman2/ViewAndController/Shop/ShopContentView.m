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
        
        rectView = [[RectWareView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self addSubview:rectView];
        allView = [[AllWareView alloc] initWithFrame:CGRectMake(80, 80, 0, 0)];
        [allView setAlpha:0];
        [self addSubview:allView];
        
        menuMask = [[UIView alloc] init];
        [menuMask setBackgroundColor:[UIColor clearColor]];
        [self addSubview:menuMask];
        menuShowed = NO;
        showAndHiddenBtn = [[BabyInfoPageControlButton alloc] init];
        [showAndHiddenBtn addTarget:self action:@selector(showOrHidden) forControlEvents:UIControlEventTouchUpInside];
        [menuMask addSubview:showAndHiddenBtn];
        SetViewLeftUp(showAndHiddenBtn, 216, 452);
        menu  =[[ShopMenuView alloc] initWithFrame:CGRectMake(0, 0, 216, 0)];
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
            SetViewLeftUp(menuMask, -216, 0);
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


- (void)goToAllShop
{
   

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

    [ShopModel sharedInstance].sectionIndex = -1;
    [ShopModel sharedInstance].subClassIndex = -1;
    PostNotification(Noti_RefreshMenu, nil);
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
    [menuMask setFrame:CGRectMake(-216, 0, 256, 944)];
    [menu setFrame:CGRectMake(0, 0, 216, 944)];
    [showAndHiddenBtn setAlpha:1];
    [self fold];
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
    if (_timerToFoldDrawer) {
        [_timerToFoldDrawer invalidate];
        _timerToFoldDrawer = nil;
    }
}

@end
