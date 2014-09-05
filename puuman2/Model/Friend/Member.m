//
//  Member.m
//  puuman model
//
//  Created by Declan on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "Member.h"
#import "DateFormatter.h"
#import "UniverseConstant.h"
#import "MemberCache.h"

@implementation Member

- (void)setData:(NSDictionary *)data
{
    _data = data;
    id tp = [data valueForKey:@"GID"];
    if (tp) _GID = [tp integerValue]; else _GID = 0;
    tp = [data valueForKey:@"BID"];
    if ([tp respondsToSelector:@selector(integerValue)]) _BID = [tp integerValue]; else _BID = 0;
    _JoinTime = [DateFormatter datetimeFromTimestampStr:[data valueForKey:@"JoinTime"]];
    _UIDs = [data valueForKey:@"UIDs"];
    NSDictionary * baseInfo = [data valueForKey:@"BaseInfo"];
    if ([baseInfo isKindOfClass:[NSDictionary class]]) {
        _babyInfo = [[BabyInfo alloc] init];
        [_babyInfo setWithDic:baseInfo];
        tp = [baseInfo valueForKey:@"BabyHeight"];
        if ([tp respondsToSelector:@selector(doubleValue)]) _BabyHeight = [tp doubleValue]; else _BabyHeight = 0;
        tp = [baseInfo valueForKey:@"BabyWeight"];
        if ([tp respondsToSelector:@selector(doubleValue)]) _BabyWeight = [tp doubleValue]; else _BabyWeight = 0;
        tp = [baseInfo valueForKey:@"BabyCorns"];
        if ([tp respondsToSelector:@selector(doubleValue)]) _BabyPuuman = [tp doubleValue]; else _BabyPuuman = 0;
    }
    NSDictionary * detailInfo = [data valueForKey:@"DetailInfo"];
    if ([detailInfo isKindOfClass:[NSDictionary class]]) {
        
    }
    [[MemberCache sharedInstance] cacheMember:self];
}

- (BOOL)belongsTo:(NSInteger)uid
{
    for (id uidObj in _UIDs) {
        if (uid == [uidObj integerValue]) {
            return YES;
        }
    }
    return NO;
}

@end
