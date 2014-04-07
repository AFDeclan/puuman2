//
//  Reply.h
//  puuman2
//
//  Created by Declan on 14-3-18.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PumanRequest.h"

@interface Reply : NSObject <AFRequestDelegate>
{
    NSMutableSet *_reqs;
}

//回复ID
@property (assign, nonatomic, readonly) NSInteger RID;
//话题TID
@property (assign, nonatomic, readonly) NSInteger TID;
//作者UID
@property (assign, nonatomic, readonly) NSInteger UID;
//标题
@property (retain, nonatomic, readonly) NSString * RTitle;
//创建时间
@property (retain, nonatomic, readonly) NSDate * RCreateTime;
//评论数量
@property (assign, nonatomic, readonly) NSInteger RCommentCnt;
//点赞数量
@property (assign, nonatomic, readonly) NSInteger RVoteCnt;
//是否被当前用户点过赞
@property (assign, nonatomic, readonly) BOOL voted;

@property (retain, nonatomic, readonly) NSArray * textUrls;
@property (retain, nonatomic, readonly) NSArray * photoUrls;

@property (retain, nonatomic) NSDictionary *data;

//已获取的评论列表
@property (retain, nonatomic, readonly) NSMutableArray * comments;
//是否获取了全部的历史评论列表
@property (assign, nonatomic, readonly) bool noMore;

//获取更多评论 如果已经在获取不会发起新的请求，返回No
- (BOOL)getMoreComments:(NSInteger)cnt newDirect:(BOOL)dir;

//发表评论 如果上次评论还在上传，不会发起新的请求，返回No
- (BOOL)comment:(NSString *)content;


//点赞，注意如果voted为YES说明已经赞过，此方法直接返回。
- (void)vote;

@end
