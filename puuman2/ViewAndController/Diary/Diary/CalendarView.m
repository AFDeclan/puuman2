//
//  CalendarView.m
//  PuumanForPhone
//
//  Created by Declan on 14-1-13.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "CalendarView.h"
#import "UniverseConstant.h"
#import "DiaryModel.h"
#import "DiaryViewController.h"
#import "Diary.h"
static const float dayCellWidth = 28;
static const float dayCellHeight = 32;
static const float startDayCellOfX = 18;
static const float startDayCellOfY = 86;
static const float subDistanceOfX = 2;
static const float subDistanceOfY = 4;

static NSString * weekDayStr[7] = {@"日", @"一", @"二", @"三", @"四", @"五", @"六"};

@implementation CalendarView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
     
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *partingLineOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 2)];
        [partingLineOne setImage:[UIImage imageNamed:@"line1_diary.png"]];
        [partingLineOne setBackgroundColor:[UIColor clearColor]];
        [self addSubview:partingLineOne];
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
        CGFloat y = 64;
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
        
        _yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 21, 56, 24)];
        _yearLabel.font = PMFont1;
        _yearLabel.backgroundColor = [UIColor clearColor];
        _yearLabel.textColor = PMColor6;
        _yearLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_yearLabel];
        
        _monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(136, 28, 24, 16)];
        _monthLabel.font = PMFont2;
        _monthLabel.backgroundColor = [UIColor clearColor];
        _monthLabel.textColor = PMColor6;
        _monthLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_monthLabel];
        
      
        
        if ([[[DiaryModel sharedDiaryModel] diaries] count]>0) {
            NSDate *date = [[[[DiaryModel sharedDiaryModel] diaries] objectAtIndex:[[[DiaryModel sharedDiaryModel] diaries] count]-1] DCreateTime];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
            NSDateComponents *comps_available = [calendar components:unit fromDate:date];
            NSDateComponents *comps_now = [calendar components:unit fromDate:[NSDate date]];
            if (([comps_available month]<[comps_now month]&&[comps_available year]== [comps_now year])||[comps_available year] < [comps_now year]) {
                _preBtn.enabled = YES;
            }else{
                _preBtn.enabled = NO;
            }
        }else{
            _preBtn.enabled = NO;
        }
        _nextBtn.enabled = NO;
        
        [self setDate:[NSDate date]];
        _preBtn = [[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 52, 64)];
        [_preBtn setTitle:@"" andImg:[UIImage imageNamed:@"tri_gray_left.png"]  andButtonType:kButtonTypeSix];
        [_preBtn addTarget:self action:@selector(preMonth) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_preBtn];
        
        _nextBtn = [[AFTextImgButton alloc] initWithFrame:CGRectMake(188, 0, 52, 64)];
        [_nextBtn setTitle:@"" andImg:[UIImage imageNamed:@"tri_gray_right.png"]  andButtonType:kButtonTypeSix];
        [_nextBtn addTarget:self action:@selector(nextMonth) forControlEvents:UIControlEventTouchUpInside];
        [_nextBtn setAlpha:0];
        [self addSubview:_nextBtn];
       
    }
    return self;
}

- (void)setDate:(NSDate *)date
{
    showDate = date;
    [self refresh];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit fromDate:date];
    _yearLabel.text = [NSString stringWithFormat:@"%d", [comp year]];
    int month = [comp month];
    if (month<10) {
        _monthLabel.text = [NSString stringWithFormat:@"/0%d", month];
    }else
    {
        _monthLabel.text = [NSString stringWithFormat:@"/%d", month];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    
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
                
                if ([[DiaryModel sharedDiaryModel] indexForDiaryInDay:date] >0) {
                     labels[i][j].textColor = [UIColor whiteColor];
                    labels[i][j].backgroundColor = PMColor3;
                }
              
            }
            date = [date dateByAddingTimeInterval:24*60*60];
        }
        x = startDayCellOfX;
        y += dayCellHeight + subDistanceOfY;
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

#pragma mark - IBAction
- (void)preMonth
{
     [_nextBtn setAlpha:1];
    NSDate *newDate = [[self startDateInMonthOfDate:showDate] dateByAddingTimeInterval:-24*60*60];
    [self setDate:newDate];
    
    NSDate *date = [[[[DiaryModel sharedDiaryModel] diaries] objectAtIndex:[[[DiaryModel sharedDiaryModel] diaries] count]-1] DCreateTime];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comps_available = [calendar components:unit fromDate:date];
    NSDateComponents *comps_now = [calendar components:unit fromDate:showDate];
    if ([comps_available month]==[comps_now month]&&[comps_available year]== [comps_now year]) {
         [_preBtn setAlpha:0];
    }
    
}


- (void)nextMonth
{
    NSDate *newDate = [[self endDateInMonthOfDate:showDate] dateByAddingTimeInterval:24*60*60];
    [self setDate:newDate];
     [_preBtn setAlpha:1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comps_available = [calendar components:unit fromDate:showDate];
    NSDateComponents *comps_now = [calendar components:unit fromDate:[NSDate date]];
    if (([comps_now month]==[comps_available month]&&[comps_available year]==[comps_now year])) {
        [_nextBtn setAlpha:0];
    }
}

#pragma mark - 日历处理函数

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

- (NSString *)getYear
{
    return _yearLabel.text;
}

- (NSString *)getMonth
{

    return _monthLabel.text;
}

@end
