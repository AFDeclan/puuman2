//
//  NSDate+Compute.m
//  puman
//
//  Created by 陈晔 on 13-10-21.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "NSDate+Compute.h"
#import "UserInfo.h"

@implementation NSDate(Compute)

+ (NSInteger)daysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit units=NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp1 = [gregorian components:units fromDate:startDate];
    NSDateComponents *comp2 = [gregorian components:units fromDate:endDate];
    [comp1 setHour:12];
    [comp2 setHour:12];
    startDate = [gregorian dateFromComponents:comp1];
    endDate = [gregorian dateFromComponents:comp2];;
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit fromDate:startDate toDate:endDate options:0];
    return [components day];
}

+ (NSInteger)monthsFromDate:(NSDate *)startDate toDate:(NSDate *)endDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit units=NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp1 = [gregorian components:units fromDate:startDate];
    NSDateComponents *comp2 = [gregorian components:units fromDate:endDate];
    [comp1 setHour:12];
    [comp2 setHour:12];
    [comp1 setDay:1];
    [comp2 setDay:1];
    startDate = [gregorian dateFromComponents:comp1];
    endDate = [gregorian dateFromComponents:comp2];;
    NSDateComponents *components = [gregorian components:NSMonthCalendarUnit fromDate:startDate toDate:endDate options:0];
    return [components month];
}

- (NSInteger)daysFromDate:(NSDate *)startDate
{
    return [NSDate daysFromDate:startDate toDate:self];
}

- (NSInteger)daysToDate:(NSDate *)endDate
{
    return [NSDate daysFromDate:self toDate:endDate];
}

- (NSInteger)monthsFromDate:(NSDate *)startDate
{
    return [NSDate monthsFromDate:startDate toDate:self];
}

- (NSInteger)monthsToDate:(NSDate *)endDate
{
    
    NSDate *pregnancyDate = [endDate dateByAddingTimeInterval:-280*24*60*60];
    return [NSDate monthsFromDate:pregnancyDate toDate: self];

   
}

- (BOOL)isSameDayWithDate:(NSDate *)date
{
    if ([self daysFromDate:date] == 0) return YES;
    else return NO;
}

- (NSArray *)ageFromDate:(NSDate *)birth
{
    if (![[[UserInfo sharedUserInfo] babyInfo] WhetherBirth]) {
        //孕期
        NSDate *pregnancyDate = [birth dateByAddingTimeInterval:-280*24*60*60];
        NSInteger day = [pregnancyDate daysToDate:self];
        NSInteger week = day / 7;
        day = day - week * 7;
        NSArray *age = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", week],
                        [NSString stringWithFormat:@"%d", day], nil];
        return age;
 
    }

    NSInteger y1, m1, d1, y2, m2, d2;
    NSInteger year, month, day;
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp1 = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:birth];
    NSDateComponents *comp2 = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    y1 = comp1.year;
    m1 = comp1.month;
    d1 = comp1.day;
    y2 = comp2.year;
    m2 = comp2.month;
    d2 = comp2.day;
    if (y1 == y2)
        year = 0;
    else if (m1 < m2 || (m1 == m2 && d1 <= d2))
        year = y2 - y1;
    else
        year = y2 - y1 - 1;
    if (m1 == m2)
        month = 0;
    else if (d1 <= d2)
        month = m2 - m1;
    else
        month = m2 - m1 - 1;
    if (month < 0) month = month + 12;
    NSDateComponents *addComp = [[NSDateComponents alloc] init];
    addComp.year = year;
    addComp.month = month;
    addComp.day = 0;
    NSDate *tempDate = [cal dateByAddingComponents:addComp toDate:birth options:0];
    day = [tempDate daysToDate:self];
    NSArray *age = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%d", year],
                    [NSString stringWithFormat:@"%d", month],
                    [NSString stringWithFormat:@"%d", day+1], nil];
    return age;
}

- (NSString *)ageStrFromDate:(NSDate *)birth
{
    NSArray *age = [self ageFromDate:birth];
    NSString *ageStr = @"";
    if ([age count] == 3)
    {
        if ([[age objectAtIndex:0] integerValue] > 0)
        {
            ageStr = [ageStr stringByAppendingFormat:@"%@岁", [age objectAtIndex:0]];
        }
        if ([[age objectAtIndex:1] integerValue] > 0)
        {
            ageStr = [ageStr stringByAppendingFormat:@"%@个月", [age objectAtIndex:1]];
        }
        if ([[age objectAtIndex:2] integerValue] > 0)
        {
            ageStr = [ageStr stringByAppendingFormat:@"%@天", [age objectAtIndex:2]];
        }
    }
    else if ([age count] == 2)
    {
        ageStr = @"孕期";
        if ([[age objectAtIndex:0] integerValue] > 0)
        {
            ageStr = [ageStr stringByAppendingFormat:@"%@周", [age objectAtIndex:0]];
        }
        if ([[age objectAtIndex:1] integerValue] > 0)
        {
            ageStr = [ageStr stringByAppendingFormat:@"%@天", [age objectAtIndex:1]];
        }
    }
    return ageStr;
}

