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
        
        votingTopic = [[UILabel alloc] initWithFrame:CGRectMake(56, 56, 440, 16)];
        [votingTopic setBackgroundColor:[UIColor clearColor]];
        [votingTopic setFont:PMFont2];
        [votingTopic setTextColor:PMColor1];
        [votingTopic setTextColor:[UIColor whiteColor]];
        [votingTopic setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:votingTopic];
        votedNum = [[UILabel alloc] initWithFrame:CGRectMake(392, 16, 200, 16)];
        [votedNum setBackgroundColor:[UIColor clearColor]];
        [votedNum setFont:PMFont2];
        [votedNum setTextColor:PMColor6];
        [votedNum setTextAlignment:NSTextAlignmentRight];
        [votedNum setText:@"308票"];
        [self.contentView addSubview:votedNum];
        voteBtn = [[ColorButton alloc] init];
        [voteBtn initWithTitle:@"投Ta一票" andButtonType:kGrayLeft];
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

- (void)voted
{

}

@end
