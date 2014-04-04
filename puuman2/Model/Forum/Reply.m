//
//  Reply.m
//  puuman2
//
//  Created by Declan on 14-3-18.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "UniverseConstant.h"
#import "Reply.h"
#import "DateFormatter.h"
#import "Forum.h"
#import "UserInfo.h"
#import "Comment.h"

#define Tag_Vote_Req            1
#define Tag_LoadComment_Req     2
#define Tag_UploadComment_Req   3

@implementation Reply

@synthesize RID = _RID;
@synthesize TID = _TID;
@synthesize UID = _UID;
@synthesize RTitle = _RTitle;
@synthesize RVoteCnt = _RVoteCnt;
@synthesize RCreateTime = _RCreateTime;
@synthesize textUrls = _textUrls;
@synthesize photoUrls = _photoUrls;
@synthesize voted = _voted;
@synthesize data = _data;

@synthesize comments = _comments;

- (void)setData:(NSDictionary *)data
{
    _data = data;
    for (NSString *key in [data keyEnumerator]) {
        id val = [data valueForKey:key];
        if ([key isEqualToString:@"RID"]) {
            _RID = [val integerValue];
        } else if ([key isEqualToString:@"TID"]) {
            _TID = [val integerValue];
        } else if ([key isEqualToString:@"UID"]) {
            _UID = [val integerValue];
        } else if ([key isEqualToString:@"RTitle"]) {
            _RTitle = val;
        } else if ([key isEqualToString:@"RCommentCnt"]) {
            _RCommentCnt = [val integerValue];
        } else if ([key isEqualToString:@"RVoteCnt"]) {
            _RVoteCnt = [val integerValue];
        }else if ([key isEqualToString:@"RCreateTime"]) {
            _RCreateTime = [DateFormatter datetimeFromString:val withFormat:@"yyyy-MM-dd HH:mm:ss"];
        } else if ([key isEqualToString:@"RContent"]) {
            _textUrls = [val valueForKey:Reply_Content_Text];
            _photoUrls = [val valueForKey:Reply_Content_Photo];
        } else if ([key isEqualToString:@"voted"]) {
            _voted = [val boolValue];
        }
    }
    _comments = [[NSMutableArray alloc] init];
}

- (void)vote
{
    if (_voted) return;
    for (PumanRequest *req in _reqs) {
        if (req.tag == Tag_Vote_Req) return;
    }
    PumanRequest * req = [[PumanRequest alloc] init];
    req.tag = Tag_Vote_Req;
    [_reqs addObject:req];
    req.urlStr = kUrl_VoteReply;
    [req setIntegerParam:[UserInfo sharedUserInfo].UID forKey:@"UID"];
    [req setIntegerParam:_RID forKey:@"RID"];
    req.delegate = self;
    [req postAsynchronous];
}

- (void)getMoreComments:(NSInteger)cnt newDirect:(BOOL)dir
{
    for (PumanRequest *req in _reqs) {
        if (req.tag == Tag_LoadComment_Req) return;
    }
    PumanRequest * req = [[PumanRequest alloc] init];
    req.tag = Tag_LoadComment_Req;
    [_reqs addObject:req];
    req.urlStr = kUrl_GetReplyComment;
    [req setIntegerParam:_RID forKey:@"RID"];
    NSDate * boundDate = nil;
    Comment *boundComment = dir ? [_comments firstObject] : [_comments lastObject];
    if (boundComment) {
        boundDate = boundComment.CCreateTime;
    }
    if (boundDate) [req setValue:[DateFormatter timestampStrFromDatetime:boundDate] forKey:@"boundDate"];
    [req setIntegerParam:dir forKey:@"dir"];
    [req setIntegerParam:cnt forKey:@"limit"];
    [req setResEncoding:PumanRequestRes_JsonEncoding];
    req.delegate = self;
    [req postAsynchronous];
}

- (void)comment:(NSString *)content
{
    for (PumanRequest *req in _reqs) {
        if (req.tag == Tag_UploadComment_Req) return;
    }
    PumanRequest * req = [[PumanRequest alloc] init];
    req.tag = Tag_UploadComment_Req;
    [_reqs addObject:req];
    req.urlStr = kUrl_UploadReplyComment;
    [req setIntegerParam:_RID forKey:@"RID"];
    [req setIntegerParam:[UserInfo sharedUserInfo].UID forKey:@"UID"];
    [req setParam:content forKey:@"CContent"];
    [req setResEncoding:PumanRequestRes_JsonEncoding];
    req.delegate = self;
    [req postAsynchronous];
}

- (void)requestEnded:(AFBaseRequest *)afRequest
{
    switch (afRequest.tag) {
        case Tag_Vote_Req:
        {
            switch (afRequest.result) {
                case PumanRequest_Succeeded:
                    _voted = YES;
                    [[Forum sharedInstance] informDelegates:@selector(topicReplyVoted:) withObject:self];
                    break;
                case 1:
                    //duplicated vote
                    _voted = YES;
                    [[Forum sharedInstance] informDelegates:@selector(topicReplyVoteFailed:) withObject:self];
                    break;
                default:
                    [[Forum sharedInstance] informDelegates:@selector(topicReplyVoteFailed:) withObject:self];
                    break;
            }
        }
            break;
        case Tag_LoadComment_Req:
        {
            if (afRequest.result == PumanRequest_Succeeded && afRequest.resObj) {
                NSArray *ret = afRequest.resObj;
                NSInteger cnt = [ret count];
                BOOL dir = [[afRequest.params valueForKey:@"dir"] boolValue];
                if (cnt < [[afRequest.params valueForKey:@"limit"] integerValue] && !dir) _noMore = YES;
                if (!_comments) {
                    _comments = [[NSMutableArray alloc] init];
                }
                for (NSDictionary * commentData in ret) {
                    Comment *co = [[Comment alloc] init];
                    [co setData:commentData];
                    if (dir) [_comments insertObject:co atIndex:0];
                    else [_comments addObject:co];
                }
                [[Forum sharedInstance] informDelegates:@selector(replyCommentsLoadedMore:) withObject:self];
            } else {
                [[Forum sharedInstance] informDelegates:@selector(replyCommentsLoadFailed:) withObject:self];
            }
        }
            break;
        case Tag_UploadComment_Req:
        {
            if (afRequest.result == PumanRequest_Succeeded && afRequest.resObj
                && [afRequest.resObj isKindOfClass:[NSDictionary class]]) {
                NSDictionary * data = afRequest.resObj;
                Comment *co = [[Comment alloc] init];
                [co setData:data];
                [_comments insertObject:co atIndex:0];
                [[Forum sharedInstance] informDelegates:@selector(replyCommentUploaded:) withObject:self];
            } else {
                [[Forum sharedInstance] informDelegates:@selector(replyCommentUploadFailed:) withObject:self];
            }
        }
        default:
            break;
    }
    [_reqs removeObject:afRequest];
}

@end
