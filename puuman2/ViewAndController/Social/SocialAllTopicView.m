//
//  SocialAllTopicView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-28.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SocialAllTopicView.h"
#import "UniverseConstant.h"
#import "SocialViewController.h"

@implementation SocialAllTopicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        addressTag = 0;
        [self initialization];
        [[Forum sharedInstance] addDelegateObject:self];
        [MyNotiCenter addObserver:self selector:@selector(toNewestTopic) name:Noti_AllTopicToNewest object:nil];

    }
    return self;
}

- (void)showView
{
    [super showView];
    [[Forum sharedInstance] getActiveTopic];
}

- (void)activeTopicReceived
{
    addressTag = [Forum sharedInstance].onTopic.TNo;
    [self reloadTitleView];
    [titleColumnView setContentOffset:CGPointMake(608*(addressTag -1), 0)];
    [self resetTopicButton];
    [[SocialViewController sharedViewController] showNewestTopic];

}

- (void)toNewestTopic
{
    addressTag = [Forum sharedInstance].onTopic.TNo;
    [titleColumnView setContentOffset:CGPointMake(608*(addressTag -1), 0) animated:YES];

}

- (void)reloadTitleView
{
    if (titleColumnView) {
        [titleColumnView removeFromSuperview];
    }
    titleColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(0, 0, 608, 144)];
    [titleColumnView setBackgroundColor:[UIColor clearColor]];
    [titleColumnView setColumnViewDelegate:self];
    [titleColumnView setViewDataSource:self];
    [titleColumnView setPagingEnabled:YES];
    [titleColumnView setScrollEnabled:NO];
    [titleView addSubview:titleColumnView];
    [titleColumnView setContentSize:CGSizeMake( 608*([[Forum sharedInstance] onTopic].TNo +1),144)];
}

- (void)activeTopicFailed
{
    
}

