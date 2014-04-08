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
#import "Comment.h"

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

    
    likeBtn = [[AFTextImgButton alloc] initWithFrame:CGRectMake(304, 0, 304, 40)];
    [likeBtn addTarget:self action:@selector(likeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:replayBtn];
    [footerView addSubview:likeBtn];
    
    relayExample = [[UILabel alloc] initWithFrame:CGRectMake(16, 40, 496, 48)];
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
        SetViewLeftUp(contentView, 96, 0);
        
    }else{
        [headerView setFrame:CGRectMake(0, 0, 608, 64)];
        [headTitleView setAlpha:0];
        SetViewLeftUp(info_time, 464, 16);
        SetViewLeftUp(infoView, 0, 0);
        SetViewLeftUp(contentView, 0, 64);
      
    }
}


- (void)tapped
{
   
    Member *member = [[MemberCache sharedInstance] getMemberWithUID:[UserInfo sharedUserInfo].UID];
    if (member) {
        [self memberDownloaded:member];
    }

    

}

//Member数据下载成功
- (void)memberDownloaded:(Member *)member
{
   
    if (![member belongsTo:_reply.UID]) {
        
        if (![member belongsTo:[UserInfo sharedUserInfo].UID]) {
            if (!hasInfoView) {
                RecommendPartnerViewController  *recommend = [[RecommendPartnerViewController alloc] initWithNibName:nil bundle:nil];
                [recommend setDelegate:self];
                [recommend setControlBtnType:kOnlyCloseButton];
                [recommend setRecommend:NO];
                [recommend setTitle:@"宝宝详情" withIcon:nil];
                [recommend buildWithTheUid:_reply.UID andUserInfo:member];
                [[MainTabBarController sharedMainViewController].view addSubview:recommend.view];
                [recommend show];
                hasInfoView = YES;
            }
        }else{
            _member = member;
            [infoView setInfoWithName:member.BabyNick andPortrailPath:member.BabyPortraitUrl andRelate:@"哥哥" andIsBoy:member.BabyIsBoy];
        }
    }else{
        _member = member;
        [infoView setInfoWithName:member.BabyNick andPortrailPath:member.BabyPortraitUrl andRelate:@"哥哥" andIsBoy:member.BabyIsBoy];

    }
}

//Member数据下载失败
- (void)memberDownloadFailed
{
    [[Friend sharedInstance] removeDelegateObject:self];

}

- (void)popViewfinished
{
    hasInfoView = NO;
    [[Forum sharedInstance] addDelegateObject:self];
}

- (void)buildWithReply:(Reply *)reply
{
     _reply = reply;
    [topicNumLabel setText:[NSString stringWithFormat:@"第%d期",reply.TID]];
    
    _member = [[MemberCache sharedInstance] getMemberWithUID:reply.UID];
    if (_member) {
      
        [infoView setInfoWithName:_member.BabyNick andPortrailPath:_member.BabyPortraitUrl andRelate:@"哥哥" andIsBoy:_member.BabyIsBoy];

    }
   
    [[Friend sharedInstance] addDelegateObject:self];

    
    [[Forum sharedInstance] removeDelegateObject:self];
    [[Forum sharedInstance] addDelegateObject:self];
   
    
    if ([[_reply comments] count] == 0) {
        if (![_reply noMore]) {
            [_reply getMoreComments:10 newDirect:YES];
        }
    }else{
        [relayExample setText:[[_reply comments] objectAtIndex:0]];
    }
 
    if (_isMyTopic) {
        [[Forum sharedInstance] getTopic:reply.TID];
    }

    
    [replayBtn setTitle:[NSString stringWithFormat:@"%d",reply.RCommentCnt] andImg:[UIImage imageNamed:@"btn_reply1z_topic.png"] andButtonType:kButtonTypeTwo];
    [replayBtn setIconFrame:CGRectMake(0, 0, 20, 20)];

    
   
    
    CGRect frame = contentView.frame;
    if (![reply.RTitle isEqualToString:@""]) {
        [title_label setText:reply.RTitle];
        frame.size.height += 28;
        frame.origin.y = ViewHeight(headerView);
        contentView.frame = frame;
    }
    if (_reply.TID == [[Forum sharedInstance] onTopic].TID){
        if (_reply.voted) {
            [likeBtn setEnabled:NO];
            [likeBtn setTitle:[NSString stringWithFormat:@"%d",reply.RVoteCnt] andImg:[UIImage imageNamed:@"btn_like1_topic.png"] andButtonType:kButtonTypeTwo];
            [likeBtn setIconFrame:CGRectMake(0, 0, 20, 20)];
        }else{
            [likeBtn setEnabled:YES];
            [likeBtn setTitle:[NSString stringWithFormat:@"%d",reply.RVoteCnt] andImg:[UIImage imageNamed:@"btn_like2_topic.png"] andButtonType:kButtonTypeTwo];
            [likeBtn setIconFrame:CGRectMake(0, 0, 20, 20)];
        }

    }else{
        [likeBtn setEnabled:NO];
        [replayBtn setEnabled:NO];
    }
    
    
    SetViewLeftUp(footerView, 0, ViewY(contentView) +ViewHeight(contentView));
    
}

