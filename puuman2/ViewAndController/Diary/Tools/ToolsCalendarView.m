//
//  ToolsCalendarView.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-21.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "ToolsCalendarView.h"
#import "NSDate+Compute.h"
#import "UserInfo.h"

@implementation ToolsCalendarView

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
    [super initialization];
    [self setContentView];
    self.layer.masksToBounds = YES;
}

- (void)setContentView
{
    [content setFrame:CGRectMake(0, 0, 240, 288+48)];

    calender = [[CalenderView alloc] initWithFrame:CGRectMake(0, 0, 240, 286)];
    [content addSubview:calender];
    [calender setAlpha:0];
    ageCalenderView = [[AgeCalenderView alloc] initWithFrame:CGRectMake(0, 0, 240, 286)];
    [content addSubview:ageCalenderView];
    [ageCalenderView setAlpha:0];
    [ageCalenderView setBackgroundColor:[UIColor clearColor]];

    ageBtn = [[ColorButton alloc] init];
    [ageBtn initWithTitle:@"按年龄" andButtonType:kBlueLeft];
    [ageBtn addTarget:self action:@selector(selectedAge) forControlEvents:UIControlEventTouchUpInside];
    [content addSubview:ageBtn];
    timeBtn = [[ColorButton alloc] init];
    [timeBtn initWithTitle:@"按时间" andButtonType:kBlueRight];
    [timeBtn addTarget:self action:@selector(selectedTime) forControlEvents:UIControlEventTouchUpInside];
    [content addSubview:timeBtn];
    SetViewLeftUp(ageBtn, 8, 286);
    SetViewLeftUp(timeBtn, 120, 286);
    [self selectedAge];
}

- (void)selectedAge
{
    isAge = YES;
    [timeBtn unSelected];
    [ageBtn selected];
    [calender setAlpha:0];
    [ageCalenderView setAlpha:1];
    [ageCalenderView refreshInfo];

}

- (void)selectedTime
{
    isAge = NO;
    [timeBtn selected];
    [ageBtn unSelected];
    [calender setAlpha:1];
    [ageCalenderView setAlpha:0];
    [calender refreshInfo];

}

- (void)refreshInfo
{
    if (isAge) {
        [ageCalenderView refreshInfo];
    }else{
        [calender refreshInfo];
    }

}




+(float)heightWithTheIndex:(NSInteger)index
{
    return 288+64 ;
}

@end
