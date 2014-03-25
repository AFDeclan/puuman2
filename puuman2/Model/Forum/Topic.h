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

@class Reply;
@class PumanRequest;

@interface Topic : NSObject <AFRequestDelegate>
{
    NSInteger _roffset;
    PumanRequest *_request, *_voteReq;
}

//话题ID
@property (assign, nonatomic, readonly) NSInteger   TID;
//话题期号
@property (assign, nonatomic, readonly) NSInteger   TNo;
//话题标题
@property (retain, nonatomic, readonly) NSString *  TTitle;
//话题详情
@property (retain, nonatomic, readonly) NSString *  TDetail;
//话题状态
@property (assign, nonatomic, readonly) TopicStatus TStatus;
//创建时间
@property (retain, nonatomic, readonly) NSDate *    TCreateTime;
//只有当TStatus为Voting时有效，本用户是否已投过
@property (assign, nonatomic, readonly) BOOL voted;
//Meta信息
@property (retain, nonatomic, readonly) NSMutableDictionary *meta;

@property (retain, nonatomic) NSDictionary * data;

//已获取的话题回复的列表
@property (retain, nonatomic, readonly) NSMutableArray * replies;
//是否获取了全部的回复列表
@property (assign, nonatomic, readonly) bool noMore;

- (void)getMoreReplies:(NSInteger)cnt;
//只有当TStatus为Voting时有效
- (void)vote;

@end
