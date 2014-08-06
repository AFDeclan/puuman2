//
//  AllTopicTableViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-28.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefreshFooterView.h"
#import "MJRefreshHeaderView.h"
#import "Topic.h"
#import "TopicCell.h"
#import "Forum.h"

@interface AllTopicTableViewController : UITableViewController<MJRefreshBaseViewDelegate,TopicCellDelegate,ForumDelegate>
{
    MJRefreshHeaderView *_refreshHeader;
    NSMutableDictionary *status;
}

@property(nonatomic,retain)Topic *topic;
@property(nonatomic,assign)TopicReplyOrder replyOrder;
@end
