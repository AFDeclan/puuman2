//
//  AgeCalendarView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-18.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AgeCalendarView.h"
#import "ColorsAndFonts.h"
#import "NSDate+Compute.h"
#import "DateFormatter.h"
#import "BabyData.h"
#import "DiaryModel.h"
#import "DiaryViewController.h"
#import "Diary.h"

static const float dayCellWidth = 28;
static const float dayCellHeight = 32;
static const float startDayCellOfX = 18;
static const float startDayCellOfY = 74;
static const float subDistanceOfX = 2;
static const float subDistanceOfY = 4;
@implementation AgeCalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    days = 0;
    month = 0;
    now_month = 0;
    birth = NO;
    num = 1;
    next = NO;
    CGFloat x = startDayCellOfX;
    CGFloat y = startDayCellOfY;
    for (int i=0; i<6; i++)
    {
        for (int j=0; j<7; j++) {
            labels[i][j] = [[UILabel alloc] initWithFrame:CGRectMake(x+2, y-1, dayCellWidth, dayCellHeight)];
            [labels[i][j] setAlpha:0];
             x += dayCellWidth + subDistanceOfX;
            [labels[i][j] setFont:PMFont3 ];
            [labels[i][j] setTextAlignment:NSTextAlignmentCenter];
            [labels[i][j] setBackgroundColor:[UIColor clearColor]];
            [labels[i][j] setTextColor:PMColor6];
            [self addSubview:labels[i][j]];
            gestureRecognizer[i][j] = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dayClicked:)];
            [labels[i][j] setUserInteractionEnabled:YES];
            [labels[i][j] addGestureRecognizer:gestureRecognizer[i][j]];
        }
        x = startDayCellOfX;
        y += dayCellHeight + subDistanceOfY;
    }

    _preBtn = [[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 52, 64)];
    [_preBtn setIconImg:[UIImage imageNamed:@"tri_gray_left.png"]];
    [_preBtn setIconSize:CGSizeMake(16, 28)];
    [_preBtn adjustLayout];
    [_preBtn addTarget:self action:@selector(preMonth) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_preBtn];
    
    _nextBtn = [[AFTextImgButton alloc] initWithFrame:CGRectMake(188, 0, 52, 64)];
    [_preBtn setIconImg:[UIImage imageNamed:@"tri_gray_right.png"]];
    [_preBtn setIconSize:CGSizeMake(16, 28)];
    [_preBtn adjustLayout];
    [_nextBtn addTarget:self action:@selector(nextMonth) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextBtn];
    
    
    
    
    yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 56, 60)];
    yearLabel.font = PMFont1;
    yearLabel.backgroundColor = [UIColor clearColor];
    yearLabel.textColor = PMColor6;
    yearLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:yearLabel];
    monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 56, 60)];
    monthLabel.font = PMFont1;
    monthLabel.backgroundColor = [UIColor clearColor];
    monthLabel.textColor = PMColor6;
    monthLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:monthLabel];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 136, 64)];
    titleLabel.font = PMFont2;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = PMColor6;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
}

