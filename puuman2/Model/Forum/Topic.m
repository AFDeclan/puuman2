//
//  Topic.m
//  puuman2
//
//  Created by Declan on 14-3-18.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "Topic.h"
#import "DateFormatter.h"
#import "PumanRequest.h"
#import "Reply.h"
#import "UniverseConstant.h"
#import "UserInfo.h"
#import "Forum.h"

@implementation Topic

- (void)setData:(NSDictionary *)data
{
    _data = data;
    _meta = [[NSMutableDictionary alloc] init];
    for (NSString *key in [data keyEnumerator]) {
        id val = [data valueForKey:key];
        if ([key isEqualToString:@"TID"]) {
            _TID = [val integerValue];
        } else if ([key isEqualToString:@"TNo"]) {
            _TNo = [val integerValue];
        } else if ([key isEqualToString:@"TType"]) {
            _TType = [val integerValue];
        } else if ([key isEqualToString:@"TTitle"]) {
            _TTitle = val;
        } else if ([key isEqualToString:@"TDetail"]) {
            _TDetail = val;
        } else if ([key isEqualToString:@"TImgUrl"]) {
            _TImgUrl = val;
        } else if ([key isEqualToString:@"TStatus"]) {
            _TStatus = [val integerValue];
        } else if ([key isEqualToString:@"TUploadUID"]) {
            _TUploadUID = [val integerValue];
        } else if ([key isEqualToString:@"TCreateTime"]) {
            _TCreateTime = [DateFormatter datetimeFromString:val withFormat:@"yyyy-MM-dd HH:mm:ss"];
        } else if ([key isEqualToString:@"voted"]) {
            _voted = [val boolValue];
        } else if ([key isEqualToString:@"VoteCnt"]) {
            _voteCnt = [val integerValue];
        } else if ([key isEqualToString:@"RIDs"]) {
            NSArray *allRids = val;
            for (int i=0; i<allRids.count; i++) {
                if (i >= TopicReplyOrderModeCnt) break;
                _rids[i] = [allRids objectAtIndex:i];
            }
        } else {
            [_meta setValue:val forKey:key];
        }
    }
    for (int i=0; i<TopicReplyOrderModeCnt; i++) {
        _replies[i] = [[NSMutableArray alloc] init];
    }
    _roffset = 0;
}

- (void)cacheReply:(Reply *)reply
{
    if (!_downloadedReplies) {
        _downloadedReplies = [[NSMutableDictionary alloc] init];
    }
    [_downloadedReplies setValue:reply forKey:[NSString stringWithFormat:@"%ld", (long)reply.RID]];
}

- (Reply *)getReply:(NSInteger)rid
{
    return [_downloadedReplies valueForKey:[NSString stringWithFormat:@"%ld", (long)rid]];
}

- (BOOL)getMoreReplies:(NSInteger)cnt orderBy:(TopicReplyOrder)order newDirect:(BOOL)dir
{
    if (_request[order]) return NO;
    _request[order] = [[PumanRequest alloc] init];
    [_request[order] setUrlStr:kUrl_GetTopicReply];
    [_request[order] setIntegerParam:order forKey:@"order"];
    [_request[order] setIntegerParam:dir forKey:@"dir"];
    [_request[order] setIntegerParam:cnt forKey:@"limit"];
    [_request[order] setIntegerParam:_TID forKey:@"TID"];
    Reply *boundReply;
    if (_replies[order].count > 0) {
        boundReply = dir ? [_replies[order] firstObject] : [_replies[order] lastObject];
    }
    if (boundReply) {
        [_request[order] setIntegerParam:boundReply.RID forKey:@"boundRID"];
    } else {
        [_request[order] setValue:@"" forKey:@"boundRID"];
    }
    [_request[order] setIntegerParam:[UserInfo sharedUserInfo].UID forKey:@"UID"];
    [_request[order] setDelegate:self];
    [_request[order] setResEncoding:PumanRequestRes_JsonEncoding];
    _request[order].tag = order;
    [_request[order] postAsynchronous];
    return YES;
}

- (NSArray *)replies:(TopicReplyOrder)order
{
    return _replies[order];
}

- (void)vote
{
    if (_voteReq || _voted) return;
    _voteReq = [[PumanRequest alloc] init];
    _voteReq.urlStr = kUrl_VoteTopic;
    [_voteReq setIntegerParam:[UserInfo sharedUserInfo].UID forKey:@"UID"];
    [_voteReq setIntegerParam:_TID forKey:@"TID"];
    [_voteReq setDelegate:self];
    [_voteReq postAsynchronous];
}

- (void)requestEnded:(AFBaseRequest *)afRequest
{
    if ([afRequest.urlStr isEqualToString:kUrl_GetTopicReply]) {
        NSInteger order = [[afRequest.params objectForKey:@"order"] integerValue];
        if (afRequest.result == PumanRequest_Succeeded && [afRequest.resObj isKindOfClass:[NSArray class]]) {
            NSArray *ret = afRequest.resObj;
            BOOL dir = [[afRequest.params valueForKey:@"dir"] boolValue];
            for (NSDictionary * replyData in ret) {
                Reply *re = [[Reply alloc] init];
                [re setData:replyData];
                Reply *cached = [self getReply:re.RID];
                if (cached) {
                    [_replies[order] removeObject:cached];
                }
                [self cacheReply:re];
                if (dir) {
                    [_replies[order] insertObject:re atIndex:0];
                } else {
                    [_replies[order] addObject:re];
                }
            }
            [[Forum sharedInstance] informDelegates:@selector(topicRepliesLoadedMore:) withObject:self];
        } else {
            [[Forum sharedInstance] informDelegates:@selector(topicRepliesLoadFailed:) withObject:self];
        }
        _request[order] = nil;
    } else {
        if (afRequest.result == PumanRequest_Succeeded) {
            _voted = YES;
            _voteCnt ++;
            [[Forum sharedInstance] informDelegates:@selector(topicVoted:) withObject:self];
        } else {
            if (afRequest.result == 1) {
                _voted = YES;
            }
            [[Forum sharedInstance] informDelegates:@selector(topicVoteFailed:) withObject:self];
        }
        _voteReq = nil;
    }
}

@end
