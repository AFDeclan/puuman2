//
//  SocialAllTopicView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-28.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SocialDetailView.h"
#import "UIColumnView.h"
#import "Forum.h"
#import "TopicSelectButton.h"
#import "AFSelectedTextImgButton.h"
#import "AllTopicTableViewController.h"
#import "VoteTableViewController.h"
#import "TopicTitleCell.h"

@interface SocialAllTopicView : SocialDetailView<UIColumnViewDataSource, UIColumnViewDelegate,ForumDelegate,TopicTitleDelegate>
{
    UIView *titleView;
    UIColumnView *titleColumnView;
    NSInteger addressTag;
    AllTopicTableViewController *topicTableView;
    VoteTableViewController *voteTableView;
    TopicSelectButton *leftBtn;
    TopicSelectButton *rightBtn;
    AFSelectedTextImgButton *left_sortBtn;
    AFSelectedTextImgButton *right_sortBtn;

    
}

@end
