//
//  AddInfoCalendar.h
//  puman
//
//  Created by 祁文龙 on 13-10-24.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "SelectCalendarView.h"
@protocol AddInfoCalendarDelegate;
@interface AddInfoCalendar : SelectCalendarView
@property (nonatomic, weak) id<AddInfoCalendarDelegate> delegate;
@end
@protocol AddInfoCalendarDelegate <NSObject>

- (void)calendar:(AddInfoCalendar *)calendar selectedButton:(DateButton *)date;

@end