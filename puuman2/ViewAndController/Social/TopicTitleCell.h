//
//  TopicTitleCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-29.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"
#import "Topic.h"
#import "Member.h"
#import "Friend.h"

@protocol TopicTitleDelegate;
@interface TopicTitleCell : UITableViewCell<FriendDelegate>
{
    AFImageView *titleImageView;
    UILabel *info_title;
    UILabel *info_upload;
    UILabel *noti_current;
    Topic *_topic;
}

@property(nonatomic,assign)NSInteger topicNum;
@property(nonatomic,assign)id<TopicTitleDelegate> delegate;
@end

@protocol TopicTitleDelegate <NSObject>

- (void)receivedTopic:(Topic *)topic;

@end
