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
        NSString *val = [data valueForKey:key];
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
        } else if ([key isEqualToString:@"TCreateTime"]) {
            _TCreateTime = [DateFormatter datetimeFromString:val withFormat:@"yyyy-MM-dd HH:mm:ss"];
        } else if ([key isEqualToString:@"voted"]) {
            _voted = [val boolValue];
        } else {
            [_meta setValue:val forKey:key];
        }
    }
    _replies = [[NSMutableArray alloc] init];
    _roffset = 0;
    _noMore = YES;
}

- (void)getMoreReplies:(NSInteger)cnt
{
  //  if (_request || _noMore) return;
    _request = [[PumanRequest alloc] init];
    [_request setUrlStr:kUrl_GetTopicReply];
    [_request setIntegerParam:_roffset forKey:@"offset"];
    [_request setIntegerParam:cnt forKey:@"limit"];
    [_request setIntegerParam:_TID forKey:@"TID"];
    [_request setIntegerParam:[UserInfo sharedUserInfo].UID forKey:@"UID"];
    [_request setDelegate:self];
    [_request setResEncoding:PumanRequestRes_JsonEncoding];
    [_request postAsynchronous];
}

- (void)vote
{
    if (_voteReq || _voted) return;
    _voteReq = [[PumanRequest alloc] init];
    [_voteReq setIntegerParam:[UserInfo sharedUserInfo].UID forKey:@"UID"];
    [_voteReq setIntegerParam:_TID forKey:@"TID"];
    [_voteReq setDelegate:self];
    [_voteReq postAsynchronous];
}

- (void)requestEnded:(AFBaseRequest *)afRequest
{
    if (afRequest == _request) {
        if (afRequest.result == PumanRequest_Succeeded && [afRequest.resObj isKindOfClass:[NSArray class]]) {
            NSArray *ret = afRequest.resObj;
            NSInteger cnt = [ret count];
            _roffset += cnt;
            if (cnt < [[afRequest.params valueForKey:@"limit"] integerValue]) _noMore = YES;
            for (NSDictionary * replyData in ret) {
                Reply *re = [[Reply alloc] init];
                [re setData:replyData];
                [_replies addObject:re];
            }
            [[Forum sharedInstance] informDelegates:@selector(topicRepliesLoadedMore:) withObject:self];
        } else {
            if (afRequest.result == 2) {
                _noMore = YES;
            }
            [[Forum sharedInstance] informDelegates:@selector(topicRepliesLoadFailed:) withObject:self];
        }
        _request = nil;
    } else {
        if (afRequest.result == PumanRequest_Succeeded) {
            _voted = YES;
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