- (void)nowMonth
{
    
    [_preBtn setAlpha:1];
    [_nextBtn setAlpha:0];
    NSArray *ages = [[NSDate date] ageFromDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
      NSDate *date = [[[[DiaryModel sharedDiaryModel] diaries ] objectAtIndex:[[[DiaryModel sharedDiaryModel] diaries] count]-1] DCreateTime];
    if ([ages count] == 3) {
        NSDateComponents *comp_nowMonth = [[NSDateComponents alloc] init];
        [comp_nowMonth setDay:[[ages objectAtIndex:2] intValue]*(-1)+1];
        date_firstDay = [[NSCalendar currentCalendar] dateByAddingComponents:comp_nowMonth toDate:[NSDate date] options:0];
        NSDateComponents* compNextMonth = [[NSDateComponents alloc]init];
        [compNextMonth setMonth:1];
        date_nextFirstDay = [[NSCalendar currentCalendar] dateByAddingComponents:compNextMonth toDate:date_firstDay options:0];
        NSDateComponents *comp_lastDay = [[NSDateComponents alloc] init];
        [comp_lastDay setDay:-1];
        NSDate *date_lastDay = [[NSCalendar currentCalendar] dateByAddingComponents:comp_lastDay toDate:date_nextFirstDay options:0];
        days = [[[date_lastDay ageFromDate:date_firstDay] objectAtIndex:2] intValue];
    
        now_day = [[[[NSDate date] ageFromDate:date_firstDay] objectAtIndex:2] intValue];
        now_month = [[ages objectAtIndex:0] integerValue]*12 +[[ages objectAtIndex:1] integerValue];
        month = now_month;
        
        
        NSArray *availiavbleAge = [date ageFromDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
        if ([availiavbleAge count] == 3) {
            if (month <= [[availiavbleAge objectAtIndex:0] integerValue]*12 + [[availiavbleAge objectAtIndex:1] integerValue]) {
                [_preBtn setAlpha:0];
            }
        }
        birth = YES;
        
    }else{
        
        NSDateComponents *comp_nowMonth = [[NSDateComponents alloc] init];
        [comp_nowMonth setDay:[[ages objectAtIndex:1] intValue]*(-1)-1];
        date_firstDay = [[NSCalendar currentCalendar] dateByAddingComponents:comp_nowMonth toDate:[NSDate date] options:0];
        NSDateComponents* compNextMonth = [[NSDateComponents alloc]init];
        [compNextMonth setMonth:1];
        date_nextFirstDay = [[NSCalendar currentCalendar] dateByAddingComponents:compNextMonth toDate:date_firstDay options:0];
        NSDateComponents *comp_lastDay = [[NSDateComponents alloc] init];
        [comp_lastDay setDay:-1];
        NSDate *date_lastDay = [[NSCalendar currentCalendar] dateByAddingComponents:comp_lastDay toDate:date_nextFirstDay options:0];
        days = [[[date_lastDay ageFromDate:date_firstDay] objectAtIndex:2] intValue] +1;
        
        now_day = [[[[NSDate date] ageFromDate:date_firstDay] objectAtIndex:2] intValue] +1;
        now_month = [[ages objectAtIndex:0] integerValue];
        month = now_month;
        NSArray *availiavbleAge = [date ageFromDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
        if ([availiavbleAge count] == 2) {
            if (month <= [[availiavbleAge objectAtIndex:0] integerValue]) {
                [_preBtn setAlpha:0];
            }
            
        }
        birth = NO;
    }
   
    [_nextBtn setAlpha:0];
   
    
    [self refresh];
}

- (void)preMonth
{
    date_nextFirstDay = date_firstDay;
    NSDateComponents *comp_lastDay = [[NSDateComponents alloc] init];
    [comp_lastDay setDay:-1];
    NSDate *date_lastDay = [[NSCalendar currentCalendar] dateByAddingComponents:comp_lastDay toDate:date_firstDay options:0];
    NSDateComponents* compPreMonth = [[NSDateComponents alloc]init];
    [compPreMonth setMonth:-1];
    date_firstDay = [[NSCalendar currentCalendar] dateByAddingComponents:compPreMonth toDate:date_firstDay options:0];
   
    days = [[[date_lastDay ageFromDate:date_firstDay] objectAtIndex:2] intValue] ;
    month --;
    num = 0;
    next = NO;
    [_nextBtn setAlpha:1];
    NSDate *date = [[[[DiaryModel sharedDiaryModel] diaries ] objectAtIndex:[[[DiaryModel sharedDiaryModel] diaries] count]-1] DCreateTime];

    NSArray *availiavbleAge = [date ageFromDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
    if ([availiavbleAge count] == 3) {
        if (month <= [[availiavbleAge objectAtIndex:0] integerValue]*12 + [[availiavbleAge objectAtIndex:1] integerValue]) {
            [_preBtn setAlpha:0];
             num = 1;
        }
    }else{
 
        if (month <= [[availiavbleAge objectAtIndex:0] integerValue]-40) {
            [_preBtn setAlpha:0];
             num = 1;
        }
    }

     [self refresh];
    
}

-(void)nextMonth
{
   
    date_firstDay = date_nextFirstDay;
    NSDateComponents* compNextMonth = [[NSDateComponents alloc]init];
    [compNextMonth setMonth:1];
    date_nextFirstDay = [[NSCalendar currentCalendar] dateByAddingComponents:compNextMonth toDate:date_firstDay options:0];
    NSDateComponents *comp_lastDay = [[NSDateComponents alloc] init];
    [comp_lastDay setDay:-1];
    NSDate *date_lastDay = [[NSCalendar currentCalendar] dateByAddingComponents:comp_lastDay toDate:date_nextFirstDay options:0];
    days = [[[date_lastDay ageFromDate:date_firstDay] objectAtIndex:2] intValue] ;
    month ++;
    next = YES;
    
  
    if (month >= now_month) {
        [_nextBtn setAlpha:0];
        [_preBtn setAlpha:1];
        num = 1;
    }else{
        num = 0;
    }
    [self refresh];
    
}

- (void)dayClicked:(UIGestureRecognizer *)sender
{

    for (int i=0; i<6; i++)
        for (int j=0; j<7; j++)
        {
            if (gestureRecognizer[i][j] == sender)
            {
                NSDateComponents *comp_day = [[NSDateComponents alloc] init];
                [comp_day setDay:i*7+j];
                NSDate *date_day = [[NSCalendar currentCalendar] dateByAddingComponents:comp_day toDate:date_firstDay options:0];
                NSInteger index = [[DiaryModel sharedDiaryModel] indexForDiaryInDay:date_day];
                if (index >= 0) {
                    [[DiaryViewController sharedDiaryViewController] showDiaryAtIndex:index];
                }
            }
        }
}

-(void)refresh
{
   

    for (int i=0; i<6; i++) {
            for (int j=0; j<7; j++) {
                
                if (i*7+j+1 <= days) {
                    [labels[i][j] setAlpha:1];
                    [labels[i][j] setText:[NSString stringWithFormat:@"%d",i*7+j+1 ]];
                }else{
                    [labels[i][j] setAlpha:0];
                }
                
                if (month < now_month) {
                    [labels[i][j] setTextColor: PMColor2];
                    [labels[i][j] setBackgroundColor:[UIColor clearColor]];
                }else if(month == now_month){
                    if (i*7+j+1 < now_day) {
                        [labels[i][j] setTextColor:PMColor2];
                         [labels[i][j] setBackgroundColor:[UIColor clearColor]];
                    }else if (i*7+j+1 == now_day){
                        [labels[i][j] setTextColor:[UIColor whiteColor]];
                        [labels[i][j] setBackgroundColor:PMColor6];
                        
                    }else{
                        [labels[i][j] setTextColor:PMColor6];
                         [labels[i][j] setBackgroundColor:[UIColor clearColor]];
                    }
                    
                    
                    
                }else{
                    [labels[i][j] setTextColor: PMColor6];
                    [labels[i][j] setBackgroundColor:[UIColor clearColor]];
                }
                
                NSDateComponents *comp_day = [[NSDateComponents alloc] init];
                [comp_day setDay:i*7+j];
                NSDate *date_day = [[NSCalendar currentCalendar] dateByAddingComponents:comp_day toDate:date_firstDay options:0];
                if ([[DiaryModel sharedDiaryModel] indexForDiaryInDay:date_day ] >= 0) {
                    [labels[i][j] setTextColor:[UIColor whiteColor]];
                    [labels[i][j] setBackgroundColor:PMColor6];
                    num ++;
                }
                
            }}

    if (num >0) {
        [self setTitleWithBirth];
    }else{
        if (next) {
            [self nextMonth];
        }else{
            [self preMonth];
        }
      
    }
  
}


- (void)setTitleWithBirth
{
    
    if (birth) {
        if (month >= 0 ) {
            int year = (month+1)/13;
            if (year > 0) {

                    [titleLabel setText:@"年       个月"];
                    [yearLabel setText:[NSString stringWithFormat:@"%d",year]];
                    [monthLabel setText:[NSString stringWithFormat:@"%d",month%12 +1]];
                    [yearLabel setAlpha:1];
                    [monthLabel setAlpha:1];
                    SetViewLeftUp(monthLabel, 96, 0);
                    SetViewLeftUp(yearLabel, 52, 0);
                    SetViewLeftUp(titleLabel, 64, 0);

                
            }else{
                [titleLabel setText:@"个月"];
                [monthLabel setText:[NSString stringWithFormat:@"%d ",month+1]];
                
                [yearLabel setAlpha:0];
                [monthLabel setAlpha:1];
                
                SetViewLeftUp(monthLabel, 76, 0);
                SetViewLeftUp(titleLabel, 64, 0);
            }

        }else{
            [titleLabel setText:[NSString stringWithFormat:@"孕期%d周",month+40 +1]];
            [yearLabel setAlpha:0];
            [monthLabel setAlpha:0];
            SetViewLeftUp(titleLabel, 48, 0);
        }
        
        
        
    }else{
    
        [titleLabel setText:[NSString stringWithFormat:@"孕期%d周",month]];
        [yearLabel setAlpha:0];
        [monthLabel setAlpha:0];
        SetViewLeftUp(titleLabel, 48, 0);
    }

    
}

- (BOOL)getBitrh;
{
    return birth;
}
- (NSInteger)getmonth
{
    return month;
}
@end
