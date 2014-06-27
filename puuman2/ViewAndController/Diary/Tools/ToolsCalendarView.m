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
    calender = [[CalenderView alloc] initWithFrame:CGRectMake(0, 0, 240, 248)];
    [content addSubview:calender];
    ageCalenderView = [[AgeCalenderView alloc] initWithFrame:CGRectMake(0, 0, 240, 248)];
    [content addSubview:calender];
    ageBtn = [[ColorButton alloc] init];
    [content addSubview:ageBtn];
    timeBtn = [[ColorButton alloc] init];
    [content addSubview:timeBtn];
    
    SetViewLeftUp(ageBtn, 0, 0);
    SetViewLeftUp(timeBtn, 0, 0);
}

- (void)refreshInfo
{
    

}




+(float)heightWithTheIndex:(NSInteger)index
{
    return 280 ;
}

@end
