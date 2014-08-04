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
@synthesize socialType = _socialType;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        _socialType = kSocialNoneType;
    }
    return self;
}

- (void)setSocialType:(SocialViewType)socialType
{
    if (_socialType != kSocialNoneType) {
        [selectedView hiddenView];

    }
    _socialType = socialType;
    switch (socialType) {
        case kSocialAllTopicView:
            [self selectedAll];
            break;
        case kSocialMyTopicView:
            [self selectedMine];
            break;
        case kSocialPartnerDataView:
            [self selectedData];
            break;
        case kSocialPartnerChatView:
            [self selectedChat];
            break;
        default:
            break;
    }
    if (_socialType != kSocialNoneType) {
        [selectedView showView];
    }
}
- (void)selectedAll
{
    if (!allTopic) {
        allTopic = [[SocialAllTopicView alloc] initWithFrame:CGRectZero];
        [self addSubview:allTopic];
    }
    
    selectedView = allTopic;
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
}

- (void)selectedMine
{
    if (!myTopic) {
        myTopic = [[SocialMyTopicView alloc] initWithFrame:CGRectZero];
        [self addSubview:myTopic];
    }
    selectedView = myTopic;

    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
}


- (void)selectedData
{
    if (!partnerData) {
        partnerData = [[SocialPartnerDataView alloc] initWithFrame:CGRectZero];
        [self addSubview:partnerData];
    }
    
    selectedView = partnerData;
    PostNotification(Noti_BottomInputViewHidden, nil);
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }

}


- (void)selectedChat
{
    if (!partnerChat) {
        partnerChat = [[SocialPartnerChatView alloc] initWithFrame:CGRectZero];
        [self addSubview:partnerChat];
    }
    selectedView = partnerChat;
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
}


- (void)setVerticalFrame
{
    [selectedView setFrame:CGRectMake(0, 0, 608, 944)];
    [selectedView setVerticalFrame];
}

- (void)setHorizontalFrame
{
    [selectedView setFrame:CGRectMake(0, 0, 864, 688)];
    [selectedView setHorizontalFrame];
}

@end
