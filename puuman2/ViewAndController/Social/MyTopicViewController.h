//
//  MyTopicViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SortTableViewController.h"
#import "MJRefreshFooterView.h"
#import "MJRefreshHeaderView.h"
#import "Forum.h"

@interface MyTopicViewController : SortTableViewController<ForumDelegate,MJRefreshBaseViewDelegate>
{
    MJRefreshFooterView *_refreshFooter;
    MJRefreshHeaderView *_refreshHeader;
    NSMutableArray *replays;
}

- (void)reloadMyTopic;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
