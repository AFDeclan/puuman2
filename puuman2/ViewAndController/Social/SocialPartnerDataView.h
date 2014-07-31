//
//  SocialPartnerDataView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-28.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SocialDetailView.h"
#import "PartnerOutGroupDataView.h"
#import "PartnerInGroupDataView.h"
#import "Friend.h"

@interface SocialPartnerDataView : SocialDetailView<FriendDelegate>
{
    PartnerInGroupDataView *inGroupView;
    PartnerOutGroupDataView *outGroupView;
}

- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
