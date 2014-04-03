//
//  TopicCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "TopicCell.h"
#import "ColorsAndFonts.h"
#import "UserInfo.h"
#import "AllWordsPopViewController.h"
#import "MainTabBarController.h"
#import "TextTopicCell.h"
#import "PhotoTopicCell.h"
#import "UserInfo.h"

@implementation TopicCell
@synthesize isMyTopic = _isMyTopic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        hasInfoView = NO;
       
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        headerView = [[UIView alloc] init];
        [self.contentView addSubview:headerView];
        contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 608, 112)];
        [self.contentView addSubview:contentView];
        footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 176, 608, 88)];
        [self.contentView addSubview:footerView];
        [self initWithHeaderView];
        [headerView setBackgroundColor:PMColor5];
        [contentView setBackgroundColor:PMColor5];
        [footerView setBackgroundColor:PMColor5];
    }
    return self;
}

- (void)initWithHeaderView
{
    
    infoView = [[BasicInfoView alloc] init];
    [self.contentView addSubview:infoView];
    [infoView setInfoWithName:@"宝宝" andPortrailPath:[[UserInfo sharedUserInfo] portraitUrl] andRelate:@"哥哥" andIsBoy:YES];
    info_btn = [[UIButton alloc] initWithFrame:infoView.frame];
    [info_btn setBackgroundColor:[UIColor clearColor]];
    [info_btn addTarget:self action:@selector(tapped) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:info_btn];

    info_time = [[UILabel alloc] initWithFrame:CGRectMake(464, 16, 128, 12)];
    [info_time setTextAlignment:NSTextAlignmentRight];
    [info_time setTextColor:PMColor3];
    [info_time setFont:PMFont3];
    [info_time setBackgroundColor:[UIColor clearColor]];
    [headerView addSubview:info_time];
    
    headTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 608, 32)];
    [headerView addSubview:headTitleView];
    topicNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 512, 32)];
    [topicNameLabel setTextColor:[UIColor whiteColor]];
    [topicNameLabel setFont:PMFont2];
    [topicNameLabel setBackgroundColor:[UIColor clearColor]];
    [headTitleView addSubview:topicNameLabel];
    topicNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(534, 0, 64, 32)];
    [topicNumLabel setTextAlignment:NSTextAlignmentRight];
    [topicNumLabel setTextColor:[UIColor whiteColor]];
    [topicNumLabel setFont:PMFont2];
    [topicNumLabel setBackgroundColor:[UIColor clearColor]];
    [headTitleView addSubview:topicNumLabel];
    
    
    title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, 128, 16)];
    [title_label setTextAlignment:NSTextAlignmentRight];
    [title_label setTextColor:PMColor1];
    [title_label setFont:PMFont2];
    [title_label setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:title_label];

    
    replayBtn = [[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 304, 40)];
    [replayBtn addTarget:self action:@selector(replayBtnPressed) forControlEvents:UIControlEventTouchUpInside];

    
    
    likeBtn = [[AFSelecedTextImgButton alloc] initWithFrame:CGRectMake(304, 0, 304, 40)];
    [likeBtn addTarget:self action:@selector(likeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [likeBtn setSelectedImg:[UIImage imageNamed:@"btn_like1_topic.png"] andUnselectedImg:[UIImage imageNamed:@"btn_like2_topic.png"] andTitle:@"" andButtonType:kButtonTypeTwo andSelectedType:kNoneClear];
    [likeBtn setIconFrame:CGRectMake(0, 0, 20, 20)];
    [likeBtn unSelected];
    
    [footerView addSubview:replayBtn];
    [footerView addSubview:likeBtn];
    
    relayExample = [[UILabel alloc] initWithFrame:CGRectMake(16, 40, 496, 48)];
    [relayExample setText:@"妞妞：好可爱啊！"];
    [relayExample setFont:PMFont3];
    [relayExample setTextColor:PMColor2];
    [relayExample setBackgroundColor:[UIColor clearColor]];
    [footerView addSubview:relayExample];
    
    scanMoreReplay = [[AFTextImgButton alloc] initWithFrame:CGRectMake(496, 40, 112, 48)];
    [scanMoreReplay setTitle:@"查看更多留言" andImg:nil andButtonType:kButtonTypeOne];
    [scanMoreReplay setTitleLabelColor:PMColor3];
    [scanMoreReplay addTarget:self action:@selector(scanMore) forControlEvents:UIControlEventTouchUpInside];
    [scanMoreReplay setTitleFont:PMFont3];
    [footerView addSubview:scanMoreReplay];
    UIImageView *partLine_first  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 608, 2)];
    [partLine_first setImage:[UIImage imageNamed:@"line2_topic.png"]];
    [footerView addSubview:partLine_first];
    UIImageView *partLine_second  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 608, 2)];
    [partLine_second setImage:[UIImage imageNamed:@"line2_topic.png"]];
    [footerView addSubview:partLine_second];
}

