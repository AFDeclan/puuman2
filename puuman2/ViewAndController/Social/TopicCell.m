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
#import "TextTopicCell.h"
#import "PhotoTopicCell.h"
#import "SinglePhotoTopicVIew.h"
#import "UserInfo.h"
#import "Comment.h"
#import "BabyData.h"
#import "Group.h"



@implementation TopicCell
@synthesize isMyTopic = _isMyTopic;
@synthesize row = _row;
@synthesize unfold = _unfold;
@synthesize delegate = _delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
      
        commentNum = 0;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        headerView = [[UIView alloc] init];
        [self.contentView addSubview:headerView];
        contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 608, 112)];
        [self.contentView addSubview:contentView];
        footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 176, 608, 40)];
        [self.contentView addSubview:footerView];
        [self initWithHeaderView];
        [headerView setBackgroundColor:PMColor5];
        [contentView setBackgroundColor:PMColor5];
        [footerView setBackgroundColor:PMColor5];
        self.layer.masksToBounds = YES;
        [MyNotiCenter addObserver:self selector:@selector(showCommentView:) name:Noti_ShowCommentPopView object:nil];
    }
    return self;
}

- (void)initWithHeaderView
{
  
    infoView = [[BasicInfoView alloc] init];
    [self.contentView addSubview:infoView];
   

    info_time = [[UILabel alloc] initWithFrame:CGRectMake(464, 16, 128, 12)];
    [info_time setTextAlignment:NSTextAlignmentRight];
    [info_time setTextColor:PMColor3];
    [info_time setFont:PMFont3];
    [info_time setBackgroundColor:[UIColor clearColor]];
    [headerView addSubview:info_time];
    
    headTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 608, 32)];
    [headerView addSubview:headTitleView];
    topicNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 512, 32)];
    [topicNameLabel setFont:PMFont2];
    [topicNameLabel setTextColor:PMColor2];
    [topicNameLabel setBackgroundColor:[UIColor clearColor]];
    [headTitleView addSubview:topicNameLabel];
    topicNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(534, 0, 64, 32)];
    [topicNumLabel setTextAlignment:NSTextAlignmentRight];
    [topicNumLabel setFont:PMFont2];
    [topicNumLabel setBackgroundColor:[UIColor clearColor]];
    [headTitleView addSubview:topicNumLabel];
    
    
    title_label = [[UILabel alloc] initWithFrame:CGRectMake(56, 48, 512, 16)];
    [title_label setTextColor:PMColor1];
    [title_label setFont:PMFont2];
    [title_label setBackgroundColor:[UIColor clearColor]];
    [title_label setAlpha:0];
    [headerView addSubview:title_label];

    
    replayBtn = [[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 304, 40)];
    [replayBtn addTarget:self action:@selector(replayBtnPressed) forControlEvents:UIControlEventTouchUpInside];

    
    likeBtn = [[AFTextImgButton alloc] initWithFrame:CGRectMake(304, 0, 304, 40)];
    [likeBtn addTarget:self action:@selector(likeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [likeBtn.title setFont:PMFont2];
    [likeBtn setBackgroundColor:PMColor5];
    [likeBtn setIconSize:CGSizeMake(20, 20)];
    
    [footerView addSubview:replayBtn];
    [footerView addSubview:likeBtn];
    
    relayExample = [[UILabel alloc] initWithFrame:CGRectMake(16, 40, 496, 48)];
    [relayExample setFont:PMFont3];
    [relayExample setTextColor:PMColor2];
    [relayExample setBackgroundColor:[UIColor clearColor]];
    [footerView addSubview:relayExample];
    [footerView.layer setMasksToBounds:YES];
    comment = [[TopicCommentView alloc] initWithFrame:CGRectMake(0, 40, 608, 0)];
    [footerView addSubview:comment];
    

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
        SetViewLeftUp(contentView, 0, 96);
      
        
    }else{
        [headerView setFrame:CGRectMake(0, 0, 608, 64)];
        [headTitleView setAlpha:0];
        SetViewLeftUp(info_time, 464, 16);
        SetViewLeftUp(infoView, 0, 0);
        SetViewLeftUp(contentView, 0, 64);
      
    }
}









- (void)buildWithReply:(Reply *)reply
{
    commentNum = [[reply comments] count];
    [comment setCommentWithReply:reply];

    
     _reply = reply;
    [topicNumLabel setText:[NSString stringWithFormat:@"第%d期",reply.TID]];
    
    [[Forum sharedInstance] addDelegateObject:self];
    [infoView setInfoWithUid:_reply.UID andIsTopic:YES];
    
//    if ([reply RCommentCnt] == 0) {
//        [scanMoreReplay setTitle:@"没有留言" andImg:nil andButtonType:kButtonTypeOne];
//    }else{
//        [scanMoreReplay setTitle:@"查看留言" andImg:nil andButtonType:kButtonTypeOne];
//
//    }
//    [scanMoreReplay setTitleFont:PMFont3];
//
//    [scanMoreReplay adjustLayout];
 
    if (_isMyTopic) {
        Topic *topic =  [[Forum sharedInstance] getTopic:reply.TID];
        if (topic) {
            [topicNameLabel setText:topic.TTitle];
            if (topic.TUploadUID == [UserInfo sharedUserInfo].UID) {
                [headTitleView setBackgroundColor:PMColor6];
                [topicNumLabel setTextColor:[UIColor whiteColor]];
            }else{
                [headTitleView setBackgroundColor:PMColor3];
                [topicNumLabel setTextColor:PMColor2];
            }

        }
        SetViewLeftUp(title_label, 56, 80);
    }else{
        SetViewLeftUp(title_label, 56, 48);

    }

    [replayBtn.title setText:[NSString stringWithFormat:@"%d",reply.RCommentCnt]];
    [replayBtn.title setFont:PMFont2];
    [replayBtn setBackgroundColor:PMColor5];
    [replayBtn setIconImg:[UIImage imageNamed:@"btn_reply1z_topic.png"]];
    [replayBtn setIconSize:CGSizeMake(20, 20)];
    [replayBtn adjustLayout];
    
    CGRect frame = headerView.frame;
    if (![reply.RTitle isEqualToString:@""]) {
        [title_label setAlpha:1];
        [title_label setText:reply.RTitle];
        frame.size.height += 28;
        headerView.frame = frame;
        SetViewLeftUp(contentView, 0, ViewHeight(headerView));
    }else{
       [title_label setAlpha:0];
    }
    if (_reply.TID == [[Forum sharedInstance] onTopic].TID){
       
        [likeBtn.title setText:[NSString stringWithFormat:@"%d",reply.RCommentCnt]];


        if (_reply.voted) {
            [likeBtn setEnabled:NO];
            [likeBtn setIconImg:[UIImage imageNamed:@"btn_like1_topic.png"]];
        }else{
            [likeBtn setEnabled:YES];
        }
        [likeBtn adjustLayout];

    }else{
        [likeBtn setEnabled:NO];
        [replayBtn setEnabled:NO];
    }
    
    
    SetViewLeftUp(footerView, 0, ViewY(contentView) +ViewHeight(contentView));
    
}

