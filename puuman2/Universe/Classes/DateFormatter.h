//
//  DateFormatter.h
//  puman
//
//  Created by 陈晔 on 13-8-30.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatter : NSObject

+ (NSString *)stringFromDatetime:(NSDate *)date;

+ (NSString *)timestampStrFromDatetime:(NSDate *)date;

+ (NSDate *)datetimeFromString:(NSString *)dateStr;

+ (NSDate *)datetimeFromString:(NSString *)dateStr withFormat:(NSString *)format;

+ (NSDate *)datetimeFromTimestampStr:(NSString *)dateStr;

+ (NSString *)stringFromDate:(NSDate *)date;

+ (NSString *)stringFromDate2:(NSDate *)date;

+ (NSDate *)dateFromString:(NSString *)dateStr;

@end
