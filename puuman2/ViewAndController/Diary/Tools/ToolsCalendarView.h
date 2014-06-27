//
//  ToolsCalendarView.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-21.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "ToolsUnitView.h"
#import "CalenderView.h"
#import "AgeCalenderView.h"
#import "ColorButton.h"

@interface ToolsCalendarView : ToolsUnitView
{
    CalenderView *calender;
    AgeCalenderView *ageCalenderView;
    ColorButton *ageBtn;
    ColorButton *timeBtn;
}
@end
