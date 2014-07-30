//
//  VoteTableViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-29.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefreshHeaderView.h"
#import "Forum.h"

@interface VoteTableViewController : UITableViewController<MJRefreshBaseViewDelegate,ForumDelegate>
{
    MJRefreshHeaderView *_refreshHeader;

}
@property(nonatomic,assign)VotingTopicOrder voteOrder;

@end
