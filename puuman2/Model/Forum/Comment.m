//
//  Comment.m
//  puuman model
//
//  Created by Declan on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "Comment.h"
#import "DateFormatter.h"

@implementation Comment

@synthesize RID = _RID;
@synthesize UID = _UID;
@synthesize CContent = _CContent;
@synthesize CCreateTime = _CCreateTime;
@synthesize data = _data;

- (void)setData:(NSDictionary *)data
{
    _data = data;
    for (NSString *key in [data keyEnumerator]) {
        id val = [data valueForKey:key];
        if ([key isEqualToString:@"RID"]) {
            _RID = [val integerValue];
        } else if ([key isEqualToString:@"UID"]) {
            _UID = [val integerValue];
        } else if ([key isEqualToString:@"CContent"]) {
            _CContent = val;
        } else if ([key isEqualToString:@"CCreateTime"]) {
            _CCreateTime = [DateFormatter datetimeFromString:val withFormat:@"yyyy-MM-dd HH:mm:ss"];
        }
    }
}

@end