- (void)initialization
{
    titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 608, 168)];
    [self addSubview:titleView];
    
    leftBtn = [[TopicSelectButton alloc] init];
    [leftBtn addTarget:self action:@selector(preTopic) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    [leftBtn setDirection:NO];
    
    rightBtn = [[TopicSelectButton alloc] init];
    [rightBtn addTarget:self action:@selector(nextTopic) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    [rightBtn setDirection:YES];
    [leftBtn setAlpha:0];
    [rightBtn setAlpha:0];
    [self reloadTitleView];
    
    right_sortBtn = [[AFSelectedTextImgButton alloc] initWithFrame:CGRectMake(304, 144, 304, 24)];
    [right_sortBtn addTarget:self action:@selector(rightSortSelected) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:right_sortBtn];
    [right_sortBtn setIconSize:CGSizeMake(12, 12)];
    [right_sortBtn setUnSelectedColor:PMColor6];
    [right_sortBtn setSelectedColor:[UIColor whiteColor]];
    [right_sortBtn adjustLayout];
    
    left_sortBtn = [[AFSelectedTextImgButton alloc] initWithFrame:CGRectMake(0, 144, 304, 24)];
    [left_sortBtn addTarget:self action:@selector(leftSortSelected) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:left_sortBtn];
    [left_sortBtn setIconSize:CGSizeMake(12, 12)];
    [left_sortBtn setSelectedColor:[UIColor whiteColor]];
    [left_sortBtn setUnSelectedColor:PMColor6];
    [left_sortBtn adjustLayout];
    [self resetTopicButton];
    
    topicTableView = [[AllTopicTableViewController alloc] initWithNibName:nil bundle:nil];
    [topicTableView.view setBackgroundColor:[UIColor clearColor]];
    [self addSubview:topicTableView.view];
    
    voteTableView = [[VoteTableViewController alloc] initWithNibName:nil bundle:nil];
    [voteTableView.view setBackgroundColor:[UIColor clearColor]];
    [self addSubview:voteTableView.view];
    [voteTableView.view setAlpha:0];
    [left_sortBtn selected];
    [right_sortBtn unSelected];
}




- (void)leftSortSelected
{
    [left_sortBtn selected];
    [right_sortBtn unSelected];
    if (addressTag > [[Forum sharedInstance] onTopic].TNo) {
        [voteTableView setVoteOrder:VotingTopicOrder_Time];
    }else{
        [topicTableView setReplyOrder:TopicReplyOrder_Time];
    }
}

- (void)rightSortSelected
{
    [right_sortBtn selected];
    [left_sortBtn unSelected];
    if (addressTag > [[Forum sharedInstance] onTopic].TNo) {
        [voteTableView setVoteOrder:VotingTopicOrder_Vote];
    }else{
        [topicTableView setReplyOrder:TopicReplyOrder_Vote];
    }
}

- (void)nextTopic
{
    addressTag ++;
   // [titleColumnView setContentOffset:CGPointMake(608*(addressTag - 1), 0) animated:YES];
    [rightBtn setEnabled:NO];
    [UIView animateWithDuration:0.5 animations:^{
        [titleColumnView setContentOffset:CGPointMake(titleColumnView.contentOffset.x + 607, 0) ];
        if (addressTag > [[Forum sharedInstance] onTopic].TNo) {
            [topicTableView.view setAlpha:0];
            [voteTableView.view setAlpha:1];
            [self leftSortSelected];
            [[SocialViewController sharedViewController] showVoteTopic];
        }else if(addressTag == [[Forum sharedInstance] onTopic].TNo){
            [[SocialViewController sharedViewController] showNewestTopic];

        }else{
            [[SocialViewController sharedViewController] showPreTopic];

        }
        
    } completion:^(BOOL finished) {
        [titleColumnView setContentOffset:CGPointMake(titleColumnView.contentOffset.x + 1, 0) ];
        [rightBtn setEnabled:YES];
        [self resetTopicButton];
    }];

}

- (void)preTopic
{
    [UIView animateWithDuration:0.5 animations:^{
        if (addressTag > [[Forum sharedInstance] onTopic].TNo) {
            [topicTableView.view setAlpha:1];
            [voteTableView.view setAlpha:0];
        }
    }];
  
    addressTag--;
    //[titleColumnView setContentOffset:CGPointMake(608*(addressTag - 1), 0) animated:YES];
    [leftBtn setEnabled:NO];
    [UIView animateWithDuration:0.5 animations:^{
        [titleColumnView setContentOffset:CGPointMake(titleColumnView.contentOffset.x - 607, 0) ];
        if (addressTag > [[Forum sharedInstance] onTopic].TNo) {
            [[SocialViewController sharedViewController] showVoteTopic];
            
        }else if (addressTag == [[Forum sharedInstance] onTopic].TNo){
            [[SocialViewController sharedViewController] showNewestTopic];
        }else{
            [[SocialViewController sharedViewController] showPreTopic];
            
        }
    } completion:^(BOOL finished) {
        [titleColumnView setContentOffset:CGPointMake(titleColumnView.contentOffset.x - 1, 0) ];
        [leftBtn setEnabled:YES];
        [self resetTopicButton];
        
    }];

    
}

- (void)resetTopicButton
{
    if (addressTag == 1 ) {
        [leftBtn setAlpha:0];
    }else{
        [leftBtn setAlpha:1];
    }
    
    if (addressTag > [[Forum sharedInstance] onTopic].TNo) {
        [rightBtn setAlpha:0];
        [leftBtn setNoti:@""];
        [leftBtn setTitleName:@"本期话题"];
        [right_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_like1_topic.png"]];
        [right_sortBtn setUnSelectedImg:[UIImage imageNamed:@"icon_like2_topic.png"]];
        [right_sortBtn.title setText:@"最多投票"];
        [right_sortBtn adjustLayout];
        
        [left_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_time1_topic.png"]];
        [left_sortBtn setUnSelectedImg:[UIImage imageNamed:@"icon_time2_topic.png"]];
        [left_sortBtn.title setText:@"最新发起"];
        [left_sortBtn adjustLayout];

    }else{
        [rightBtn setAlpha:1];
        [right_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_like1_topic.png"]];
        [right_sortBtn setUnSelectedImg:[UIImage imageNamed:@"icon_like2_topic.png"]];
        [right_sortBtn.title setText:@"最多喜欢"];
        [right_sortBtn adjustLayout];
        [left_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_time1_topic.png"]];
        [left_sortBtn setUnSelectedImg:[UIImage imageNamed:@"icon_time2_topic.png"]];
        [left_sortBtn.title setText:@"最新参与"];
        [left_sortBtn adjustLayout];

        if ([[Forum sharedInstance] onTopic].TNo == addressTag){
            [rightBtn setTitleName:@"征集!"];
            [leftBtn setTitleName:@"回顾！"];

        }else{
            [rightBtn setNoti:@"下期话题"];
            [leftBtn setNoti:@"往期话题"];

        }
    }
    if (addressTag == 0) {
        [leftBtn setAlpha:0];
        [rightBtn setAlpha:0];
    }
    
}

#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
    
}


- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{
    
    return 608;
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    if ([[Forum sharedInstance] onTopic]) {
        return [[Forum sharedInstance] onTopic].TNo+1;
    }else{
        return 1;
    }
    
}

- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    NSString * cellIdentifier = @"AllTitleCell";
    TopicTitleCell *cell = (TopicTitleCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[TopicTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setDelegate:self];
    [cell setTopicNum:index+1];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
    
}

- (void)receivedTopic:(Topic *)topic
{
    [topicTableView setTopic:topic];
    [self leftSortSelected];

}


- (void)setVerticalFrame
{
    [rightBtn setVerticalFrame];
    [leftBtn setVerticalFrame];
    SetViewLeftUp(rightBtn, 480, 0);
    SetViewLeftUp(titleView, 0, 0);
    [topicTableView.view setFrame:CGRectMake(0, 168, 608, 944 - 168 )];
    [voteTableView.view setFrame:CGRectMake(0, 168, 608, 944 - 168 )];


}

- (void)setHorizontalFrame
{
    [rightBtn setHorizontalFrame];
    [leftBtn setHorizontalFrame];
    SetViewLeftUp(rightBtn, 736, 0);
    SetViewLeftUp(titleView, 128, 0);
    [topicTableView.view setFrame:CGRectMake(128, 168, 608, 688 - 168)];
    [voteTableView.view setFrame:CGRectMake(128, 168, 608, 688 - 168)];


}

//回复上传成功
- (void)topicReplyUploaded:(ReplyForUpload *)reply
{
    PostNotification(Noti_AddTopic, nil);
    
}

//回复上传失败
- (void)topicReplyUploadFailed:(ReplyForUpload *)reply
{
    
}
@end
