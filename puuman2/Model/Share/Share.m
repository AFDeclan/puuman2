//
//  Share.m
//  puuman2
//
//  Created by Declan on 14-6-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "Share.h"
#import "DateFormatter.h"

static NSInteger _reqRet;

@implementation Share

+ (NSInteger)reqRet
{
    return _reqRet;
}

+ (NSString *)shareUrlForDiary:(Diary *)diary
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_ShareDiary;
    [request setParam:[NSNumber numberWithInteger:[UserInfo sharedUserInfo].UID] forKey:@"UID"];
    [request setParam:[DateFormatter stringFromDatetime:diary.DCreateTime] forKey:@"DCreateTime"];
    [request setTimeOutSeconds:5];
    [request postSynchronous];
    _reqRet = request.result;
    if (request.result == PumanRequest_Succeeded) {
        return request.resObj;
    } else return nil;
}

+ (NSString *)shareUrlForPuuman
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_SharePuuman;
    [request setParam:[NSNumber numberWithInteger:[UserInfo sharedUserInfo].UID] forKey:@"UID"];
    [request setTimeOutSeconds:5];
    [request postSynchronous];
    _reqRet = request.result;
    if (request.result == PumanRequest_Succeeded) {
        return request.resObj;
    } else return nil;
}

+ (NSString *)shareUrlForMeasure
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_ShareMeasure;
    [request setParam:[NSNumber numberWithInteger:[UserInfo sharedUserInfo].UID] forKey:@"UID"];
    [request setTimeOutSeconds:5];
    [request postSynchronous];
    _reqRet = request.result;
    if (request.result == PumanRequest_Succeeded) {
        return request.resObj;
    } else return nil;
}

@end
