//
//  ActionForUpload.m
//  puuman model
//
//  Created by Declan on 14-3-29.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ActionForUpload.h"
#import "UniverseConstant.h"
#import "Group.h"
#import "Friend.h"

@implementation ActionForUpload

@synthesize ACreateTime = _ACreateTime;

- (void)upload
{
    if (_req) return;
    _req = [[PumanRequest alloc] init];
    _req.urlStr = kUrl_UploadAction;
    [_req setIntegerParam:self.group.GID forKey:@"GID"];
    [_req setIntegerParam:self.AType forKey:@"AType"];
    [_req setIntegerParam:self.ASourceUID forKey:@"ASourceUID"];
    [_req setIntegerParam:self.ATargetBID forKey:@"ATargetBID"];
    [_req setParam:self.AMeta forKey:@"AMeta"];
    [_req setDelegate:self];
    [_req postAsynchronous];
    _ACreateTime = [NSDate date];
}

- (void)requestEnded:(AFBaseRequest *)afRequest
{
    if (_req.result == PumanRequest_Succeeded) {
        [self.group actionUploadSuc:self];
    } else {
        [self.group actionUploadFail:self];
    }
}

@end
