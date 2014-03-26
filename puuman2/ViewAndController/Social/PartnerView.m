//
//  PartnerView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PartnerView.h"
#import "MainTabBarController.h"

@implementation PartnerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


- (void)setVerticalFrame
{
    if (partnerData) {
        [partnerData setFrame:CGRectMake(0, 0, 608, 944)];
        [partnerData setVerticalFrame];
    }
    
    if (partnerChat) {
        [partnerChat setFrame:CGRectMake(0, 0, 608, 944)];
        [partnerChat setVerticalFrame];
    }
}

- (void)setHorizontalFrame
{
    if (partnerData) {
        [partnerData setFrame:CGRectMake(0, 0, 864, 688)];
        [partnerData setHorizontalFrame];
    }
    
    if (partnerChat) {
        [partnerChat setFrame:CGRectMake(0, 0, 864, 688)];
        [partnerChat setHorizontalFrame];
    }
}

- (void)selectedData
{
    if (!partnerData) {
        partnerData = [[PartnerDataView alloc] initWithFrame:CGRectZero];
        [self addSubview:partnerData];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
    }
    [partnerData setAlpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        [partnerData setAlpha:1];
        if (partnerChat) {
            [partnerChat setAlpha:0];
            PostNotification(Noti_BottomInputViewHidden, nil);
        }
    }];
}

- (void)selectedChat
{
    if (!partnerChat) {
        partnerChat = [[PartnerChatView alloc] initWithFrame:CGRectZero];
        [self addSubview:partnerChat];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
    }
    [partnerChat setAlpha:0];
    PostNotification(Noti_BottomInputViewShow, [NSNumber numberWithBool:NO]);
    [UIView animateWithDuration:0.5 animations:^{
        [partnerChat setAlpha:1];
        if (partnerData) {
            [partnerData setAlpha:0];
        }
    }];
}

@end
