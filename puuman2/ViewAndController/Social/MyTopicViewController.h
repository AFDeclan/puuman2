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
#import "TopicCell.h"

@interface MyTopicViewController : SortTableViewController<ForumDelegate,MJRefreshBaseViewDelegate,TopicCellDelegate>
{
    //MJRefreshFooterView *_refreshFooter;
    MJRefreshHeaderView *_refreshHeader;
    UIView *emptyNotiView;
    UILabel *noti_empty;
    NSMutableDictionary *status;
    NSInteger replayNum;

}

- (void)reloadMyTopic;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
