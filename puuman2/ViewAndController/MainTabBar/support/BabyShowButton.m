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
    [coin_num setShadowOffset:CGSizeMake(1, 1)];
    [coin_num setShadowColor:[UIColor grayColor]];
    [self addSubview:coin_num];
    
    coin_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, 128, 24)];
    [coin_label setBackgroundColor:[UIColor clearColor]];
    [coin_label setTextAlignment:NSTextAlignmentRight];
    [coin_label setTextColor:[UIColor whiteColor]];
    [coin_label setFont:PMFont2];
    [coin_label setText:@"扑满金币"];
    [coin_label setShadowColor:[UIColor grayColor]];
    [coin_label setShadowOffset:CGSizeMake(1, 1)];
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
    profileView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coin.png"]];
    animataView = [[CoinButtonAnimation alloc] initWithPrimaryView:portraitView andSecondaryView:profileView inFrame:portraitView.frame];
    [animataView setSpinTime:2.0];
    [self addSubview:animataView];
}


- (void)showAnimation
{
    
 
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
   // [animateView updateWithTotalBytes:100 downloadedBytes:100];

}

- (void)minusAnimation
{
   // [animateView updateWithTotalBytes:100 downloadedBytes:0];

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
     
        [self addPuuman];
    }else{
    
        [self addPuuman];
    }
}

- (void)addPuuman
{
    [animataView showAnimationCoinView];
//    if (status == PuumanAnimateNone) {
//        status = PuumanAnimateAdd;
//        [self addAnimation];
//    }
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
