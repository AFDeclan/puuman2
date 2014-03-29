//
//  Friend.m
//  puuman2
//
//  Created by Declan on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "Friend.h"
#import "PumanRequest.h"
#import "UserInfo.h"
#import "Group.h"

#define Tag_Req_GroupInfo       1

static Friend * instance;

@implementation Friend

@synthesize inGroup = _inGroup;
@synthesize myGroup = _myGroup;
@synthesize invitedGroup = _invitedGroup;
@synthesize inviteFrom = _inviteFrom;

@synthesize delegates = _delegates;

+ (Friend *)sharedInstance
{
    if (!instance) {
        instance = [[Friend alloc] init];
    }
    return instance;
}

+ (void)releaseInstance
{
    instance = nil;
}

#pragma mark - Delegate

- (void)addDelegateObject:(id<FriendDelegate>)object
{
    if (!_delegates) {
        _delegates = [[NSMutableSet alloc] init];
    }
    [_delegates addObject:object];
}

- (void)removeDelegateObject:(id<FriendDelegate>)object
{
    [_delegates removeObject:object];
}

- (void)informDelegates:(SEL)sel withObject:(id)obj
{
    for (NSObject<FriendDelegate> * del in _delegates) {
        if ([del respondsToSelector:sel]) {
            [del performSelectorOnMainThread:sel withObject:obj waitUntilDone:YES];
        }
    }
}

- (void)getGroupData
{
    for (PumanRequest * req in _requests) {
        if (req.tag == Tag_Req_GroupInfo) return;
    }
    PumanRequest *req = [[PumanRequest alloc] init];
    [req setIntegerParam:[UserInfo sharedUserInfo].BID forKey:@"BID"];
    [req setResEncoding:PumanRequestRes_JsonEncoding];
    [req setDelegate:self];
    [req setTag:Tag_Req_GroupInfo];
    [_requests addObject:req];
    [req postAsynchronous];
}

- (void)requestEnded:(AFBaseRequest *)afRequest
{
    switch (afRequest.tag) {
        case Tag_Req_GroupInfo:
        {
            NSInteger result = afRequest.result;
            id obj = afRequest.resObj;
            if (result == PumanRequest_Succeeded && [obj isKindOfClass:[NSDictionary class]]) {
                _inGroup = [[obj objectForKey:@"inGroup"] boolValue];
                if (_inGroup) {
                    _myGroup = [[Group alloc] init];
                    [_myGroup setData:[obj objectForKey:@"myGroup"]];
                } else {
                    _invitedGroup = [[NSMutableArray alloc] init];
                    _inviteFrom = [[NSMutableArray alloc] init];
                    NSArray *invites = [obj objectForKey:@"invites"];
                    if (![invites isKindOfClass:[NSArray class]]) {
                        [self informDelegates:@selector(groupDataFailed) withObject:nil];
                        return;
                    }
                    for (NSDictionary * inviteData in invites) {
                        Group * inviteGroup = [[Group alloc] init];
                        [inviteGroup setData:[inviteData objectForKey:@"Group"]];
                        [_invitedGroup addObject:inviteGroup];
                        NSInteger inviteBid = [[inviteData objectForKey:@"fromBID"] integerValue];
                        Member *inviteMem = [inviteGroup memberWithBid:inviteBid];
                        if (inviteMem) {
                            [_inviteFrom addObject:inviteMem];
                        } else {
                            [self informDelegates:@selector(groupDataFailed) withObject:nil];
                            return;
                        }
                        
                    }
                }
                [self informDelegates:@selector(groupDataReceived) withObject:nil];
            } else {
                [self informDelegates:@selector(groupDataFailed) withObject:nil];
            }
            break;
        }
        default:
            break;
    }
}

@end
