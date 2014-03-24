//
//  Reply.m
//  puuman2
//
//  Created by Declan on 14-3-18.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "Reply.h"
#import "DateFormatter.h"
#import "Forum.h"

@implementation Reply

@synthesize TID = _TID;
@synthesize UID = _UID;
@synthesize RTitle = _RTitle;
@synthesize RCreateTime = _RCreateTime;
@synthesize textUrls = _textUrls;
@synthesize photoUrls = _photoUrls;
@synthesize data = _data;

- (void)setData:(NSDictionary *)data
{
    _data = data;
    for (NSString *key in [data keyEnumerator]) {
        id val = [data valueForKey:key];
        if ([key isEqualToString:@"TID"]) {
            _TID = [val integerValue];
        } else if ([key isEqualToString:@"UID"]) {
            _UID = [val integerValue];
        } else if ([key isEqualToString:@"RTitle"]) {
            _RTitle = val;
        } else if ([key isEqualToString:@"RCreateTime"]) {
            _RCreateTime = [DateFormatter datetimeFromString:val withFormat:@"yyyy-MM-dd HH:mm:ss"];
        } else if ([key isEqualToString:@"RContent"]) {
            _textUrls = [val valueForKey:Reply_Content_Text];
            _photoUrls = [val valueForKey:Reply_Content_Photo];
        }
    }
}

@end
