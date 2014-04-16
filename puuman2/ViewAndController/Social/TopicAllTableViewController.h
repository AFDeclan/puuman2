//
//  TopicAllTableViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-21.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SortTableViewController.h"
#import "Topic.h"
#import "MJRefreshFooterView.h"
#import "MJRefreshHeaderView.h"
#import "Forum.h"

@interface TopicAllTableViewController : SortTableViewController<ForumDelegate,MJRefreshBaseViewDelegate>
{
    MJRefreshFooterView *_refreshFooter;
    MJRefreshHeaderView *_refreshHeader;
    NSArray *replays;
    NSArray *votings;
    UIView *emptyNotiView;
    UILabel *noti_empty;
}

@property(nonatomic,assign)BOOL voting;
@property(nonatomic,retain)Topic *topic;
@property(nonatomic,assign)TopicReplyOrder replyOrder;
@property(nonatomic,assign)VotingTopicOrder voteOrder;

- (void)setVerticalFrame;
- (void)setHorizontalFrame;
- (void)forceRelease;

@end
