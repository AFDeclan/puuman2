//
//  Forum.h
//  puuman2
//
//  Created by Declan on 14-3-18.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PumanRequest.h"

@class Topic;

@protocol ForumDelegate <NSObject>

@optional

//当期话题和投票中话题信息获取成功。
- (void)activeTopicsReceived;

//当期话题和投票中话题信息获取失败。
- (void)activeTopicsFailed;

//往期话题获取成功。
- (void)topicReceived:(Topic *)topic;

//往期话题获取失败
- (void)topicFailed:(NSString *)TNo;

//更多话题回复加载成功。
- (void)topicRepliesLoadedMore:(Topic *)topic;

//更多话题回复加载失败。（可能是网络问题或者全部加载完毕，根据topic.noMore判断）
- (void)topicRepliesLoadFailed:(Topic *)topic;

@end

@interface Forum : NSObject <AFRequestDelegate>
{
    NSMutableSet * _requests;
}

//当期话题
@property (nonatomic, retain, readonly) Topic * onTopic;
//投票中的话题
@property (nonatomic, retain, readonly) NSMutableArray * votingTopic;
//以期号为索引
@property (nonatomic, retain, readonly) NSMutableDictionary * topics;

@property (retain, nonatomic, readonly) NSMutableSet * delegates;

+ (Forum *)sharedInstance;

- (void)addDelegateObject:(id<ForumDelegate>)object;
- (void)removeDelegateObject:(id<ForumDelegate>)object;

//获取当期和投票中话题，异步操作。
- (void)getActiveTopics;

//按期号获取，若已获取过则直接返回，否则返回nil，异步等待回调。
- (Topic *)getTopic:(NSInteger)TNo;


#pragma mark --------------interface end-------------------
//Topic类回调方法，对外部不开放。
- (void)repliesLoaded:(Topic *)topic;
- (void)repliesFailed:(Topic *)topic;

@end
