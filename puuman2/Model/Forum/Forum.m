//
//  Forum.m
//  puuman2
//
//  Created by Declan on 14-3-18.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "Forum.h"
#import "Topic.h"
#import "UniverseConstant.h"

static Forum * instance;

@implementation Forum

@synthesize onTopic = _onTopic;
@synthesize votingTopic = _votingTopic;
@synthesize topics = _topics;
@synthesize delegates = _delegates;

+ (Forum *)sharedInstance
{
    if (!instance) {
        instance = [[Forum alloc] init];
    }
    return instance;
}

- (id)init
{
    if (self = [super init]) {
        _topics = [[NSMutableDictionary alloc] init];
        _requests = [[NSMutableSet alloc] init];
    }
    return self;
}

#pragma mark - Interface Operation

- (void)getActiveTopics
{
    for (PumanRequest *req in _requests) {
        if ([[req urlStr] isEqualToString:kUrl_GetActiveTopics])
            return;
    }
    PumanRequest *req = [[PumanRequest alloc] init];
    [_requests addObject:req];
    [req setUrlStr:kUrl_GetActiveTopics];
    [req setDelegate:self];
    [req setResEncoding:PumanRequestRes_JsonEncoding];
    [req postAsynchronous];
}

- (Topic *)getTopic:(NSInteger)TNo
{
    Topic * cached = [_topics valueForKey:[NSString stringWithFormat:@"%d", TNo]];
    if (cached) {
        return cached;
    }
    for (PumanRequest *req in _requests) {
        if ([[req urlStr] isEqualToString:kUrl_GetTopic] &&
            [[[req params] objectForKey:@"TNo"] integerValue] == TNo)
            return nil;
    }
    PumanRequest *req = [[PumanRequest alloc] init];
    [_requests addObject:req];
    [req setUrlStr:kUrl_GetTopic];
    [req setIntegerParam:TNo forKey:@"TNo"];
    [req setDelegate:self];
    [req setResEncoding:PumanRequestRes_JsonEncoding];
    [req postAsynchronous];
    return nil;
}

#pragma mark - Request Call Back

- (void)requestEnded:(AFBaseRequest *)afRequest
{
    NSString *url = [afRequest urlStr];
    if ([url isEqualToString:kUrl_GetTopic]) {
        NSString *tnoStr = [[afRequest params] valueForKey:@"TNo"];
        id ret = afRequest.resObj;
        if (!ret || ![ret isKindOfClass:[NSDictionary class]]) {
            [self informDelegates:@selector(topicFailed:) withObject:tnoStr];
        } else {
            Topic *topic = [[Topic alloc] init];
            [topic setData:ret];
            [_topics setObject:topic forKey:tnoStr];
            [self informDelegates:@selector(topicReceived:) withObject:topic];
        }
    } else {
        id retArr = afRequest.resObj;
        if (!retArr || ![retArr isKindOfClass:[NSArray class]]) {
            [self informDelegates:@selector(activeTopicsFailed)];
        } else {
            for (NSDictionary *ret in retArr) {
                Topic *topic = [[Topic alloc] init];
                [topic setData:ret];
                if (topic.TStatus == TopicStatus_On) {
                    _onTopic = topic;
                    [_topics setObject:topic forKey:[NSString stringWithFormat:@"%d", topic.TNo]];
                } else if (topic.TStatus == TopicStatus_Voting) {
                    [_votingTopic addObject:topic];
                }
            }
            [self informDelegates:@selector(activeTopicsReceived)];
        }
    }
    [_requests removeObject:afRequest];
}

#pragma mark - Delegate

- (void)addDelegateObject:(id<ForumDelegate>)object
{
    if (!_delegates) {
        _delegates = [[NSMutableSet alloc] init];
    }
    [_delegates addObject:object];
}

- (void)removeDelegateObject:(id<ForumDelegate>)object
{
    [_delegates removeObject:object];
}

- (void)informDelegates:(SEL)sel
{
    for (id<ForumDelegate> del in _delegates) {
        if ([del respondsToSelector:sel]) {
            [del performSelector:sel];
        }
    }
}

- (void)informDelegates:(SEL)sel withObject:(id)obj
{
    for (id<ForumDelegate> del in _delegates) {
        if ([del respondsToSelector:sel]) {
            [del performSelector:sel withObject:obj];
        }
    }
}

#pragma mark - Topic Recall

- (void)repliesLoaded:(Topic *)topic
{
    [self informDelegates:@selector(topicRepliesLoadedMore:) withObject:topic];
}

- (void)repliesFailed:(Topic *)topic
{
    [self informDelegates:@selector(topicRepliesLoadFailed:) withObject:topic];
}



@end
