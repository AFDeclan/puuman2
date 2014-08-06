//
//  PartnerOutGroupDataView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-31.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InviteGroupCell.h"
#import "Friend.h"

@interface PartnerOutGroupDataView : UIView <UITableViewDataSource,UITableViewDelegate,InvitedMemberDelegate,FriendDelegate>
{
    UITableView *inviteGroupsTable;
    NSArray *dataArr;
    UIView *emptyNotiView;
}

- (void)loadViewInfo;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;

@end
