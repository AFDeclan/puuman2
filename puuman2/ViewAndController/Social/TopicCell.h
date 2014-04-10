//
//  TopicCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"
#import "BasicInfoView.h"
#import "Reply.h"
#import "AFSelecedTextImgButton.h"
#import "ChatInputViewController.h"
#import "Forum.h"
#import "MemberCache.h"
#import "Friend.h"
#import "RecommendPartnerViewController.h"
#import "Topic.h"

@interface TopicCell : UITableViewCell<ForumDelegate,FriendDelegate,PopViewDelegate>
{
    BasicInfoView *infoView;
    UILabel *info_time;
    UIView *headerView;
    UIView *contentView;
    UIView *footerView;
    AFTextImgButton *likeBtn;
    AFTextImgButton *replayBtn;
    UILabel *relayExample;
    AFTextImgButton *scanMoreReplay;
    UILabel *title_label;
    Reply *_reply;
    UIButton *info_btn;
    BOOL hasInfoView;
    UIView *headTitleView;
    UILabel *topicNameLabel;
    UILabel *topicNumLabel;
    Member *_member;
}
@property(nonatomic,assign)BOOL isMyTopic;
@property(nonatomic,assign)NSInteger row;
- (void)buildWithReply:(Reply *)reply;
+ (CGFloat)heightForReply:(Reply *)reply andIsMyTopic:(BOOL)isMytopic andTopicType:(TopicType)type;
@end
