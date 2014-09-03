//
//  SocialContentView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-16.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocialAllTopicView.h"
#import "SocialMyTopicView.h"
#import "SocialPartnerDataView.h"
#import "SocialPartnerChatView.h"
#import "SocialDetailView.h"

typedef enum {
    kSocialAllTopicView,
    kSocialMyTopicView,
    kSocialPartnerDataView,
    kSocialPartnerChatView,
    kSocialNoneType
} SocialViewType;

@interface SocialContentView : UIView
{
    SocialAllTopicView *allTopic;
    SocialMyTopicView *myTopic;
    SocialPartnerDataView *partnerData;
    SocialPartnerChatView *partnerChat;
    SocialDetailView *selectedView;
}

@property(nonatomic,assign)SocialViewType socialType;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
