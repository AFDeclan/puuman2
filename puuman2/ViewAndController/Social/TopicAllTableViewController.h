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
#import "Forum.h"

@interface TopicAllTableViewController : SortTableViewController<ForumDelegate,MJRefreshBaseViewDelegate>
{
    MJRefreshFooterView *_refreshFooter;
    NSArray *replays;
}

@property(nonatomic,assign)BOOL voting;
@property(nonatomic,retain)Topic *topic;
@property(nonatomic,assign)TopicReplyOrder order;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
