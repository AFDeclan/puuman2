//
//  SocialContentView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-16.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllTopicView.h"
#import "MyTopicView.h"
#import "PartnerDataView.h"
#import "PartnerChatView.h"


typedef enum {
    kAllTopicView,
    kMyTopicView,
    kPartnerDataView,
    kPartnerChatView,
    kSocialNoneType
} SocialViewType;

@interface SocialContentView : UIView
{
    PartnerDataView *partnerData;
    PartnerChatView *partnerChat;
    AllTopicView *allTopic;
    MyTopicView *myTopic;
    SocialViewType socialType;
}

- (void)selectWithType:(SocialViewType)type;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
