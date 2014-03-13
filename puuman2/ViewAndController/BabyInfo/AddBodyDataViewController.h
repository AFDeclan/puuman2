//
//  AddBodyDataViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-13.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "RulerScrollView.h"
#import "CustomTextField.h"
#import "AddInfoCalendar.h"

@interface AddBodyDataViewController : CustomPopViewController<RulerScrollDelegate,AddInfoCalendarDelegate,UIGestureRecognizerDelegate>
{
    float height;
    float weight;
    RulerScrollView *rulerOfHeight;
    RulerScrollView *rulerOfWeight;
    BOOL heightScrolled;
    BOOL weightScrolled;
    UILabel *heightLabel;
    UILabel *weightLabel;
    CustomTextField  *dateTextField;
     UIView *calendarView;
    NSDate *date;
}
@end
