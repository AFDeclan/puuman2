//
//  VotingCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicInfoView.h"
#import "AFColorButton.h"
#import "Topic.h"
#import "Forum.h"
#import "Friend.h"

@interface VotingCell : UITableViewCell<ForumDelegate,FriendDelegate>
{
    BasicInfoView *infoView;
    UILabel *votingTopic_label;
    UILabel *votedNum_label;
    AFColorButton *voteBtn;
    UIView *bgView;
    Topic *votingTopic;
}

- (void)buildWithVoteTopic:(Topic *)voteTopic;
@end
