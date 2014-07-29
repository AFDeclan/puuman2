//
//  PartnerChatView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdaptiveLabel.h"
#import "TextLayoutLabel.h"
#import "Friend.h"
#import "Group.h"
#import "ChatInputViewController.h"

@interface PartnerChatView : UIView<UITableViewDataSource,UITableViewDelegate,FriendDelegate>
{
    UIView *bgHeadView;
    UIView *icon_headDown;
    UIView *icon_headUp;
    UITableView *chatTable;
//    UILabel *noti_label;
    UILabel *info_title;
    Group *myGroup;
    ChatInputViewController *inputVC;
}

- (void)reloadChatData;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;

@end
