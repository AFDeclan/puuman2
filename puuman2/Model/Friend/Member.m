//
//  Member.m
//  puuman2
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
    _GID = [[data valueForKey:@"GID"] integerValue];
    _BID = [[data valueForKey:@"BID"] integerValue];
    _JoinTime = [DateFormatter datetimeFromTimestampStr:[data valueForKey:@"JoinTime"]];
    _UIDs = [data valueForKey:@"UIDs"];
    NSDictionary * baseInfo = [data valueForKey:@"BaseInfo"];
    if ([baseInfo isKindOfClass:[NSDictionary class]]) {
        _BabyNick = [baseInfo valueForKey:uMeta_nickName];
        _BabyBirth = [DateFormatter dateFromString:[baseInfo valueForKey:uMeta_birthDate]];
        _BabyIsBoy = [[baseInfo valueForKey:uMeta_gender] isEqualToString:@"男宝宝"];
        _BabyPortraitUrl = [baseInfo valueForKey:uMeta_portraitUrl];
        _BabyHeight = [[baseInfo valueForKey:@"BabyHeight"] doubleValue];
        _BabyWeight = [[baseInfo valueForKey:@"BabyWeight"] doubleValue];
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
