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

@implementation Topic

@synthesize TID = _TID;
@synthesize TNo = _TNo;
@synthesize TTitle = _TTitle;
@synthesize TDetail = _TDetail;
@synthesize TStatus = _TStatus;
@synthesize TCreateTime = _TCreateTime;
@synthesize meta = _meta;
@synthesize data = _data;

@synthesize replies = _replies;
@synthesize noMore = _noMore;

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
        } else if ([key isEqualToString:@"TTitle"]) {
            _TTitle = val;
        } else if ([key isEqualToString:@"TDetail"]) {
            _TDetail = val;
        } else if ([key isEqualToString:@"TStatus"]) {
            _TStatus = [val integerValue];
        } else if ([key isEqualToString:@"TCreateTime"]) {
            _TCreateTime = [DateFormatter datetimeFromString:val withFormat:@"yyyy-MM-dd HH:mm:ss"];
        } else {
            [_meta setValue:val forKey:key];
        }
    }
    _replies = [[NSMutableArray alloc] init];
    _roffset = 0;
    _noMore = YES;
}

- (void)getMoreReplies:(NSInteger)cnt;
{
    if (_request || _noMore) return;
    _request = [[PumanRequest alloc] init];
    [_request setUrlStr:kUrl_GetTopicReply];
    [_request setIntegerParam:_roffset forKey:@"offset"];
    [_request setIntegerParam:cnt forKey:@"limit"];
    [_request setIntegerParam:_TID forKey:@"TID"];
    [_request setDelegate:self];
    [_request setResEncoding:PumanRequestRes_JsonEncoding];
    [_request postAsynchronous];
}

- (void)requestEnded:(AFBaseRequest *)afRequest
{
    if (afRequest.result == PumanRequest_Succeeded && afRequest.resObj) {
        NSArray *ret = afRequest.resObj;
        NSInteger cnt = [ret count];
        _roffset += cnt;
        if (cnt < [[afRequest.params valueForKey:@"limit"] integerValue]) _noMore = YES;
        for (NSDictionary * replyData in ret) {
            Reply *re = [[Reply alloc] init];
            [re setData:replyData];
            [_replies addObject:re];
        }
    }
    if (afRequest.result == 2) {
        _noMore = YES;
    }
    _request = nil;
}

@end
