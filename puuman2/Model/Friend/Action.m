//
//  Action.m
//  puuman2
//
//  Created by Declan on 14-3-28.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "DateFormatter.h"
#import "Action.h"

@implementation Action

- (void)setData:(NSDictionary *)data
{
    _data = data;
    _AID = [[data valueForKey:@"AID"] integerValue];
    _GID = [[data valueForKey:@"GID"] integerValue];
    _AType = [[data valueForKey:@"AType"] integerValue];
    _ASourceUID = [[data valueForKey:@"ASourceUID"] integerValue];
    _ATargetBID = [[data valueForKey:@"ATargetBID"] integerValue];
    _AMeta = [data valueForKey:@"AMeta"];
    _ACreateTime = [DateFormatter datetimeFromTimestampStr:[data valueForKey:@"ACreateTime"]];
}

@end
