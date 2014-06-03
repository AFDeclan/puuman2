//
//  ShareVideo.m
//  puuman2
//
//  Created by Declan on 14-5-29.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ShareVideo.h"
#import "PumanRequest.h"
#import "UniverseConstant.h"

@implementation ShareVideo

- (void)initWithData:(NSDictionary *)data
{
    _shareUrl = [data valueForKey:@"ShareUrl"];
    _videoUrl = [data valueForKey:@"VideoUrl"];
    id tp = [data valueForKey:@"RID"];
    if ([tp respondsToSelector:@selector(integerValue)])
        _RID = [tp integerValue];
}

- (BOOL)toDiscard
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_VideoDiscard;
    [request setParam:[NSNumber numberWithInteger:_RID] forKey:@"RID"];
    [request setTimeOutSeconds:5];
    [request postSynchronous];
    return request.result == PumanRequest_Succeeded;
}

- (BOOL)toShare
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_VideoShare;
    [request setParam:[NSNumber numberWithInteger:_RID] forKey:@"RID"];
    [request setTimeOutSeconds:5];
    [request postSynchronous];
    return request.result == PumanRequest_Succeeded;

}

@end