- (void)replayBtnPressed
{
    [[MainTabBarController sharedMainViewController] setIsReply:YES];
    PostNotification(Noti_BottomInputViewShow,_reply);
    
}



- (void)likeBtnPressed
{
    
    if (!_reply.voted) {
        [_reply vote];
    }
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)scanMore
{
    [[Forum sharedInstance] removeDelegateObject:self];
    AllWordsPopViewController *moreReplayVC  =[[ AllWordsPopViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:moreReplayVC.view];
    [moreReplayVC setControlBtnType:kOnlyCloseButton];
    [moreReplayVC setTitle:@"所有留言"];
    [moreReplayVC setReplay:_reply];
    [moreReplayVC setDelegate:self];
    [moreReplayVC show];
}



+ (CGFloat)heightForReply:(Reply *)reply andIsMyTopic:(BOOL)isMytopic andTopicType:(TopicType)type
{
    
    float h = 64+88 +8;
    if (![reply.RTitle isEqualToString:@""]) {
        h += 28;
    }
  
    switch (type) {
        case TopicType_Photo:
             h += [PhotoTopicCell heightForReply:reply andIsMyTopic:isMytopic andTopicType:type];
            break;
        case TopicType_Text:
            h += [TextTopicCell heightForReply:reply andIsMyTopic:isMytopic andTopicType:type];
            break;
        default:
            break;
    }

    if (isMytopic) {
        h += 32;
    }
    return h;
   
}

//点赞成功
- (void)topicReplyVoted:(Reply *)reply
{

    if (reply != _reply) {
        return;
    }
    if (_reply.voted) {
        [likeBtn setEnabled:NO];
        [likeBtn setTitle:[NSString stringWithFormat:@"%d",_reply.RVoteCnt] andImg:[UIImage imageNamed:@"btn_like1_topic.png"] andButtonType:kButtonTypeTwo];
        [likeBtn setIconFrame:CGRectMake(0, 0, 20, 20)];
    }else{
        [likeBtn setEnabled:YES];
        [likeBtn setTitle:[NSString stringWithFormat:@"%d",_reply.RVoteCnt] andImg:[UIImage imageNamed:@"btn_like2_topic.png"] andButtonType:kButtonTypeTwo];
        [likeBtn setIconFrame:CGRectMake(0, 0, 20, 20)];
    }

   
    
}

//点赞失败
- (void)topicReplyVoteFailed:(Reply *)reply
{
    _reply = reply;

}


//更多话题回复加载成功。
- (void)topicRepliesLoadedMore:(Topic *)topic
{

  
    [topicNameLabel setText:topic.TTitle];
}

//更多话题回复加载失败。（可能是网络问题或者全部加载完毕，根据topic.noMore判断）
- (void)topicRepliesLoadFailed:(Topic *)topic
{

}

//更多评论加载成功
- (void)replyCommentsLoadedMore:(Reply *)reply
{
    
    if ([[reply comments] count] != 0) {
        [relayExample setText:[[[reply comments] objectAtIndex:0] CContent]];

    }
}

//更多评论加载失败 注意根据noMore判断是否是因为全部加载完
- (void)replyCommentsLoadFailed:(Reply *)reply
{

}


@end
