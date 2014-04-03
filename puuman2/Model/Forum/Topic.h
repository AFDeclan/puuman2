//
//  Topic.h
//  puuman2
//
//  Created by Declan on 14-3-18.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PumanRequest.h"

typedef enum TopicStatus {
    TopicStatus_Voting = 0,
    TopicStatus_On = 1,
    TopicStatus_Past = 2,
} TopicStatus;

typedef enum TopicType {
    TopicType_Text = 0,
    TopicType_Photo = 1,
} TopicType;

//reply 排序方式
#define TopicReplyOrderModeCnt  2
typedef enum TopicReplyOrder {
    TopicReplyOrder_Time = 0,
    TopicReplyOrder_Vote = 1,
} TopicReplyOrder;

@class Reply;
@class PumanRequest;

@interface Topic : NSObject <AFRequestDelegate>
{
    NSInteger _roffset;
    PumanRequest *_request[TopicReplyOrderModeCnt], *_voteReq;
    NSMutableArray * _replies[TopicReplyOrderModeCnt];
    NSArray * _rids[TopicReplyOrderModeCnt];
    NSMutableDictionary * _downloadedReplies;
}

//话题ID
@property (assign, nonatomic, readonly) NSInteger   TID;
//话题期号
@property (assign, nonatomic, readonly) NSInteger   TNo;
//话题类别
@property (assign, nonatomic, readonly) TopicType   TType;
//话题标题
@property (retain, nonatomic, readonly) NSString *  TTitle;
//话题详情
@property (retain, nonatomic, readonly) NSString *  TDetail;
//图片Url
@property (retain, nonatomic, readonly) NSString *  TImgUrl;
//话题状态
@property (assign, nonatomic, readonly) TopicStatus TStatus;
//创建时间
@property (retain, nonatomic, readonly) NSDate *    TCreateTime;
//只有当TStatus为Voting时有效，本用户是否已投过
@property (assign, nonatomic, readonly) BOOL voted;
//只有当TStatus为Voting时有效，投票总数
@property (assign, nonatomic, readonly) NSInteger voteCnt;
//Meta信息
@property (retain, nonatomic, readonly) NSMutableDictionary *meta;

@property (retain, nonatomic) NSDictionary * data;

//已获取的话题回复的列表
- (NSArray *)replies:(TopicReplyOrder)order;
//是否获取了全部的回复列表
- (BOOL)noMoreReplies:(TopicReplyOrder)order;

//获取更多回复
- (void)getMoreReplies:(NSInteger)cnt orderBy:(TopicReplyOrder)order;
//只有当TStatus为Voting时有效
- (void)vote;

@end
