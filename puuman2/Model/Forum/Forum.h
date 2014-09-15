//
//  Forum.h
//  puuman model
//
//  Created by Declan on 14-3-18.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PumanRequest.h"
#import "Topic.h"

#define Reply_Content_Text      @"text"
#define Reply_Content_Photo     @"photo"

@class Topic;
@class ReplyForUpload;
@class Reply;

@protocol ForumDelegate <NSObject>

@optional

//当期话题信息获取成功。
- (void)activeTopicReceived;

//当期话题信息获取失败。
- (void)activeTopicFailed;

//更多投票中话题获取成功
- (void)votingTopicLoadedMore;

//更多投票中话题获取失败
- (void)votingTopicLoadFailed;

//往期话题获取成功。
- (void)topicReceived:(Topic *)topic;

//往期话题获取失败
- (void)topicFailed:(NSString *)TNo;

//更多话题回复加载成功。
- (void)topicRepliesLoadedMore:(Topic *)topic;

//更多话题回复加载失败。（可能是网络问题或者全部加载完毕，根据topic.noMore判断）
- (void)topicRepliesLoadFailed:(Topic *)topic;

- (void)myRepliesLoadedMore;

- (void)myRepliesLoadFailed;

//奖品与排行
- (void)rankAwardReceived;
- (void)rankAwardFailed;

//新话题上传成功
- (void)topicUploaded;

//新话题上传失败
- (void)topicUploadFailed;

//新话题超过5个
- (void)topicUploadFull;

//话题投票成功
- (void)topicVoted:(Topic *)topic;

//话题投票失败，注意根据voted判断是否是因为重复投票
- (void)topicVoteFailed:(Topic *)topic;

//回复上传成功
- (void)topicReplyUploaded:(ReplyForUpload *)reply;

//回复上传失败
- (void)topicReplyUploadFailed:(ReplyForUpload *)reply;

//点赞成功
- (void)topicReplyVoted:(Reply *)reply;

//点赞失败
- (void)topicReplyVoteFailed:(Reply *)reply;
/*
    注意判断reply.voted，如果为YES，说明是因为重复点赞失败。
 */

//更多评论加载成功
- (void)replyCommentsLoadedMore:(Reply *)reply;

//更多评论加载失败 注意根据noMore判断是否是因为全部加载完
- (void)replyCommentsLoadFailed:(Reply *)reply;

//评论上传成功
- (void)replyCommentUploaded:(Reply *)reply;

//评论上传失败
- (void)replyCommentUploadFailed:(Reply *)reply;

@end

//votingTopic
#define VotingTopicOrderModeCnt  2
typedef enum VotingTopicOrder {
    VotingTopicOrder_Time = 0,
    VotingTopicOrder_Vote = 1,
} VotingTopicOrder;


@interface Forum : NSObject <AFRequestDelegate>
{
    NSMutableSet * _requests;
    NSMutableSet * _repliesForUpload;
    NSMutableArray * _votingTopic[VotingTopicOrderModeCnt];
    NSMutableDictionary * _topicsForNo, *_topicsForId;
}

//当期话题
@property (nonatomic, retain, readonly) Topic * onTopic;
//我参与的
@property (retain, nonatomic, readonly) NSMutableArray * myReplies;
@property (assign, nonatomic, readonly) BOOL noMore;

//奖品与排行
//array of Award order by ALevel asc
@property (retain, nonatomic, readonly) NSMutableArray * awards;
//array of Rank order by TotalCnt ( CCnt + VCnt) desc
@property (retain, nonatomic, readonly) NSMutableArray * ranks;

@property (retain, nonatomic, readonly) NSMutableSet * delegates;



+ (Forum *)sharedInstance;
+ (void)releaseInstance;

- (void)addDelegateObject:(id<ForumDelegate>)object;
- (void)removeDelegateObject:(id<ForumDelegate>)object;
- (void)removeAllDelegates;
//获取当期话题，异步操作。
- (void)getActiveTopic;

//投票中的话题
- (NSArray *)votingTopic:(VotingTopicOrder)order;
- (BOOL)getMoreVotingTopic:(NSInteger)cnt orderBy:(VotingTopicOrder)order newDirect:(BOOL)dir;

//按期号获取，若已获取过则直接返回，否则返回nil，异步等待回调。
- (Topic *)getTopic:(NSInteger)TNo;

//dir 为YES时为获取更新的回复，获取的结果插在myReplies的头，为NO时为获取更早的回复，获取结果插在myReplies尾。
- (BOOL)getMoreMyReplies:(NSInteger)cnt newDirect:(BOOL)dir;

//获取奖品和排行
- (void)getAwardAndRank;

//上传新话题 若之前的上传请求未完成则不会上传，返回NO
- (BOOL)uploadNewTopic:(NSString *)TTitle detail:(NSString *)TDetail type:(TopicType)TType;

//新建一个自动引用和释放的ReplyForUpload对象
- (ReplyForUpload *)createReplyForUpload;
   
#pragma mark --------------interface end-------------------
//内部回调方法，对外部不开放。
- (void)informDelegates:(SEL)sel withObject:(id)obj;
- (void)replyUploaded:(ReplyForUpload *)reply;
- (void)replyUploadFailed:(ReplyForUpload *)reply;

@end
