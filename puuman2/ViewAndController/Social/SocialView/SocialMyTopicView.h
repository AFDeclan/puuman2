//
//  SocialMyTopicView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-28.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SocialDetailView.h"
#import "MJRefreshHeaderView.h"
#import "Forum.h"
#import "TopicCell.h"

@interface SocialMyTopicView : SocialDetailView<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,ForumDelegate,TopicCellDelegate>
{
    MJRefreshHeaderView *_refreshHeader;
    NSMutableDictionary *status;
    UITableView *myTopicTable;
}

@end
