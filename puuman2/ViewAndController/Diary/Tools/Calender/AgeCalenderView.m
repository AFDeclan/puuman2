//
//  AgeCalenderView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-6-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AgeCalenderView.h"
#import "AgeCalenderTableViewCell.h"
#import "AgePreTableViewCell.h"
#import "AgeBornPreTableViewCell.h"
#import "NSDate+Compute.h"
#import "UserInfo.h"

@implementation AgeCalenderView

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
    ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 136, 48)];
    ageLabel.backgroundColor = [UIColor clearColor];
    ageLabel.font = PMFont2;
    ageLabel.textColor = PMColor6;
    [self addSubview:ageLabel];
    
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
        if ([[[UserInfo sharedUserInfo] createTime] LaterThanDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]] ) {
            
            [calendarColumnView setContentOffset:CGPointMake(240*( [[NSDate date] monthsFromDate:[[UserInfo sharedUserInfo] createTime]]), 0) animated:NO];

        }else{
            NSInteger days = [[[UserInfo sharedUserInfo] createTime] daysToDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
            NSInteger week = days%7 == 0 ? days/7:days/7+1;
            
            [calendarColumnView setContentOffset:CGPointMake(240*( [[NSDate date] monthsFromDate:[[UserInfo sharedUserInfo].babyInfo Birthday]]+ week - 1), 0) animated:NO];

        }
    
        
    }else{
        
        NSArray *ages1 = [[NSDate date] ageFromDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
        NSArray *ages2 = [[[UserInfo sharedUserInfo] createTime]  ageFromDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
        
        [calendarColumnView setContentOffset:CGPointMake(240*( [[ages1 objectAtIndex:0] intValue] - [[ages2 objectAtIndex:0] integerValue]-1), 0) animated:NO];
        
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

        if ([[[UserInfo sharedUserInfo] createTime] LaterThanDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]] ) {
             return [[NSDate date] monthsFromDate:[[UserInfo sharedUserInfo] createTime]]+1;
        }else{
            NSInteger days = [[[UserInfo sharedUserInfo] createTime] daysToDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
            NSInteger week = days%7 == 0 ? days/7:days/7+1;
            
            return [[NSDate date] monthsFromDate:[[UserInfo sharedUserInfo].babyInfo Birthday]]+ week;
        }
        
        
        
       
    }else{
        NSArray *ages1 = [[NSDate date] ageFromDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
        NSArray *ages2 = [[[UserInfo sharedUserInfo] createTime]  ageFromDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
        return [[ages1 objectAtIndex:0] intValue] - [[ages2 objectAtIndex:0] integerValue];
    }
}

- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    if ([[[UserInfo sharedUserInfo] babyInfo] WhetherBirth]) {
        
        
        if ([[[UserInfo sharedUserInfo] createTime] LaterThanDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]] ) {
            NSString * cellIdentifier = @"BornCalendar";
            
            AgeCalenderTableViewCell *cell = (AgeCalenderTableViewCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil)
            {
                cell = [[AgeCalenderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                
            }
            
            [cell buildMonthWithCurrentIndex:index - [[NSDate date] monthsFromDate:[[UserInfo sharedUserInfo] createTime]] ];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell.contentView.layer setMasksToBounds:YES];
            return cell;

        }else{
            NSInteger days = [[[UserInfo sharedUserInfo] createTime] daysToDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
            NSInteger week = days%7 == 0 ? days/7:days/7+1;

            
            if (index < week) {
                NSString * cellIdentifier = @"BornPreCalendar";
                AgeBornPreTableViewCell *cell = (AgeBornPreTableViewCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (cell == nil)
                {
                    cell = [[AgeBornPreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    
                }
                
                
                [cell buildWeekWithCurrentIndex:index];
                [cell setBackgroundColor:[UIColor clearColor]];
                [cell.contentView.layer setMasksToBounds:YES];
                return cell;

            }else{
                NSString * cellIdentifier = @"BornCalendar";
                
                AgeCalenderTableViewCell *cell = (AgeCalenderTableViewCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (cell == nil)
                {
                    cell = [[AgeCalenderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    
                }
                
                [cell buildMonthWithCurrentIndex:index - week-1];
                [cell setBackgroundColor:[UIColor clearColor]];
                [cell.contentView.layer setMasksToBounds:YES];
                return cell;

            }
        }
        
    }else{
        NSString * cellIdentifier = @"PreCalendar";
        AgePreTableViewCell *cell = (AgePreTableViewCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[AgePreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
        }
       
        
        [cell buildWeekWithCurrentIndex:index];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView.layer setMasksToBounds:YES];
        return cell;

    }
    
}


- (void)scrollViewDidScroll:(UIColumnView *)scrollView
{
    
    
    if ([[[UserInfo sharedUserInfo] babyInfo] WhetherBirth]) {
        
        if ([[[UserInfo sharedUserInfo] createTime] LaterThanDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]] ) {
            NSInteger num = [[[UserInfo sharedUserInfo] createTime] monthsFromDate:[[UserInfo sharedUserInfo].babyInfo Birthday]] + (int)(scrollView.contentOffset.x/240)-1;
            NSLog(@"%@",[[UserInfo sharedUserInfo] createTime]);
            int year = num/12;
            int month =  num%12+1;
            
            if (year > 0) {
                if (month >0) {
                    [ageLabel setText:[NSString stringWithFormat:@"%d岁%d个月",year,month]];
                }else{
                    [ageLabel setText:[NSString stringWithFormat:@"%d岁",year]];
                }
            }else{
                [ageLabel setText:[NSString stringWithFormat:@"%d个月",month]];
                
            }

            
            
        }else{
            NSInteger days = [[[UserInfo sharedUserInfo] createTime] daysToDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
            NSInteger week = days%7 == 0 ? days/7:days/7+1;
            
            NSInteger num =  (int)(scrollView.contentOffset.x/240) +1;
            if (num <= week) {
                
                [ageLabel setText:[NSString stringWithFormat:@"孕期%d周",40-(week -num)]];
                
            }else{
                num -= week;
                int year = num/12;
                int month =  num%12;
                
                if (year > 0) {
                    if (month >0) {
                        [ageLabel setText:[NSString stringWithFormat:@"%d岁%d个月",year,month]];
                    }else{
                        [ageLabel setText:[NSString stringWithFormat:@"%d岁",year]];
                    }
                }else{
                    [ageLabel setText:[NSString stringWithFormat:@"%d个月",month]];
                    
                }
                
            }
 
            
        }
        

        
    }else{
        
        NSArray *ages = [[[UserInfo sharedUserInfo] createTime] ageFromDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
        
        [ageLabel setText:[NSString stringWithFormat:@"孕期%d周",(int)(scrollView.contentOffset.x/240)+1 +[[ages objectAtIndex:0] intValue]]];
    }
}

@end
