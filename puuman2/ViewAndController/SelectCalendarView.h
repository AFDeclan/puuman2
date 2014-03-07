//
//  SelectCalendarView.h
//  puman
//
//  Created by 祁文龙 on 13-10-24.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateButton.h"
#import "ColorsAndFonts.h"

#define BUTTON_MARGIN 4
#define CALENDAR_MARGIN 5
#define TOP_HEIGHT 44
#define DAYS_HEADER_HEIGHT 22
#define DEFAULT_CELL_WIDTH 43
#define CELL_BORDER_WIDTH 1

#define SELECT_BUTTON_WIDTH 160
#define SELECT_BUTTON_HEIFHT 44
#define SELECT_BUTTON_X  50
#define SELECT_BUTTON_Y  0
#define SELECT_VIEW_WIDTH 300
#define SELECT_VIEW_HEIGHT 236
#define CommonYearsNum 6
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

enum {
    startSunday = 1,
};


@interface SelectCalendarView : UIView
{
    UIButton *selectDateButton;
    UIView *selectDateView;
    NSDate *date_first;
    NSDate *date_last;
    NSMutableArray *yearButtons;
    NSMutableArray *monthButtons;
    UIScrollView * yearView;
    NSInteger yearSelected;
    float subdistance;
    
}
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSDate *monthShowing;
@property(nonatomic, strong) UIButton *prevButton;
@property(nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) UIColor *selectedDateTextColor;
@property (nonatomic, strong) UIColor *selectedDateBackgroundColor;
@property (nonatomic, strong) UIColor *currentDateTextColor;
@property (nonatomic, strong) UIColor *currentDateBackgroundColor;
@property (nonatomic, strong) UIColor *availableDateTextColor;
@property (nonatomic, strong) UIColor *unavailableDateTextColor;
@property (nonatomic, strong) UIColor *dateBackgroundColor;




- (void)setTitleFont:(UIFont *)font;
- (void)setTitleColor:(UIColor *)color;
- (void)setDateButtonColor:(UIColor *)color;
- (void)setDayOfWeekFont:(UIFont *)font;
- (void)setDayOfWeekTextColor:(UIColor *)color;
- (void)setDateFont:(UIFont *)font;
- (void)setDateTextColor:(UIColor *)color;
- (void)setDateSelectedBackgroundColor:(UIColor *)color;
- (void)setDateSelectedTextColor:(UIColor *)color;
- (void)setTheAvailableDateTextColor:(UIColor *)color;
- (void)setTheUnavailableDateTextColor:(UIColor *)color;
- (void)setTodayDateBackgroundColor:(UIColor *)color;
- (void)setTodayDateTextColor:(UIColor *)color;
- (void)setDateContainerColor:(UIColor *)color;
- (void)setInnerContainerColor:(UIColor *)color;


- (void)dateButtonPressed:(DateButton *)sender;
- (void)moveCalendarToNextMonth;
- (void)moveCalendarToPreviousMonth;
- (BOOL)dateIsAvailable:(NSDate *)date;
- (BOOL)dateIsToday:(NSDate *)date;
- (NSDate *)firstDayOfMonthContainingDate:(NSDate *)date;




- (void)initSelectViewWithFromDate:(NSDate *)firstDate toDate:(NSDate *)lastDate;




@end



