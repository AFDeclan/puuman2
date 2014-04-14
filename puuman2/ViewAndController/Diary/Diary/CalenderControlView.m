//
//  CalenderControlView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-18.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CalenderControlView.h"
#import "UniverseConstant.h"


@implementation CalenderControlView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initlization];
    }
    return self;
}

- (void)initlization
{
    ageCalendarView = [[AgeCalendarView alloc] initWithFrame:CGRectMake(0, 0, 240,264)];
    [ageCalendarView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:ageCalendarView];
    selectAgeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 240, 64)];
    [selectAgeBtn addTarget:self action:@selector(ageCalendarShowed) forControlEvents:UIControlEventTouchUpInside];
    [selectAgeBtn setBackgroundColor:[UIColor clearColor]];
    [self addSubview:selectAgeBtn];
    calendarView = [[CalendarView alloc] initWithFrame:CGRectMake(0, 264, 240, 264)];
    [calendarView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:calendarView];
    selectNomalBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,264, 240, 64)];
    [selectNomalBtn setBackgroundColor:[UIColor clearColor]];
    [selectNomalBtn addTarget:self action:@selector(ageCalendarHidded) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:selectNomalBtn];
    [selectAgeBtn setAlpha:0];
    [calendarView setAlpha:0];
    [self initWithAgeSelectBtn];
    [self initWithNomalSelectBtn];
    [self setTitleWithBirth];
   
}

- (void)initWithAgeSelectBtn
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(128, 0, 96, 64)];
    [label setText:@"按年龄索引"];
    [label setFont:PMFont3];
    [label setTextAlignment:NSTextAlignmentRight];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:PMColor2];
    [selectAgeBtn addSubview:label];
    yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 56, 60)];
    yearLabel.font = PMFont1;
    yearLabel.backgroundColor = [UIColor clearColor];
    yearLabel.textColor = PMColor2;
    yearLabel.textAlignment = NSTextAlignmentCenter;
    [selectAgeBtn addSubview:yearLabel];
    monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 56, 60)];
    monthLabel.font = PMFont1;
    monthLabel.backgroundColor = [UIColor clearColor];
    monthLabel.textColor = PMColor2;
    monthLabel.textAlignment = NSTextAlignmentCenter;
    [selectAgeBtn addSubview:monthLabel];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 136, 64)];
    titleLabel.font = PMFont2;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = PMColor2;
    [selectAgeBtn addSubview:titleLabel];

    
    
    
}

- (void)initWithNomalSelectBtn
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(128, 0, 96, 64)];
    [label setText:@"按日期索引"];
    [label setFont:PMFont3];
    [label setTextAlignment:NSTextAlignmentRight];
    [label setTextColor:PMColor2];
    [label setBackgroundColor:[UIColor clearColor]];
    [selectNomalBtn addSubview:label];
    
    _yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 18, 56, 24)];
    _yearLabel.font = PMFont1;
    _yearLabel.backgroundColor = [UIColor clearColor];
    _yearLabel.textColor = PMColor2;
    _yearLabel.textAlignment = NSTextAlignmentRight;
    [selectNomalBtn addSubview:_yearLabel];
    
   _monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 25, 24, 16)];
    _monthLabel.font = PMFont2;
    _monthLabel.backgroundColor = [UIColor clearColor];
    _monthLabel.textColor = PMColor2;
    _monthLabel.textAlignment = NSTextAlignmentLeft;
    [selectNomalBtn addSubview:_monthLabel];
    [_yearLabel setText:[calendarView getYear]];
    [_monthLabel setText:[calendarView getMonth]];

    UIImageView *partingLineOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 2)];
    [partingLineOne setImage:[UIImage imageNamed:@"line1_diary.png"]];
    [partingLineOne setBackgroundColor:[UIColor clearColor]];
    [selectNomalBtn addSubview:partingLineOne];
    
    
}


- (void)show
{
    [ageCalendarView nowMonth];
    [calendarView refresh];
}

- (void)ageCalendarHidded
{
    [UIView animateWithDuration:0.5 animations:^{
        [selectAgeBtn setAlpha:1];
        [selectNomalBtn setAlpha:0];
        [ageCalendarView setAlpha:0];
        [calendarView setAlpha:1];
        [calendarView setFrame:CGRectMake(0, 64, 240, 264)];
        [selectNomalBtn setFrame:CGRectMake(0, 64, 240, 64)];
    }];
    [self setTitleWithBirth];
}

- (void)ageCalendarShowed
{
    
    [_yearLabel setText:[calendarView getYear]];
    [_monthLabel setText:[calendarView getMonth]];
    [UIView animateWithDuration:0.5 animations:^{
        [selectAgeBtn setAlpha:0];
        [selectNomalBtn setAlpha:1];
        [ageCalendarView setAlpha:1];
        [calendarView setAlpha:0];
        [calendarView setFrame:CGRectMake(0, 264, 240, 64)];
        [selectNomalBtn setFrame:CGRectMake(0, 264, 240, 64)];
    }];
}

- (void)setTitleWithBirth
{
    BOOL birth =[ageCalendarView getBitrh];
    NSInteger month = [ageCalendarView getmonth];
    if (birth) {
        if (month >= 0 ) {
            int year = (month+1)/13;
            if (year > 0) {
                
                [titleLabel setText:@"年       个月"];
                [yearLabel setText:[NSString stringWithFormat:@"%d",year]];
                [monthLabel setText:[NSString stringWithFormat:@"%d",month%12 +1]];
                [yearLabel setAlpha:1];
                [monthLabel setAlpha:1];
                SetViewLeftUp(monthLabel, 44, 0);
                SetViewLeftUp(yearLabel, 0, 0);
                SetViewLeftUp(titleLabel, 40, 0);
                
                
            }else{
                [titleLabel setText:@"个月"];
                [monthLabel setText:[NSString stringWithFormat:@"%d ",month+1]];
                
                [yearLabel setAlpha:0];
                [monthLabel setAlpha:1];
                
                SetViewLeftUp(monthLabel, 0, 0);
                SetViewLeftUp(titleLabel, 40, 0);
            }
            
        }else{
            [titleLabel setText:[NSString stringWithFormat:@"孕期%d周",month+40 +1]];
            [yearLabel setAlpha:0];
            [monthLabel setAlpha:0];
            SetViewLeftUp(titleLabel, 22, 0);
        }
        
        
        
    }else{
        
        [titleLabel setText:[NSString stringWithFormat:@"孕期%d周",month]];
        [yearLabel setAlpha:0];
        [monthLabel setAlpha:0];
        SetViewLeftUp(titleLabel, 22, 0);
    }
    
    
}

@end
