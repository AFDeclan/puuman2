//
//  ErrorLog.m
//  puman
//
//  Created by 祁文龙 on 13-12-4.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "ErrorLog.h"
#import "UniverseConstant.h"
#import <ASIHTTPRequest.h>

@implementation ErrorLog

+ (void)errorLog:(NSString *)log fromFile:(NSString *)fileName error:(NSError *)error
{
    NSString *label = [NSString stringWithFormat:@"%@ %@ Error:%@", fileName, log, error.debugDescription];
    [MobClick event:umeng_event_errorLog label:label];
    NSLog(@"%@", label);
}

+ (void)requestFailedLog:(ASIHTTPRequest *)request fromFile:(NSString *)fileName
{
    NSString *label = [NSString stringWithFormat:@"%@ Url:%@ Res:%@ Error:%@", fileName, request.url.description, request.responseString, request.error.description];
    NSLog(@"%@", label);
    [MobClick event:umeng_event_requestFailed label:label];

}

@end
