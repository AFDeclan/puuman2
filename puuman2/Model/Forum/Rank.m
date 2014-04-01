//
//  Rank.m
//  puuman2
//
//  Created by Declan on 14-4-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "Rank.h"

@implementation Rank

- (void)setData:(NSDictionary *)data
{
    _BID = [[data valueForKey:@"BID"] integerValue];
    _VCnt = [[data valueForKey:@"VCnt"] integerValue];
    _CCnt = [[data valueForKey:@"CCnt"] integerValue];
}

@end
