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

@implementation Member

- (void)setData:(NSDictionary *)data
{
    _data = data;
    _GID = [[data valueForKey:@"GID"] integerValue];
    _BID = [[data valueForKey:@"BID"] integerValue];
    _JoinTime = [DateFormatter datetimeFromTimestampStr:[data valueForKey:@"JoinTime"]];
    NSDictionary * baseInfo = [data valueForKey:@"BaseInfo"];
    if ([baseInfo isKindOfClass:[NSDictionary class]]) {
        _BabyNick = [baseInfo valueForKey:uMeta_nickName];
        _BabyBirth = [DateFormatter dateFromString:[baseInfo valueForKey:uMeta_birthDate]];
        _BabyIsBoy = [[baseInfo valueForKey:uMeta_gender] isEqualToString:@"男宝宝"];
        _BabyPortraitUrl = [baseInfo valueForKey:uMeta_portraitUrl];
    }
    NSDictionary * detailInfo = [data valueForKey:@"DetailInfo"];
    if ([detailInfo isKindOfClass:[NSDictionary class]]) {
        
    }
}

@end
