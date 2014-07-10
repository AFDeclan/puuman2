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
#import "DateFormatter.h"

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
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 136, 48)];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.font = PMFont2;
    timeLabel.textColor = PMColor6;
    [self addSubview:timeLabel];

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
        [calendarColumnView setContentOffset:CGPointMake(240*( [[NSDate date] monthsFromDate:[[UserInfo sharedUserInfo] createTime]]), 0) animated:NO];
    }else{
        [calendarColumnView setContentOffset:CGPointMake(240*( [[NSDate date] monthsFromDate:[[UserInfo sharedUserInfo] createTime]]), 0) animated:NO];
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
    return  [[NSDate date] monthsFromDate:[[UserInfo sharedUserInfo] createTime]]+1;
}

- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    NSString * cellIdentifier = @"ToolsCalendar";
    CalenderTableViewCell *cell = (CalenderTableViewCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[CalenderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    [cell buildMonthWithCurrentIndex:index - [[NSDate date] monthsFromDate:[[UserInfo sharedUserInfo] createTime]]];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView.layer setMasksToBounds:YES];
    return cell;
    
}

- (void)scrollViewDidScroll:(UIColumnView *)scrollView
{
  
    NSInteger num = [[NSDate date] monthsFromDate:[[UserInfo sharedUserInfo] createTime]] - (int)(scrollView.contentOffset.x/240);
    [self buildMonthWithCurrentIndex:num];
}

- (void)buildMonthWithCurrentIndex:(NSInteger)index
{
    if (index == 0) {
        [self setDate:[NSDate date]];
    }else{
        NSDate *newDate = [NSDate date];
        for (int i = 0; i < index; i++) {
            newDate = [[self startDateInMonthOfDate:newDate] dateByAddingTimeInterval:24*60*60*(-1)];
        }
        [self setDate:newDate];
    }
}

- (void)setDate:(NSDate *)date
{
    [timeLabel setText:[DateFormatter stringFromDate2:date]];
}

- (NSDate *)startDateInMonthOfDate:(NSDate *)date_
{
    double interval = 0;
    NSDate *beginningOfMonth = [[NSDate alloc] init];
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    BOOL ok = [gregorian rangeOfUnit:NSMonthCalendarUnit
                           startDate: &beginningOfMonth
                            interval: &interval
                             forDate: date_];
    
    if (ok)
    {
        return beginningOfMonth;
    }
    else
    {
        return nil;
    }
}
@end
