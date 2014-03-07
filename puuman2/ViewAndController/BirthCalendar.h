//
//  BirthCalendar.h
//  puman
//
//  Created by 祁文龙 on 13-10-24.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "SelectCalendarView.h"
@protocol BirthCalendarDelegate;
@interface BirthCalendar : SelectCalendarView
@property (nonatomic, weak) id<BirthCalendarDelegate> delegate;
@end
@protocol BirthCalendarDelegate <NSObject>

- (void)calendar:(BirthCalendar *)calendar selectedButton:(DateButton *)date;

@end