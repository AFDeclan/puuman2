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
        [calendarColumnView setContentOffset:CGPointMake(240*( [[NSDate date] monthsFromDate:[[UserInfo sharedUserInfo].babyInfo Birthday]]), 0) animated:NO];
    }else{
        [calendarColumnView setContentOffset:CGPointMake(240*( [[NSDate date] monthsFromDate:[[UserInfo sharedUserInfo].babyInfo Birthday]]), 0) animated:NO];
        
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
        NSArray *ages = [[NSDate date] ageFromDate:[[UserInfo sharedUserInfo].babyInfo Birthday]];
        return [[ages objectAtIndex:0] intValue] +1;
    }
}

- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    if ([[[UserInfo sharedUserInfo] babyInfo] WhetherBirth]) {
        NSString * cellIdentifier = @"ToolsCalendar";
        AgeCalenderTableViewCell *cell = (AgeCalenderTableViewCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[AgeCalenderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
        }
        
        [cell buildMonthWithCurrentIndex:index - [[NSDate date] monthsFromDate:[[UserInfo sharedUserInfo].babyInfo Birthday]]];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView.layer setMasksToBounds:YES];
        return cell;

    }else{
        NSString * cellIdentifier = @"ToolsCalendar";
        AgePreTableViewCell *cell = (AgePreTableViewCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[AgePreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
        }
       
        //   [cell buildMonthWithCurrentIndex:index - [[NSDate date] monthsToDate:[[UserInfo sharedUserInfo].babyInfo Birthday]]];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView.layer setMasksToBounds:YES];
        return cell;

    }
    
}


- (void)scrollViewDidScroll:(UIColumnView *)scrollView
{
    
    NSInteger num =  (int)(scrollView.contentOffset.x/240)+1;
    
    if ([[[UserInfo sharedUserInfo] babyInfo] WhetherBirth]) {
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
        
    }else{
        [ageLabel setText:[NSString stringWithFormat:@"孕期%d周",(int)(scrollView.contentOffset.x/240)+1]];
    }
}

@end
