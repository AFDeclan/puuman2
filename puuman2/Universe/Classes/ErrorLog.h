//
//  ErrorLog.h
//  puman
//
//  Created by 祁文龙 on 13-12-4.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIHTTPRequest;

@interface ErrorLog : NSObject

+ (void)errorLog:(NSString *)log fromFile:(NSString *)fileName error:(NSError *)error;

+ (void)requestFailedLog:(ASIHTTPRequest *)request fromFile:(NSString *)fileName;

@end
