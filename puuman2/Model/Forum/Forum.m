//
//  Forum.m
//  puuman2
//
//  Created by Declan on 14-3-18.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//
#import "UniverseConstant.h"
#import "Forum.h"
#import "Topic.h"
#import "Reply.h"
#import "ReplyForUpload.h"
#import "UserInfo.h"
#import "Rank.h"
#import "Award.h"
#import "DateFormatter.h"

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

+ (void)releaseInstance
{
    instance = nil;
}

- (id)init
{
    if (self = [super init]) {
        _topics = [[NSMutableDictionary alloc] init];
        _votingTopic = [[NSMutableArray alloc] init];
        _requests = [[NSMutableSet alloc] init];
        _repliesForUpload = [[NSMutableSet alloc] init];
        _myReplies = [[NSMutableArray alloc] init];
        _noMore = NO;
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
    [req setIntegerParam:[UserInfo sharedUserInfo].UID forKey:@"UID"];
    [req setDelegate:self];
    [req setResEncoding:PumanRequestRes_JsonEncoding];
    [req postAsynchronous];
}

- (Topic *)getTopic:(NSInteger)TNo
{
    Topic * cached = [_topics valueForKey:[NSString stringWithFormat:@"%ld", (long)TNo]];
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

- (void)getAwardAndRank
{
    for (PumanRequest *req in _requests) {
        if ([[req urlStr] isEqualToString:kUrl_GetAwardRank])
            return;
    }
    PumanRequest *req = [[PumanRequest alloc] init];
    [_requests addObject:req];
    [req setUrlStr:kUrl_GetAwardRank];
    [req setDelegate:self];
    [req setResEncoding:PumanRequestRes_JsonEncoding];
    [req postAsynchronous];
}

- (BOOL)uploadNewTopic:(NSString *)TTitle detail:(NSString *)TDetail type:(TopicType)TType
{
    for (PumanRequest *req in _requests) {
        if ([[req urlStr] isEqualToString:kUrl_UploadTopic])
            return NO;
    }
    PumanRequest *req = [[PumanRequest alloc] init];
    [_requests addObject:req];
    [req setUrlStr:kUrl_UploadTopic];
    [req setIntegerParam:[UserInfo sharedUserInfo].UID forKey:@"TUploadUID"];
    [req setParam:TTitle forKey:@"TTitle"];
    [req setParam:TDetail forKey:@"TDetail"];
    [req setIntegerParam:TType forKey:@"TType"];
    [req setDelegate:self];
    [req postAsynchronous];
    return YES;
}

- (ReplyForUpload *)createReplyForUpload
{
    ReplyForUpload *re = [[ReplyForUpload alloc] init];
    [re setTID:_onTopic.TID];
    [_repliesForUpload addObject:re];
    return re;
}

- (void)getMoreMyReplies:(NSInteger)cnt newDirect:(BOOL)dir
{
    for (PumanRequest *req in _requests) {
        if ([[req urlStr] isEqualToString:kUrl_GetMyReply])
            return;
    }
    PumanRequest * req = [[PumanRequest alloc] init];
    [req setUrlStr:kUrl_GetTopicReply];
    NSDate * boundDate = nil;
    Reply *boundReply = dir ? [_myReplies firstObject] : [_myReplies lastObject];
    if (boundReply) {
        boundDate = boundReply.RCreateTime;
    }
    if (boundDate) [req setValue:[DateFormatter timestampStrFromDatetime:boundDate] forKey:@"boundDate"];
    else [req setParam:@"" forKey:@"boundDate"];
    [req setIntegerParam:dir forKey:@"dir"];
    [req setIntegerParam:cnt forKey:@"limit"];
    [req setIntegerParam:[UserInfo sharedUserInfo].UID forKey:@"UID"];
    [req setDelegate:self];
    [req setResEncoding:PumanRequestRes_JsonEncoding];
    [req postAsynchronous];
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
    } else if ([url isEqualToString:kUrl_GetActiveTopics]) {
        id retArr = afRequest.resObj;
        if (!retArr || ![retArr isKindOfClass:[NSArray class]]) {
            [self informDelegates:@selector(activeTopicsFailed) withObject:nil];
        } else {
            _votingTopic = [[NSMutableArray alloc] init];
            for (NSDictionary *ret in retArr) {
                Topic *topic = [[Topic alloc] init];
                [topic setData:ret];
                if (topic.TStatus == TopicStatus_On) {
                    _onTopic = topic;
                    [_topics setObject:topic forKey:[NSString stringWithFormat:@"%ld", (long)topic.TNo]];
                } else if (topic.TStatus == TopicStatus_Voting) {
                    [_votingTopic addObject:topic];
                }
            }
            [self informDelegates:@selector(activeTopicsReceived) withObject:nil];
        }
    } else if ([url isEqualToString:kUrl_UploadTopic]) {
        if (afRequest.result == PumanRequest_Succeeded) {
            [self informDelegates:@selector(topicUploaded) withObject:nil];
        } else {
            [self informDelegates:@selector(topicUploadFailed) withObject:nil];
        }
    } else if ([url isEqualToString:kUrl_GetMyReply]) {
        if (afRequest.result == PumanRequest_Succeeded && [afRequest.resObj isKindOfClass:[NSArray class]]) {
            NSArray *ret = afRequest.resObj;
            BOOL dir = [[afRequest.params valueForKey:@"dir"] boolValue];
            if ([ret count] == 0 && !dir) {
                _noMore = YES;
            }
            for (NSDictionary * replyData in ret) {
                Reply *re = [[Reply alloc] init];
                [re setData:replyData];
                if (dir) [_myReplies insertObject:re atIndex:0];
                else [_myReplies addObject:re];
            }
            [[Forum sharedInstance] informDelegates:@selector(myRepliesLoadedMore) withObject:nil];
        } else {
            [[Forum sharedInstance] informDelegates:@selector(myRepliesLoadFailed) withObject:nil];
        }
    } else if ([url isEqualToString:kUrl_GetAwardRank]) {
        if (afRequest.result == PumanRequest_Succeeded && [afRequest.resObj isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dic = afRequest.resObj;
            NSArray * ranksData = [dic valueForKey:@"rank"];
            _ranks = [[NSMutableArray alloc] init];
            for (NSDictionary *data in ranksData) {
                Rank * r = [[Rank alloc] init];
                [r setData:data];
                [_ranks addObject:r];
            }
            NSArray * awardsData = [dic valueForKey:@"award"];
            _awards = [[NSMutableArray alloc] init];
            for (NSDictionary * data in awardsData) {
                Award * a = [[Award alloc] init];
                [a setData:data];
                [_awards addObject:a];
            }
            [self informDelegates:@selector(rankAwardReceived) withObject:nil];
        } else {
            [self informDelegates:@selector(rankAwardFailed) withObject:nil];
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

- (void)informDelegates:(SEL)sel withObject:(id)obj
{
    NSSet *dels = [_delegates copy];
    for (NSObject<ForumDelegate> * del in dels) {
        if ([del respondsToSelector:sel]) {
            [del performSelectorOnMainThread:sel withObject:obj waitUntilDone:YES];
        }
    }
}

#pragma mark - Recall

- (void)replyUploaded:(ReplyForUpload *)reply
{
    [self informDelegates:@selector(topicReplyUploaded:) withObject:reply];
    [_repliesForUpload removeObject:reply];
}

- (void)replyUploadFailed:(ReplyForUpload *)reply
{
    [self informDelegates:@selector(topicReplyUploadFailed:) withObject:reply];
    [_repliesForUpload removeObject:reply];
}

@end
