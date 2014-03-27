//
//  VotingCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "VotingCell.h"
#import "UserInfo.h"

@implementation VotingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 608, 100)];
        [bgView setBackgroundColor:PMColor5];
        [self.contentView addSubview:bgView];
        infoView = [[BasicInfoView alloc] init];
        [self.contentView addSubview:infoView];
        [infoView setInfoWithName:@"宝宝" andPortrailPath:[[UserInfo sharedUserInfo] portraitUrl] andRelate:@"哥哥" andIsBoy:YES];
        
        votingTopic_label = [[UILabel alloc] initWithFrame:CGRectMake(56, 56, 440, 16)];
        [votingTopic_label setBackgroundColor:[UIColor clearColor]];
        [votingTopic_label setFont:PMFont2];
        [votingTopic_label setTextColor:PMColor1];
        [votingTopic_label setTextColor:[UIColor whiteColor]];
        [votingTopic_label setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:votingTopic_label];
        votedNum_label = [[UILabel alloc] initWithFrame:CGRectMake(392, 16, 200, 16)];
        [votedNum_label setBackgroundColor:[UIColor clearColor]];
        [votedNum_label setFont:PMFont2];
        [votedNum_label setTextColor:PMColor6];
        [votedNum_label setTextAlignment:NSTextAlignmentRight];
        [votedNum_label setText:@"308票"];
        [self.contentView addSubview:votedNum_label];
        voteBtn = [[ColorButton alloc] init];
        SetViewLeftUp(voteBtn, 496, 44);
        [voteBtn addTarget:self action:@selector(voted) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:voteBtn];
       
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)buildWithVoteTopic:(Topic *)voteTopic
{
     [[Forum sharedInstance] removeDelegateObject:self];
     [[Forum sharedInstance] addDelegateObject:self];
    votingTopic = voteTopic;
    if (voteTopic.voted) {
        [voteBtn initWithTitle:@"已经投了" andButtonType:kGrayLeft];
    }else{
        [voteBtn initWithTitle:@"投Ta一票" andButtonType:kGrayLeft];
    }
    [votingTopic_label setText:votingTopic.TTitle];
    
    
    
}

- (void)voted
{
    [votingTopic voted];
   
}

//话题投票成功
- (void)topicVoted:(Topic *)topic
{
    votingTopic = topic;
    [voteBtn initWithTitle:@"已经投了" andButtonType:kGrayLeft];
}

//话题投票失败，注意根据voted判断是否是因为重复投票
- (void)topicVoteFailed:(Topic *)topic;
{
    NSLog(@"投票失败");
}
@end
