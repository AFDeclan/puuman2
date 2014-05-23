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
#import "Topic.h"
#import "TopicCommentView.h"

@protocol TopicCellDelegate;
@interface TopicCell : UITableViewCell<ForumDelegate,PopViewDelegate>
{
    BasicInfoView *infoView;
    UILabel *info_time;
    UIView *headerView;
    UIView *contentView;
    UIView *footerView;
    AFTextImgButton *likeBtn;
    AFTextImgButton *replayBtn;
    UILabel *relayExample;
    UILabel *title_label;
    Reply *_reply;
    UIView *headTitleView;
    UILabel *topicNameLabel;
    UILabel *topicNumLabel;
    Member *_member;
    TopicCommentView *comment;
    NSInteger commentNum;
}
@property(nonatomic,assign)BOOL isMyTopic;
@property(nonatomic,assign)NSInteger row;
@property(nonatomic,assign)BOOL unfold;
@property(nonatomic,assign)id<TopicCellDelegate> delegate;
- (void)buildWithReply:(Reply *)reply;
+ (CGFloat)heightForReply:(Reply *)reply andIsMyTopic:(BOOL)isMytopic andTopicType:(TopicType)type;
+ (CGFloat)heightForReply:(Reply *)reply andIsMyTopic:(BOOL)isMytopic andTopicType:(TopicType)type andUnfold:(BOOL)unfold;

@end

@protocol TopicCellDelegate <NSObject>

- (void)changedStausWithUnfold:(BOOL)unfold andIndex:(NSInteger)index;

@end