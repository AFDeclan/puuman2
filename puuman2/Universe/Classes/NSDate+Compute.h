//
//  NSDate+Compute.h
//  puman
//
//  Created by 陈晔 on 13-10-21.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(Compute)

+ (NSInteger)daysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate;

+ (NSInteger)monthsFromDate:(NSDate *)startDate toDate:(NSDate *)endDate;

- (NSInteger)daysFromDate:(NSDate *)startDate;

- (NSInteger)daysToDate:(NSDate *)endDate;

- (NSInteger)monthsFromDate:(NSDate *)startDate;

- (NSInteger)monthsToDate:(NSDate *)endDate;

- (NSInteger )hoursFromDate:(NSDate *)lastDate;
- (NSInteger)miniteFromDate:(NSDate *)date;

- (BOOL)isSameDayWithDate:(NSDate *)date;

//计算年龄，Array{年、月、日} 孕期{周、日}
- (NSArray *)ageFromDate:(NSDate *)birth;

- (NSString *)ageStrFromDate:(NSDate *)birth;

//计算星座
- (NSString *)constellation;

- (NSString *)relateFromDate:(NSDate *)date andSex:(BOOL)isBoy;

- (NSString *)compareFromDate:(NSDate *)date;
@end
