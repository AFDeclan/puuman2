//
//  BabyShowView.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-21.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "BabyShowButton.h"
#import "UserInfo.h"
#import "UniverseConstant.h"
#import "MainTabBarController.h"

@implementation BabyShowButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectMake(0, 0, 216, 80)];
}

- (void)initialization
{
    [self initPuumanView];
    [self initBabyButton];
}

- (void)initPuumanView
{
    coin_num = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 128, 32)];
    [coin_num setBackgroundColor:[UIColor clearColor]];
    [coin_num setTextAlignment:NSTextAlignmentRight];
    [coin_num setTextColor:[UIColor whiteColor]];
    [coin_num setFont:PMFont1];
    [self addSubview:coin_num];
    
    coin_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, 128, 24)];
    [coin_label setBackgroundColor:[UIColor clearColor]];
    [coin_label setTextAlignment:NSTextAlignmentRight];
    [coin_label setTextColor:[UIColor whiteColor]];
    [coin_label setFont:PMFont2];
    [coin_label setText:@"金币"];
    [self addSubview:coin_label];
    [MyNotiCenter addObserver:self selector:@selector(updatePuumanData) name:Noti_UpdatePuumanShow object:nil];
}

- (void)initBabyButton
{
    status = PuumanAnimateNone;
    
    bg_babybutton = [[UIImageView alloc ]initWithFrame:CGRectMake(136, 0, 80, 80)];
    [bg_babybutton setImage:[UIImage imageNamed:@"icon_babyInfo_btn.png"] ];
    [self addSubview:bg_babybutton];
    
    portraitView =[[AFImageView alloc] initWithFrame:CGRectMake(144, 8, 64, 64)];
    [portraitView setContentMode:UIViewContentModeScaleAspectFill];
    [portraitView setBackgroundColor:[UIColor clearColor]];
    portraitView.layer.cornerRadius = 32.5f;
    portraitView.layer.masksToBounds = YES;
    portraitView.layer.shadowRadius =0.1;
    [self addSubview:portraitView];
    [self loadAnimateView];

    babyInfoBtn = [[UIButton alloc ]initWithFrame:CGRectMake(136, 0, 80, 80)];
    [babyInfoBtn addTarget:self action:@selector(showBabyView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:babyInfoBtn];

    [MyNotiCenter addObserver:self selector:@selector(addPuuman:) name:Noti_AddCorns object:nil];

}

- (void)showBabyView
{
   // [self addPuuman:nil];
    [[MainTabBarController sharedMainViewController] showBabyView];
}


- (void)loadAnimateView
{
    animateView = [[PuumanButtonAnimateView alloc]initWithFrame:CGRectMake(144,8 , 64, 64)];
    [animateView setBackgroundColor:[UIColor clearColor]];
    //[animateView setFillColor:[UIColor colorWithRed:16./255 green:119./255 blue:234./255 alpha:1.0f]];
    [animateView setFillColor:[UIColor orangeColor]];
    [animateView setStrokeColor:[UIColor colorWithRed:16./255 green:119./255 blue:234./255 alpha:1.0f]];
    animateView.radiusPercent = 0.5 ;
    [self addSubview:animateView];
    [animateView setDelegate:self];
    [animateView loadIndicator];
    showLabel = [[UILabel alloc] initWithFrame:CGRectMake(144, 8, 64, 64)];
    [showLabel setBackgroundColor:[UIColor clearColor]];
    [showLabel setTextAlignment:NSTextAlignmentCenter];
    [showLabel setTextColor:[UIColor whiteColor]];
    [showLabel setFont:PMFont2];
    [showLabel setAlpha:0];
    [self addSubview:showLabel];
    
}


- (void)showAnimation
{
    [showLabel setAlpha:1];
    
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    fadeAnimation.toValue = [NSNumber numberWithFloat:1.0];
    fadeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    fadeAnimation.duration = 0.5;
    [fadeAnimation setDelegate:self];
    [showLabel.layer addAnimation:fadeAnimation forKey:@"opacity"];

    
    CABasicAnimation *scaleAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    scaleAnimation1.toValue = [NSNumber numberWithFloat:1.15];
    scaleAnimation1.duration = 0.2;
    [scaleAnimation1 setBeginTime:0];
    scaleAnimation1.removedOnCompletion = NO;
    scaleAnimation1.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *scaleAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    scaleAnimation2.toValue = [NSNumber numberWithFloat:1];
    scaleAnimation2.duration = 0.1;
    [scaleAnimation2 setBeginTime:0.2];
    scaleAnimation2.removedOnCompletion = NO;
    scaleAnimation2.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *scaleAnimation3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    scaleAnimation3.toValue = [NSNumber numberWithFloat:1.1];
    scaleAnimation3.duration = 0.1;
    [scaleAnimation3 setBeginTime:0.3];
    scaleAnimation3.removedOnCompletion = NO;
    scaleAnimation3.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *scaleAnimation4 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation4.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    scaleAnimation4.toValue = [NSNumber numberWithFloat:1];
    scaleAnimation4.duration = 0.1;
    [scaleAnimation4 setBeginTime:0.4];
    scaleAnimation4.removedOnCompletion = NO;
    scaleAnimation4.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup*group = [CAAnimationGroup animation];
    [group  setDuration:0.5];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [group setAnimations:[NSArray arrayWithObjects:scaleAnimation1,scaleAnimation2, scaleAnimation3,scaleAnimation4, nil]];
    [showLabel.layer addAnimation:group forKey:@"group"];

}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    PostNotification(Noti_UpdatePuumanShow, nil);
    if ([anim isKindOfClass:[CABasicAnimation class]]) {
        if (flag) {
            [self animateFinished];
        }
    }
}

