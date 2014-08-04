//
//  SocialPartnerChatView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-28.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SocialDetailView.h"
#import "Friend.h"
#import "Group.h"
#import "ChatInputViewController.h"

@interface SocialPartnerChatView : SocialDetailView<UITableViewDelegate,UITableViewDataSource,FriendDelegate>
{
    UIView *bgHeadView;
    UIView *icon_headUp;
    UIView *icon_headDown;
    UILabel *info_title;
    UITableView *chatTable;
    Group *myGroup;
    ChatInputViewController *inputVC;
}

-(void)reloadChatData;

@end
