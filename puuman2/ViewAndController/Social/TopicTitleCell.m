//
//  TopicTitleCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-29.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "TopicTitleCell.h"
#import "UniverseConstant.h"
#import "MemberCache.h"
#import "Forum.h"


@implementation TopicTitleCell
@synthesize topicNum = _topicNum;
@synthesize delegate = _delegate;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [[Friend sharedInstance] addDelegateObject:self];
        [self initialization];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initialization
{
    titleImageView = [[AFImageView alloc] initWithFrame:CGRectMake(0, 0, 608, 144)];
    [titleImageView setImage:[UIImage imageNamed:@"pic_future_topic.png"]];
    [self addSubview:titleImageView];
    
    noti_current = [[UILabel alloc] initWithFrame:CGRectMake(208, 24, 320, 28)];
    [noti_current setBackgroundColor:[UIColor clearColor]];
    [noti_current setFont:PMFont2];
    [noti_current setTextColor:PMColor3];
    [noti_current setText:@"本期话题"];
    [self addSubview:noti_current];
    [noti_current setAlpha:0];
    info_title = [[UILabel alloc] initWithFrame:CGRectMake(208, 48, 320, 28)];
    [info_title setBackgroundColor:[UIColor clearColor]];
    [info_title setFont:PMFont1];
    [info_title setTextColor:PMColor1];
    [self addSubview:info_title];
    info_upload = [[UILabel alloc] initWithFrame:CGRectMake(208, 76, 320, 20)];
    [info_upload setBackgroundColor:[UIColor clearColor]];
    [info_upload setFont:PMFont2];
    [info_upload setTextColor:PMColor3];
    [self addSubview:info_upload];

}

- (void)setTopicNum:(NSInteger)topicNum
{
    _topicNum = topicNum;
   
    if (_topicNum >[[Forum sharedInstance] onTopic].TNo) {
        if ([[Forum sharedInstance] onTopic].TNo == 0) {
            [titleImageView setImage:[UIImage imageNamed:@"pic_future_topic.png"]];
        }else{
            [noti_current setAlpha:0];
            [info_title setText:[NSString stringWithFormat:@"第%d期话题征集中",topicNum]];
            [info_title setTextColor:PMColor6];
            [info_upload setText:@"发起或投票选出你最喜欢的话题吧！"];
            [titleImageView setImage:[UIImage imageNamed:@"pic_future_topic.png"]];
        }
       
    }else{
        if ([[Forum sharedInstance] onTopic].TNo == topicNum) {
            _topic = [[Forum sharedInstance] getTopic:topicNum];

            [noti_current setAlpha:1];
            [info_title setText:_topic.TTitle];
            [titleImageView getImage:[_topic TImgUrl] defaultImage:nil];
            [info_title setTextColor:PMColor1];
            [_delegate receivedTopic:_topic];

        }else{
            [noti_current setAlpha:0];
            _topic = [[Forum sharedInstance] getTopic:topicNum];
            if (_topic) {
                [_delegate receivedTopic:_topic];
                [titleImageView getImage:[_topic TImgUrl] defaultImage:nil];
                [info_title setText:_topic.TTitle];
            }
        }
        [info_upload setText:@""];
        Member *member_upload = [[MemberCache sharedInstance] getMemberWithUID:_topic.TUploadUID];
        if (member_upload) {
            if ([member_upload babyInfo].Nickname && ![[member_upload babyInfo].Nickname isEqualToString:@""]) {
                [info_upload setText:[NSString stringWithFormat:@"该话题由%@发起",[member_upload babyInfo].Nickname]];
            }
        }
        
    }
    
}

- (void)memberDownloaded:(Member *)member
{
    if ([member belongsTo:_topic.TUploadUID]) {
        if ([member babyInfo].Nickname && ![[member babyInfo].Nickname isEqualToString:@""]) {
            [info_upload setText:[NSString stringWithFormat:@"该话题由%@发起",[member babyInfo].Nickname]];
        }
    }
    
}

//Member数据下载失败
- (void)memberDownloadFailed
{
    
}

- (void)dealloc
{
    [[Friend sharedInstance] removeDelegateObject:self];

}


//往期话题获取成功。
- (void)topicReceived:(Topic *)topic
{
    _topic = topic;
    [titleImageView getImage:[_topic TImgUrl] defaultImage:nil];
    [info_title setText:_topic.TTitle];
    [_delegate receivedTopic:topic];
}

//往期话题获取失败
- (void)topicFailed:(NSString *)TNo
{
    
}


@end
