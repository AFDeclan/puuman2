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

@implementation Group

- (void)setData:(NSDictionary *)data
{
    _data = data;
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
                [_GMember addObject:mem];
            }
        }
    }
}

- (Member *)memberWithBid:(NSInteger)bid
{
    for (Member *m in _GMember) {
        if (m.BID == bid) return m;
    }
    return nil;
}

@end
