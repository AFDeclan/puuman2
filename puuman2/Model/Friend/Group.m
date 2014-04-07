//
//  Group.m
//  puuman2
//
//  Created by Declan on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "Group.h"
#import "DateFormatter.h"
#import "Member.h"
#import "Friend.h"
#import "ActionForUpload.h"
#import "UserInfo.h"
#import "ActionManager.h"

@implementation Group

- (void)setData:(NSDictionary *)data
{
    _data = data;
    _isMy = NO;
    for (NSString *key in [data keyEnumerator]) {
        id val = [data objectForKey:key];
        if ([key isEqualToString:@"GID"]) {
            _GID = [val integerValue];
        } else if ([key isEqualToString:@"GName"]) {
            _GName = val;
        } else if ([key isEqualToString:@"GCreateTime"]) {
            _GCreateTime = [DateFormatter datetimeFromTimestampStr:val];
        } else if ([key isEqualToString:@"GMember"]) {
            NSArray * msdata = val;
            _GMember = [[NSMutableArray alloc] init];
            for (NSDictionary * mdata in msdata) {
                Member *mem = [[Member alloc] init];
                [mem setData:mdata];
                if (mem.BID == [UserInfo sharedUserInfo].BID) {
                    _isMy = YES;
                }
                [_GMember addObject:mem];
            }
        }
    }
    if (_isMy) [self loadActions];
}

- (Member *)memberWithBid:(NSInteger)bid
{
    for (Member *m in _GMember) {
        if (m.BID == bid) return m;
    }
    return nil;
}

- (ActionForUpload *)createAction
{
    ActionForUpload *action = [[ActionForUpload alloc] init];
    action.group = self;
    action.ASourceUID = [UserInfo sharedUserInfo].UID;
    action.ATargetBID = [UserInfo sharedUserInfo].BID;
    action.AMeta = @"";
    if (!_actionForUps) _actionForUps = [[NSMutableSet alloc] init];
    [_actionForUps addObject:action];
    return action;
}

- (ActionForUpload *)actionForInvite:(NSInteger)bid
{
    ActionForUpload *act = [self createAction];
    act.AType = ActionType_Invite;
    act.ATargetBID = bid;
    return act;
}

- (ActionForUpload *)actionForJoin
{
    ActionForUpload *act = [self createAction];
    act.AType = ActionType_Join;
    if (_GID == 0) {
        Member *inviteMember = (Member *)[_GMember objectAtIndex:0];
        NSInteger bid = inviteMember.BID;
        act.AMeta = [NSString stringWithFormat:@"%d", bid];
    }
    return act;
}

- (ActionForUpload *)actionForRenameGroup:(NSString *)newName
{
    ActionForUpload *act = [self createAction];
    act.AType = ActionType_Rename;
    act.AMeta = newName;
    return act;
}

- (ActionForUpload *)actionForSendMsg:(NSString *)msg
{
    ActionForUpload *act = [self createAction];
    act.AType = ActionType_Msg;
    act.AMeta = msg;
    return act;
}

- (ActionForUpload *)actionForRemove:(NSInteger)bid
{
    ActionForUpload *act = [self createAction];
    act.AType = ActionType_Remove;
    act.ATargetBID = bid;
    return act;
}

- (ActionForUpload *)actionForQuit
{
    ActionForUpload *act = [self createAction];
    act.AType = ActionType_Quit;
    return act;
}

- (void)startUpdateAction
{
    if (_updateTimer) return;
    [self updateAction];
    _updateTimer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(updateAction) userInfo:nil repeats:YES];
}

- (void)stopUpdateAction
{
    [_updateTimer invalidate];
    _updateTimer = nil;
}

#pragma mark --

- (void)updateAction
{
    if (_req) return;
    _req = [[PumanRequest alloc] init];
    _req.urlStr = kUrl_UpdateAction;
    _req.resEncoding = PumanRequestRes_JsonEncoding;
    [_req setIntegerParam:_GID forKey:@"GID"];
    NSString *latestUpdate = @"1971-01-01 00:00:00";
    for (int i=_GAction.count-1; i>=0; i--) {
        id act = [_GAction objectAtIndex:i];
        if ([act isMemberOfClass:[Action class]]) {
            Action *action = (Action *)act;
            latestUpdate = [DateFormatter timestampStrFromDatetime:action.ACreateTime];
            break;
        }
    }
    [_req setParam:latestUpdate forKey:@"LatestUpdate"];
    _req.delegate = self;
    [_req postAsynchronous];
}

- (void)loadActions
{
    _GAction = [[NSMutableArray alloc] initWithArray:[[ActionManager sharedInstance] actionsForGroup:_GID]];
    _GMsgs = [[NSMutableArray alloc] initWithArray:[[ActionManager sharedInstance] msgsForGroup:_GID]];
    _GLatestAction = [[ActionManager sharedInstance] latestActionForGroup:_GID];
}

- (void)requestEnded:(AFBaseRequest *)afRequest
{
    if (afRequest.result == PumanRequest_Succeeded) {
        id obj = afRequest.resObj;
        if ([obj isKindOfClass:[NSArray class]]) {
            NSArray * newActionsData = (NSArray *)obj;
            if ([newActionsData count] == 0) return;
            for (NSDictionary *data in newActionsData) {
                Action *act = [[Action alloc] init];
                [act setData:data];
                [[ActionManager sharedInstance] addAction:act forGroup:_GID];
            }
            [self loadActions];
            [[Friend sharedInstance] informDelegates:@selector(actionUpdated:) withObject:self];
        }
    }
    _req = nil;
}

#pragma mark --

- (void)actionUploadFail:(ActionForUpload *)action
{
    [[Friend sharedInstance] informDelegates:@selector(actionUploadFailed:) withObject:action];
    [_actionForUps removeObject:action];
}

- (void)actionUploadSuc:(ActionForUpload *)action
{
    switch (action.AType) {
        case ActionType_Rename:
            _GName = action.AMeta;
            break;
        case ActionType_Remove:
            for (Member *m in _GMember) {
                if (m.BID == action.ATargetBID) {
                    [_GMember removeObject:m];
                    break;
                }
            }
            break;
        default:
            break;
    }
    [_GAction addObject:action];
    if (action.AType == ActionType_Msg) {
        [_GMsgs addObject:action];
    } else {
        _GLatestAction = action;
    }
    [[Friend sharedInstance] informDelegates:@selector(actionUploaded:) withObject:action];
    [_actionForUps removeObject:action];
}


@end