- (void)addAnimation
{
    [animateView updateWithTotalBytes:100 downloadedBytes:100];

}

- (void)minusAnimation
{
    [animateView updateWithTotalBytes:100 downloadedBytes:0];
    [UIView animateWithDuration:2 animations:^{
        [showLabel setAlpha:0];
    }completion:^(BOOL finished) {
        
    }];
}


- (void)animateFinished
{
    switch (status) {
        case PuumanAnimateAdd:
        {
            status = PuumanAnimateShow;
            [self showAnimation];
            return;
        }
        case PuumanAnimateShow:
        {
            status = PuumanAnimateMinus;
            [self minusAnimation];
            return;
        }
        case PuumanAnimateMinus:
        {
            status = PuumanAnimateNone;
            return;
        }
        case PuumanAnimateNone:
            break;
        default:
            break;
    }
}

- (void)addPuuman:(NSNotification *)notification
{
    float addCoins = [[notification object] floatValue];
    
    if (addCoins > 0) {
        [showLabel setText:[NSString stringWithFormat:@"+%0.1f",addCoins]];
        [self addPuuman];
    }else{
        [showLabel setText:[NSString stringWithFormat:@"%0.1f",addCoins]];
        [self addPuuman];
    }
}

- (void)addPuuman
{
    if (status == PuumanAnimateNone) {
        status = PuumanAnimateAdd;
        [self addAnimation];
    }
}
- (void)minusPuuman
{

    if (status == PuumanAnimateNone) {
        status = PuumanAnimateMinus;
        [self minusAnimation];
    }
}

- (void)loadData
{
    [self updatePuumanData];
    [self loadPortrait];
}

-(void)loadPortrait
{
    [portraitView getImage:[[[UserInfo sharedUserInfo] babyInfo] PortraitUrl] defaultImage:default_portrait_image];
}

- (void)updatePuumanData
{
    [coin_num setText:[NSString stringWithFormat:@"%0.1f",[[UserInfo sharedUserInfo] UCorns]]];
    
    
}

-(void)dealloc
{
    [MyNotiCenter removeObserver:self];
}
@end
