//
//  SocialContentView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-16.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SocialContentView.h"
#import "MainTabBarController.h"


@implementation SocialContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)selectedAll
{
    if (!allTopic) {
        allTopic = [[AllTopicView alloc] initWithFrame:CGRectZero];
        [self addSubview:allTopic];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
    }
    
    [allTopic reloadAllTopic];
    [allTopic setAlpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        [allTopic setAlpha:1];
        if (myTopic) {
            [myTopic setAlpha:0];
        }
    }];
}

- (void)selectedMine
{
    if (!myTopic) {
        
        myTopic = [[MyTopicView alloc] initWithFrame:CGRectZero];
        [self addSubview:myTopic];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
    }
    
    [myTopic reloadMyTopic];
    [myTopic setAlpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        [myTopic setAlpha:1];
        if (allTopic) {
            [allTopic setAlpha:0];
        }
    }];
    
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
    if (myTopic) {
        [myTopic setFrame:CGRectMake(0, 0, 608, 944)];
        [myTopic setVerticalFrame];
    }
    
    if (allTopic) {
        [allTopic setFrame:CGRectMake(0, 0, 608, 944)];
        [allTopic setVerticalFrame];
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
    if (myTopic) {
        [myTopic setFrame:CGRectMake(0, 0, 864, 688)];
        [myTopic setHorizontalFrame];
    }
    
    if (allTopic) {
        [allTopic setFrame:CGRectMake(0, 0, 864, 688)];
        [allTopic setHorizontalFrame];
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
    [partnerData refreshStatus];
    [partnerData setAlpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        [partnerData setAlpha:1];
        if (partnerChat) {
            [partnerChat setAlpha:0];
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
    [partnerChat reloadChatData];
    [[MainTabBarController sharedMainViewController] setIsReply:NO];
    [UIView animateWithDuration:0.5 animations:^{
        [partnerChat setAlpha:1];
        if (partnerData) {
            [partnerData setAlpha:0];
        }
    }];
}

- (void)selectWithType:(SocialViewType)type
{
    [[Forum sharedInstance] removeAllDelegates];
    [[Friend sharedInstance] removeAllDelegates];
   
    switch (socialType) {
        case kAllTopicView:
        {
            [allTopic removeColumnView];
            [allTopic removeFromSuperview];
            allTopic = nil;
        }
            break;
        case kMyTopicView:
        {
            [myTopic removeFromSuperview];
            myTopic = nil;
        }
            break;
        case kPartnerChatView:
        {
            [partnerChat removeFromSuperview];
            partnerChat = nil;
        }
            break;
        case kPartnerDataView:
        {
            [partnerData removeFromSuperview];
          
            partnerData = nil;
        }
            break;
        default:
            break;
    }
    switch (type) {
        case kAllTopicView:
            [self selectedAll];
            break;
        case kMyTopicView:
            [self selectedMine];
            break;
        case kPartnerChatView:
            [self selectedChat];
            break;
        case kPartnerDataView:
            [self selectedData];
            break;
        default:
            break;
    }
    socialType = type;
}
@end
