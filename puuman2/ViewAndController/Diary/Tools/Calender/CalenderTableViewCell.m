//
//  CalenderTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-6-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CalenderTableViewCell.h"
#import "UniverseConstant.h"
#import "DiaryModel.h"
#import "DiaryViewController.h"

static const float dayCellWidth = 28;
static const float dayCellHeight = 32;
static const float startDayCellOfX = 18;
static const float startDayCellOfY = 16;
static const float subDistanceOfX = 2;
static const float subDistanceOfY = 4;
static NSString * weekDayStr[7] = {@"日", @"一", @"二", @"三", @"四", @"五", @"六"};

@implementation CalenderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initialization];

    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initialization
{
    for (int i=0; i<6; i++)
    {
        for (int j=0; j<7; j++) {
            labels[i][j] = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            [labels[i][j] setFont:PMFont3 ];
            [labels[i][j] setTextAlignment:NSTextAlignmentCenter];
            [labels[i][j] setBackgroundColor:[UIColor clearColor]];
            [labels[i][j] setTextColor:PMColor6];
            [self addSubview:labels[i][j]];
            gestureRecognizer[i][j] = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dayClicked:)];
            [labels[i][j] setUserInteractionEnabled:YES];
            [labels[i][j] addGestureRecognizer:gestureRecognizer[i][j]];
        }
        
    }
    
    CGFloat x = startDayCellOfX;
    CGFloat y = 0;
    for (NSInteger i=0; i<7; i++)
    {
        UILabel *weekDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, dayCellWidth, 12)];
        weekDayLabel.font = PMFont3;
        weekDayLabel.textAlignment = NSTextAlignmentCenter;
        weekDayLabel.textColor = PMColor2;
        [weekDayLabel setBackgroundColor:[UIColor clearColor]];
        weekDayLabel.text = weekDayStr[i];
        [self addSubview:weekDayLabel];
        x += subDistanceOfX + dayCellWidth;
    }
    


}


- (void)dayClicked:(UIGestureRecognizer *)sender
{
    for (int i=0; i<weekCnt; i++)
        for (int j=0; j<7; j++)
        {
            if (gestureRecognizer[i][j] == sender)
            {
                NSDate *clickedDate = [startDate dateByAddingTimeInterval:(i*7+j)*24*60*60];
                NSInteger index = [[DiaryModel sharedDiaryModel] indexForDiaryInDay:clickedDate];
                if (index >= 0) {
                    [[DiaryViewController sharedDiaryViewController] showDiaryAtIndex:index];
                }
            }
        }
}


- (void)buildMonthWithCurrentIndex:(NSInteger)index
{
    if (index == 0) {
        [self setDate:[NSDate date]];
    }else{
        NSDate *newDate = [NSDate date];
        for (int i = 0; i > index; i--) {
            newDate = [[self startDateInMonthOfDate:newDate] dateByAddingTimeInterval:24*60*60*(-1)];
        }
        [self setDate:newDate];
    }
}


- (void)setDate:(NSDate *)date
{
    showDate = date;
    [self refresh];
}

- (void)refresh
{
    NSDate *lastDay = [self endDateInMonthOfDate:showDate];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    weekCnt = [calendar ordinalityOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:lastDay];
    NSDate *date = [self startDateInMonthOfDate:showDate];
    NSInteger offset = [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:date] - 1;
    date = [NSDate dateWithTimeInterval:-offset*24*60*60 sinceDate:date];
    startDate = date;
    CGFloat x = startDayCellOfX;
    CGFloat y = (weekCnt == 4)? startDayCellOfY +dayCellHeight+subDistanceOfY:startDayCellOfY;
    for (int i=0; i<6; i++) {
        for (int j=0; j<7; j++) {
            [labels[i][j] setFrame:CGRectMake(x+2, y-1, dayCellWidth, dayCellHeight)];
            [labels[i][j] setAlpha:0];
            x += dayCellWidth + subDistanceOfX;
            for (UIView *view in [labels[i][j] subviews]) [view removeFromSuperview];
            labels[i][j].text = @"";
            if ([self twoDateIsSameMonth:date second:showDate])
            {
                [labels[i][j] setAlpha:1];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"dd"];
                NSString *dayStr = [formatter stringFromDate:date];
                labels[i][j].text = dayStr;
                
                if ([self dateIsInFuture:date])
                {
                    labels[i][j].textColor = PMColor6;
                }
                else if ([self dateIsToday:date])
                {
                    labels[i][j].textColor = [UIColor whiteColor];
                }
                else
                {
                    labels[i][j].textColor = PMColor2;
                }
                if ([self dateIsToday:date])
                    labels[i][j].backgroundColor = PMColor6;
                else labels[i][j].backgroundColor = [UIColor clearColor];
    
                
                if ([[DiaryModel sharedDiaryModel] indexForDiaryInDay:date ] >= 0) {
                    [labels[i][j] setTextColor:[UIColor whiteColor]];
                    [labels[i][j] setBackgroundColor:PMColor6];
                }
                
            }
            date = [date dateByAddingTimeInterval:24*60*60];
        }
        x = startDayCellOfX;
        y += dayCellHeight + subDistanceOfY;
    }
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


- (NSDate *)endDateInMonthOfDate:(NSDate *)date_
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
        NSDate *endDate = [NSDate dateWithTimeInterval:interval-24*60*60 sinceDate:beginningOfMonth];
        return endDate;
    }
    else
    {
        return nil;
    }
}


- (BOOL)dateIsInFuture:(NSDate *)date_
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp_ = [calendar components:unit fromDate:date_];
    NSDateComponents *comp_now = [calendar components:unit fromDate:[NSDate date]];
    if ([comp_ year] > [comp_now year] ||
        ([comp_ year] == [comp_now year] && [comp_ month] > [comp_now month]) ||
        ([comp_ year] == [comp_now year] && [comp_ month] == [comp_now month] && [comp_ day] > [comp_now day]))
        return YES;
    else return NO;
}

- (BOOL)twoDateIsSameMonth:(NSDate *)fistDate_
                    second:(NSDate *)secondDate_
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit =NSMonthCalendarUnit |NSYearCalendarUnit;
    
    NSDateComponents *fistComponets = [calendar components: unit fromDate: fistDate_];
    NSDateComponents *secondComponets = [calendar components: unit fromDate: secondDate_];
    
    if ([fistComponets month] == [secondComponets month]
        && [fistComponets year] == [secondComponets year])
    {
        return YES;
    }
    return NO;
}

- (BOOL)dateIsToday:(NSDate *)date_
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp_ = [calendar components:unit fromDate:date_];
    NSDateComponents *comp_now = [calendar components:unit fromDate:[NSDate date]];
    if ([comp_ year] == [comp_now year] && [comp_ month] == [comp_now month] && [comp_ day] == [comp_now day])
        return YES;
    else return NO;
}


@end