- (NSString *)constellation
{
    NSString *constellations[12] = {@"水瓶座", @"双鱼座", @"白羊座", @"金牛座", @"双子座", @"巨蟹座", @"狮子座", @"处女座", @"天平座", @"天蝎座", @"射手座", @"摩羯座"};
//    const NSInteger startMonth[12] =     {1 ,2, 3, 4, 5, 6, 7, 8, 9, 10,11,12};
    const NSInteger startDay[12] =       {20,19,21,20,21,22,23,23,23,24,23,22};
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp1 = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    NSInteger y1, m1, d1;
    y1 = comp1.year;
    m1 = comp1.month;
    d1 = comp1.day;
    NSInteger index = m1-1;
    if (startDay[index] <= d1)
        return constellations[index];
    else {
        index = index - 1;
        if (index < 0) index = 11;
        return constellations[index];
    }
    return @"";
}

- (NSInteger )hoursFromDate:(NSDate *)lastDate
{
    return [NSDate hoursFromDate:lastDate toDate:self];
}



+ (NSInteger)hoursFromDate:(NSDate *)startDate toDate:(NSDate *)endDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit units=NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit| NSHourCalendarUnit |NSMinuteCalendarUnit |NSSecondCalendarUnit;
    NSDateComponents *comp1 = [gregorian components:units fromDate:startDate];
    NSDateComponents *comp2 = [gregorian components:units fromDate:endDate];
    startDate = [gregorian dateFromComponents:comp1];
    endDate = [gregorian dateFromComponents:comp2];;
    NSDateComponents *components = [gregorian components:NSHourCalendarUnit fromDate:startDate toDate:endDate options:0];
    return [components hour];
}

- (NSInteger)miniteFromDate:(NSDate *)date
{
    return [NSDate miniteFromDate:date toDate:self];
}

+ (NSInteger)miniteFromDate:(NSDate *)startDate toDate:(NSDate *)endDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit units=NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit| NSHourCalendarUnit |NSMinuteCalendarUnit |NSSecondCalendarUnit;
    NSDateComponents *comp1 = [gregorian components:units fromDate:startDate];
    NSDateComponents *comp2 = [gregorian components:units fromDate:endDate];
    startDate = [gregorian dateFromComponents:comp1];
    endDate = [gregorian dateFromComponents:comp2];;
    NSDateComponents *components = [gregorian components:NSMinuteCalendarUnit fromDate:startDate toDate:endDate options:0];
    return [components minute];
}


- (NSString *)relateFromDate:(NSDate *)date andSex:(BOOL)isBoy
{
    int ageSelf = [[NSDate date] daysFromDate:self];
    int ageTarget = [[NSDate date] daysFromDate:date];
    if (ageTarget >ageSelf) {
        if (isBoy) {
            return @"哥哥";
        }else{
            return @"姐姐";
        }
    }else if(ageSelf == ageTarget){
        return @"一样大";
    }else{
        if (isBoy) {
            return @"弟弟";
        }else{
            return @"妹妹";
        }
    }
    
    
}

- (NSString *)compareFromDate:(NSDate *)date
{
    
    int ageSelf = [[NSDate date] daysFromDate:self];
    int ageTarget = [[NSDate date] daysFromDate:date];
    if (ageSelf > ageTarget) {
        return [NSString stringWithFormat:@"小%d天",ageSelf - ageTarget];
    }else if (ageSelf == ageTarget){
        return @"一样大";
    }else{
        return [NSString stringWithFormat:@"大%d天",ageTarget - ageSelf];
    }
}

- (BOOL)LaterThanDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp_ = [calendar components:unit fromDate:self];
    NSDateComponents *comp_now = [calendar components:unit fromDate:date];
    if ([comp_ year] > [comp_now year] ||
        ([comp_ year] == [comp_now year] && [comp_ month] > [comp_now month]) ||
        ([comp_ year] == [comp_now year] && [comp_ month] == [comp_now month] && [comp_ day] > [comp_now day]))
        return YES;
    else return NO;
}

@end
