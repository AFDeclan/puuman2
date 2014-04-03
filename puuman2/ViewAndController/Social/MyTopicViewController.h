//
//  MyTopicViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SortTableViewController.h"
#import "MJRefreshFooterView.h"
#import "Forum.h"

@interface MyTopicViewController : SortTableViewController<ForumDelegate,MJRefreshBaseViewDelegate>
{
    MJRefreshFooterView *_refreshFooter;
    NSMutableArray *replays;
}
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
