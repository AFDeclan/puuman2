//
//  DateFormatter.m
//  puman
//
//  Created by 陈晔 on 13-8-30.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "DateFormatter.h"

@implementation DateFormatter

+ (NSString *)stringFromDatetime:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Harbin"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    return [formatter stringFromDate:date];
}

+ (NSString *)timestampStrFromDatetime:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Harbin"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];
}

+ (NSDate *)datetimeFromString:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Harbin"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    return [formatter dateFromString:dateStr];
}

+ (NSDate *)datetimeFromString:(NSString *)dateStr withFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Harbin"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateStr];
}

+ (NSDate *)datetimeFromTimestampStr:(NSString *)dateStr
{
    if (!dateStr) return nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Harbin"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter dateFromString:dateStr];
}

+ (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Harbin"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:date];
}

+ (NSString *)stringFromDate2:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Harbin"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM"];
    return [formatter stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Harbin"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter dateFromString:dateStr];
}

@end
