//
//  PregnancyCalendar.h
//  puman
//
//  Created by 祁文龙 on 13-10-24.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "SelectCalendarView.h"
@protocol PregnancyCalendarDelegate;

@interface PregnancyCalendar : SelectCalendarView
@property (nonatomic, weak) id<PregnancyCalendarDelegate> delegate;
@end

@protocol PregnancyCalendarDelegate <NSObject>
- (void)calendar:(PregnancyCalendar *)_calendar selectedButton:(DateButton *)date;
@end