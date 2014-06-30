//
//  CalenderView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-6-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CalenderView.h"
#import "CalenderTableViewCell.h"
#import "NSDate+Compute.h"
#import "UserInfo.h"

@implementation CalenderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setContentView];
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setContentView
{
    calendarColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(0, 48, 240, 232)];
    [calendarColumnView setBackgroundColor:[UIColor clearColor]];
    [calendarColumnView setColumnViewDelegate:self];
    [calendarColumnView setViewDataSource:self];
    [calendarColumnView setPagingEnabled:YES];
    [self addSubview:calendarColumnView];
    
}

- (void)refreshInfo
{
    
    [calendarColumnView reloadData];
    if ([[[UserInfo sharedUserInfo] babyInfo] WhetherBirth]) {
        [calendarColumnView setContentOffset:CGPointMake(240*( [[NSDate date] monthsFromDate:[[UserInfo sharedUserInfo].babyInfo Birthday]]), 0) animated:YES];
    }else{
        [calendarColumnView setContentOffset:CGPointMake(240*( [[NSDate date] monthsFromDate:[[UserInfo sharedUserInfo].babyInfo Birthday]]), 0) animated:YES];
        
    }
    
}

#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
    
}


- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{
    
    return 240;
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    if ([[[UserInfo sharedUserInfo] babyInfo] WhetherBirth]) {
        return [[NSDate date] monthsFromDate:[[UserInfo sharedUserInfo].babyInfo Birthday]]+1;
    }else{
        return [[NSDate date] monthsToDate:[[UserInfo sharedUserInfo].babyInfo Birthday]]+1;
    }
}

- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    NSString * cellIdentifier = @"ToolsCalendar";
    CalenderTableViewCell *cell = (CalenderTableViewCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[CalenderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
//    if ([[[UserInfo sharedUserInfo] babyInfo] WhetherBirth]) {
//        [cell buildMonthWithCurrentIndex:index - [[NSDate date] monthsFromDate:[[UserInfo sharedUserInfo].babyInfo Birthday]]];
//    }else{
//        [cell buildMonthWithCurrentIndex:index - [[NSDate date] monthsToDate:[[UserInfo sharedUserInfo].babyInfo Birthday]]];
//    }
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView.layer setMasksToBounds:YES];
    return cell;
    
}

@end