- (void)setIsMyTopic:(BOOL)isMyTopic
{
    _isMyTopic = isMyTopic;
    if (isMyTopic) {
        [headerView setFrame:CGRectMake(0, 0, 608, 96)];
        [headTitleView setAlpha:1];
          SetViewLeftUp(info_time, 464, 48);
        SetViewLeftUp(infoView, 0, 32);
    }else{
        [headerView setFrame:CGRectMake(0, 0, 608, 64)];
        [headTitleView setAlpha:0];
        SetViewLeftUp(info_time, 464, 16);
        SetViewLeftUp(infoView, 0, 0);
    }
}


- (void)tapped
{
    [[Friend sharedInstance] addDelegateObject:self];
    [[MemberCache sharedInstance] getMemberWithUID:[UserInfo sharedUserInfo].UID];
}

//Member数据下载成功
- (void)memberDownloaded:(Member *)member
{
   // if (![member belongsTo:[UserInfo sharedUserInfo].UID]) {
    if (!hasInfoView) {
        RecommendPartnerViewController  *recommend = [[RecommendPartnerViewController alloc] initWithNibName:nil bundle:nil];
        [recommend setDelegate:self];
        [recommend setControlBtnType:kOnlyCloseButton];
        [recommend setRecommend:NO];
        [recommend setTitle:@"宝宝详情" withIcon:nil];
        [recommend buildWithTheUid:_replay.UID andUserInfo:member];
        [[MainTabBarController sharedMainViewController].view addSubview:recommend.view];
        [recommend show];
        hasInfoView = YES;
    }
          // }
   
    [[Friend sharedInstance] removeDelegateObject:self];

}

//Member数据下载失败
- (void)memberDownloadFailed
{
    [[Friend sharedInstance] removeDelegateObject:self];

}

- (void)popViewfinished
{
    hasInfoView = NO;
}

- (void)buildWithReply:(Reply *)replay
{
     [[Forum sharedInstance] removeDelegateObject:self];
     [[Forum sharedInstance] addDelegateObject:self];
    [replayBtn setTitle:[NSString stringWithFormat:@"%d",replay.RCommentCnt] andImg:[UIImage imageNamed:@"btn_reply1z_topic.png"] andButtonType:kButtonTypeTwo];
    [replayBtn setIconFrame:CGRectMake(0, 0, 20, 20)];
    [likeBtn resetTitle:[NSString stringWithFormat:@"%d",replay.RVoteCnt]];
    [likeBtn setIconFrame:CGRectMake(0, 0, 20, 20)];
    _replay = replay;
    if (_replay.voted) {
        [likeBtn selected];
    }
    CGRect frame = contentView.frame;
    if (![replay.RTitle isEqualToString:@""]) {
        [title_label setText:replay.RTitle];
        frame.size.height += 28;
        frame.origin.y = ViewHeight(headerView);
        contentView.frame = frame;
    }
    SetViewLeftUp(footerView, 0, ViewY(contentView) +ViewHeight(contentView));

    
}

- (void)replayBtnPressed
{
    [[MainTabBarController sharedMainViewController] setIsReply:YES];
    PostNotification(Noti_BottomInputViewShow,_replay);
    
}

- (void)likeBtnPressed
{
    
    if (!_replay.voted) {
        [_replay vote];
    }
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)scanMore
{
    AllWordsPopViewController *moreReplayVC  =[[ AllWordsPopViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:moreReplayVC.view];
    [moreReplayVC setControlBtnType:kOnlyCloseButton];
    [moreReplayVC setTitle:@"所有留言"];
    [moreReplayVC show];
}

+ (CGFloat)heightForReplay:(Reply *)replay andIsMyTopic:(BOOL)isMytopic
{
    
    float h = 64+88;
    if (![replay.RTitle isEqualToString:@""]) {
        h += 28;
    }
    if ([replay.textUrls count] != 0) {
        h += [TextTopicCell heightForReplay:replay andIsMyTopic:isMytopic];
    }
    
    if ([replay.photoUrls count] != 0) {
        h+= [PhotoTopicCell heightForReplay:replay andIsMyTopic:isMytopic];
    }
    if (isMytopic) {
        h += 32;
    }
    return h;
   
}

//点赞成功
- (void)topicReplyVoted:(Reply *)reply
{
    _replay = reply;
    [likeBtn selected];
    
}

//点赞失败
- (void)topicReplyVoteFailed:(Reply *)reply
{
    _replay = reply;

}

@end