- (void)replayBtnPressed
{
    _unfold = !_unfold;
    [_delegate changedStausWithUnfold:_unfold andIndex:_row];
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



//- (void)removeForumDelegate
//{
//    [[Forum sharedInstance] removeDelegateObject:self];
//}

+ (CGFloat)heightForReply:(Reply *)reply andIsMyTopic:(BOOL)isMytopic andTopicType:(TopicType)type andUnfold:(BOOL)unfold
{

    if (unfold) {
        if ([reply.comments count] <= 5 && [reply.comments count] < reply.RCommentCnt){
            [reply getMoreComments:5 newDirect:YES];
        }
        TopicCommentView *commentView = [[TopicCommentView alloc] init];
        [commentView setCommentWithReply:reply];
        return [TopicCell heightForReply:reply andIsMyTopic:isMytopic andTopicType:type]+ViewHeight(commentView);

    }else{
        return  [TopicCell heightForReply:reply andIsMyTopic:isMytopic andTopicType:type];
    }
}

+ (CGFloat)heightForReply:(Reply *)reply andIsMyTopic:(BOOL)isMytopic andTopicType:(TopicType)type
{
    
    float h = 64+40 +8;
    if (![reply.RTitle isEqualToString:@""]) {
        h += 28;
    }
  
    switch (type) {
        case TopicType_Photo:
        {
            if ([[reply photoUrls] count] > 1) {
                h += [PhotoTopicCell heightForReply:reply andIsMyTopic:isMytopic andTopicType:type];
            }else{
                h += [SinglePhotoTopicVIew heightForReply:reply andIsMyTopic:isMytopic andTopicType:type];

            }
        }
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
        [likeBtn setIconImg:[UIImage imageNamed:@"btn_like1_topic.png"]];

    }else{
        [likeBtn setEnabled:YES];
        [likeBtn setIconImg:[UIImage imageNamed:@"btn_like2_topic.png"]];

    }
    [likeBtn adjustLayout];
   
    
}

//点赞失败
- (void)topicReplyVoteFailed:(Reply *)reply
{
   

}



//往期话题获取成功。
- (void)topicReceived:(Topic *)topic
{
    if (topic.TID == _reply.TID ) {
        [topicNameLabel setText:topic.TTitle];
        if (topic.TUploadUID == [UserInfo sharedUserInfo].UID) {
            [headTitleView setBackgroundColor:PMColor6];
            [topicNumLabel setTextColor:[UIColor whiteColor]];
        }else{
            [headTitleView setBackgroundColor:PMColor3];
            [topicNumLabel setTextColor:PMColor2];
        }
    }
}

//往期话题获取失败
- (void)topicFailed:(NSString *)TNo
{
    
}


////更多评论加载成功
//- (void)replyCommentsLoadedMore:(Reply *)reply
//{
//    
//    if (_reply == reply) {
//        if ([[reply comments] count] != 0) {
//            [relayExample setText:[[[reply comments] objectAtIndex:0] CContent]];
//            
//        }
//    }
//  
//}
//
////更多评论加载失败 注意根据noMore判断是否是因为全部加载完
//- (void)replyCommentsLoadFailed:(Reply *)reply
//{
//
//}

- (void)setUnfold:(BOOL)unfold
{
    CGRect frameF = footerView.frame;
    _unfold = unfold;
    if (unfold) {
       
        frameF.size.height = ViewHeight(comment)+40;
    
    }else{
        frameF.size.height = 40;
    }
    [footerView setFrame:frameF];
}

//更多评论加载成功
- (void)replyCommentsLoadedMore:(Reply *)reply
{
    if (_reply == reply) {
        PostNotification(Noti_RefreshTopicTable, nil);
    }
}


//评论上传成功
- (void)replyCommentUploaded:(Reply *)reply
{
    
    
    if (_reply == reply) {
        if ([_reply.comments count] <= 6 && commentNum <[[reply comments] count]) {
            PostNotification(Noti_RefreshTopicTable, nil);

        }
    }
}



//更多评论加载失败 注意根据noMore判断是否是因为全部加载完
- (void)replyCommentsLoadFailed:(Reply *)reply
{

}

- (void)showCommentView:(NSNotification *)notification
{
    if ([notification class]) {
        [[Forum sharedInstance] removeDelegateObject:self];
    }else{
        [[Forum sharedInstance] addDelegateObject:self];

    }
}
@end
