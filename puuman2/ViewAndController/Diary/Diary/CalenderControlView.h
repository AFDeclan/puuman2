//
//  CalenderControlView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-18.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarView.h"
#import "AgeCalendarView.h"

@interface CalenderControlView : UIScrollView
{
    CalendarView *calendarView;
    AgeCalendarView *ageCalendarView;
    UIButton *selectNomalBtn;
    UIButton *selectAgeBtn;
    UILabel  *_monthLabel;
    UILabel *_yearLabel;
    
    UILabel *titleLabel;
    UILabel *yearLabel;
    UILabel *monthLabel;
}

- (void)show;
@end
