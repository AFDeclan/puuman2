//
//  SocialPartnerDataView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-28.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SocialDetailView.h"
#import "Friend.h"
#import "PartnerDataInGroupView.h"
#import "PartnerDataOutGroupView.h"

@interface SocialPartnerDataView : SocialDetailView<FriendDelegate>

{
    PartnerDataInGroupView *inGroupView;
    PartnerDataOutGroupView *outGroupView;
    

}

- (void)refreshStatus;


@end
