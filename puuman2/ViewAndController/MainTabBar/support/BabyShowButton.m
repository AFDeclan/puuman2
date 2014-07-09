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

- (void)initialization
{
    status = PuumanAnimateNone;
    bg_babybutton = [[UIImageView alloc ]initWithFrame:CGRectMake(0, 0, 56, 56)];
    [bg_babybutton setImage:[UIImage imageNamed:@"babyInfo_btn.png"] ];
    [self addSubview:bg_babybutton];
    
    portraitView =[[AFImageView alloc] initWithFrame:CGRectMake(8, 8, 40, 40)];
    [portraitView setContentMode:UIViewContentModeScaleAspectFill];
    [portraitView setBackgroundColor:[UIColor clearColor]];
    portraitView.layer.cornerRadius = 20;
    portraitView.layer.masksToBounds = YES;
    portraitView.layer.shadowRadius =0.1;
    [self addSubview:portraitView];
    [self loadAnimateView];
    [MyNotiCenter addObserver:self selector:@selector(addPuuman) name:Noti_AddCorns object:nil];


}



- (void)loadAnimateView
{
    animateView = [[PuumanButtonAnimateView alloc]initWithFrame:CGRectMake(8,8 , 40, 40)];
    [animateView setBackgroundColor:[UIColor clearColor]];
    [animateView setFillColor:[UIColor colorWithRed:16./255 green:119./255 blue:234./255 alpha:1.0f]];
    [animateView setStrokeColor:[UIColor colorWithRed:16./255 green:119./255 blue:234./255 alpha:1.0f]];
    animateView.radiusPercent = 0.5 ;
    [self addSubview:animateView];
    [animateView setDelegate:self];
    [animateView loadIndicator];
    showLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 40, 40)];
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
    fadeAnimation.duration = 1;
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
    [scaleAnimation2 setBeginTime:0.3];
    scaleAnimation2.removedOnCompletion = NO;
    scaleAnimation2.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *scaleAnimation3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    scaleAnimation3.toValue = [NSNumber numberWithFloat:1.1];
    scaleAnimation3.duration = 0.1;
    [scaleAnimation3 setBeginTime:0.4];
    scaleAnimation3.removedOnCompletion = NO;
    scaleAnimation3.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *scaleAnimation4 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation4.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    scaleAnimation4.toValue = [NSNumber numberWithFloat:1];
    scaleAnimation4.duration = 0.1;
    [scaleAnimation4 setBeginTime:0.5];
    scaleAnimation4.removedOnCompletion = NO;
    scaleAnimation4.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup*group = [CAAnimationGroup animation];
    [group  setDuration:1];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [group setAnimations:[NSArray arrayWithObjects:scaleAnimation1,scaleAnimation2, scaleAnimation3,scaleAnimation4, nil]];
    [showLabel.layer addAnimation:group forKey:@"group"];

}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [[MainTabBarController sharedMainViewController] updatePuumanData];

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


- (void)addPuuman
{
    [showLabel setText:@"+1"];
    if (status == PuumanAnimateNone) {
        status = PuumanAnimateAdd;
        [self addAnimation];
    }
}
- (void)minusPuuman
{
    [showLabel setText:@"-1"];

    if (status == PuumanAnimateNone) {
        status = PuumanAnimateAdd;
        [self addAnimation];
    }
}

-(void)loadPortrait
{
  [portraitView getImage:[[[UserInfo sharedUserInfo] babyInfo] PortraitUrl] defaultImage:default_portrait_image];
}

-(void)dealloc
{
    [MyNotiCenter removeObserver:self];
}
@end
