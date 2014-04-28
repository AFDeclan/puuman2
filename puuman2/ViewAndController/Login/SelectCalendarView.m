//
//  SelectCalendarView.m
//  puman
//
//  Created by 祁文龙 on 13-10-24.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "SelectCalendarView.h"
#import "SelectButton.h"
#import "MobClick.h"
#import "UmengDefine.h"

@interface SelectCalendarView ()
@property(nonatomic, strong) UIView *highlight;
@property(nonatomic, strong) UILabel *titleLabel;


@property(nonatomic, strong) UIView *calendarContainer;
@property(nonatomic, strong) UIView *daysHeader;
@property(nonatomic, strong) NSArray *dayOfWeekLabels;
@property(nonatomic, strong) NSMutableArray *dateButtons;

@property(nonatomic, assign) CGFloat cellWidth;

@end
@implementation SelectCalendarView
@synthesize highlight = _highlight;
@synthesize titleLabel = _titleLabel;
@synthesize calendar = _calendar;
@synthesize prevButton = _prevButton;
@synthesize nextButton = _nextButton;
@synthesize calendarContainer = _calendarContainer;
@synthesize daysHeader = _daysHeader;
@synthesize dayOfWeekLabels = _dayOfWeekLabels;
@synthesize dateButtons = _dateButtons;
@synthesize monthShowing = _monthShowing;
@synthesize selectedDate = _selectedDate;
@synthesize cellWidth = _cellWidth;

@synthesize selectedDateTextColor = _selectedDateTextColor;
@synthesize selectedDateBackgroundColor = _selectedDateBackgroundColor;
@synthesize availableDateTextColor = _availableDateTextColor;
@synthesize unavailableDateTextColor = _unavailableDateTextColor;
@synthesize dateBackgroundColor =_dateBackgroundColor;
@synthesize currentDateTextColor = _currentDateTextColor;
@synthesize currentDateBackgroundColor = _currentDateBackgroundColor;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [_calendar setLocale:[NSLocale currentLocale]];
        [_calendar setFirstWeekday:startSunday];
        self.layer.cornerRadius = 6.0f;
        self.layer.shadowOffset = CGSizeMake(2, 2);
        self.layer.shadowRadius = 2.0f;
      //  self.layer.shadowOpacity = 0.1f;
        
        UIView *highlight = [[UIView alloc] initWithFrame:CGRectZero];
        highlight.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
        highlight.layer.cornerRadius = 6.0f;
        [self addSubview:highlight];
        self.highlight = highlight;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
         _prevButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _prevButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
        [_prevButton addTarget:self action:@selector(moveCalendarToPreviousMonth) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *flag = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, 14, 17)];
        [flag setImage:[UIImage imageNamed:@"left_arrow.png"]];
        [_prevButton addSubview:flag];
        [self addSubview:_prevButton];
        
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
         _nextButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        [_nextButton addTarget:self action:@selector(moveCalendarToNextMonth) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_nextButton];
        UIImageView *flag2 = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, 14, 17)];
        [flag2 setImage:[UIImage imageNamed:@"right_arrow.png"]];
        [_nextButton addSubview:flag2];
        _calendarContainer = [[UIView alloc] initWithFrame:CGRectZero];
        _calendarContainer.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        _calendarContainer.layer.cornerRadius = 4.0f;
        _calendarContainer.clipsToBounds = YES;
        [self addSubview:_calendarContainer];
        
        _daysHeader = [[UIView alloc] initWithFrame:CGRectZero];
        _daysHeader.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        [self.calendarContainer addSubview:_daysHeader];
        
        NSMutableArray *labels = [NSMutableArray array];
        for (NSString *day in [self getDaysOfTheWeek]) {
            UILabel *dayOfWeekLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            dayOfWeekLabel.text = day;
            dayOfWeekLabel.textAlignment = UITextAlignmentCenter;
            dayOfWeekLabel.backgroundColor = [UIColor clearColor];
            [labels addObject:dayOfWeekLabel];
            [self.calendarContainer addSubview:dayOfWeekLabel];
        }
        self.dayOfWeekLabels = labels;
        NSMutableArray *dateButtons = [NSMutableArray array];
        for (int i = 0; i < 43; i++) {
            DateButton *dateButton = [DateButton buttonWithType:UIButtonTypeCustom];
            [dateButton setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
            [dateButtons addObject:dateButton];
        }
        self.dateButtons = dateButtons;
        
       
       
        
        
        
        self.monthShowing = [NSDate date];
       selectDateButton = [[UIButton alloc] initWithFrame:CGRectMake(SELECT_BUTTON_X, SELECT_BUTTON_Y, SELECT_BUTTON_WIDTH, SELECT_BUTTON_HEIFHT)];
       [selectDateButton setImage:[UIImage imageNamed:@"tri_baby_diary.png"] forState:UIControlStateNormal];
        UIImageView *flag3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SELECT_BUTTON_WIDTH, SELECT_BUTTON_HEIFHT)];
        [flag3 setImage:[UIImage imageNamed:@"tri_baby_diary.png"]];
        [selectDateButton addSubview:flag3];
        [selectDateButton addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectDateButton];
        yearButtons = [[NSMutableArray alloc] init];
        monthButtons = [[NSMutableArray alloc] init];
       

        
        
    }
    return self;
}


- (void)initSelectViewWithFromDate:(NSDate *)firstDate toDate:(NSDate *)lastDate
{
    date_last = lastDate;
    date_first = firstDate;
    
}
- (void)selectDate:(UIButton *)sender
{
    
    [MobClick event:umeng_event_click label:@"SelectDate_SelectCalendarView"];
    
    [sender setAlpha:0];
    if (selectDateView) {
     
        for (int i = 0 ; i <[yearButtons count]; i++) {
           [[yearButtons objectAtIndex:i] removeFromSuperview];

        }
        for (int i = 0 ; i <[monthButtons count]; i++) {
            [[monthButtons objectAtIndex:i] removeFromSuperview];
            
        }
        [monthButtons removeAllObjects];
        [yearButtons  removeAllObjects];
        if (yearView) {
            [yearView removeFromSuperview];
        }
        [selectDateView removeFromSuperview];
    }
    selectDateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    selectDateView.layer.cornerRadius = 6.0f;
    selectDateView.layer.shadowOffset = CGSizeMake(2, 2);
    selectDateView.layer.shadowRadius = 2.0f;
    [selectDateView setBackgroundColor:PMColor4];
    
    subdistance =(self.frame.size.height-190-24)/2+24;
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(150,subdistance, 1, 190)];
    [view setBackgroundColor:PMColor1];
    [selectDateView addSubview:view];
    yearView = [[UIScrollView alloc] initWithFrame:CGRectMake(166, subdistance, 100, 190)];
    [selectDateView addSubview:yearView];
    [self initMonthButtons];
    [self initYearButtons];
  
    [self addSubview:selectDateView];
    UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(260, 8, 24, 24)];
    [close setImage:[UIImage imageNamed:@"btn_close_set.png"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closeSelect) forControlEvents:UIControlEventTouchUpInside];
    
    [selectDateView addSubview:close];
    
    
}
- (void)closeSelect
{ [MobClick event:umeng_event_click label:@"CloseSelect_SelectCalendarView"];
    [selectDateButton setAlpha:1];
    [selectDateView removeFromSuperview];
}

- (void)initMonthButtons
{
    //月份
   
    for (int i =0; i < 12; i ++) {
        NSString *monthString = [[self getMonthsOfYear] objectAtIndex:i];
        CGSize size = [monthString  sizeWithFont:PMFont2];
        SelectButton *monthOfYearButton = [[SelectButton alloc] initWithFrame:CGRectMake(24+((int)(i/6))*51,subdistance+35*(i%6),size.width , size.height)];
        monthOfYearButton.label.text = monthString;
        monthOfYearButton.myTag = i+1;
        [monthOfYearButton addTarget:self action:@selector(monthButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [selectDateView addSubview:monthOfYearButton];
        [monthButtons addObject:monthOfYearButton];
    }
}
- (void)monthButtonPressed:(SelectButton *)sender
{
    [MobClick event:umeng_event_click label:@"MonthButtonPressed_SelectCalendarView"];
   [sender setBackgroundColor:PMColor2];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp_now = [calendar components:unit fromDate:self.monthShowing];
    NSInteger passMonth = (yearSelected-[comp_now year])*12+sender.myTag-[comp_now month];
    NSDateComponents* comp_m = [[NSDateComponents alloc]init];
    [comp_m setMonth:passMonth];
    NSDate *date_m = [self.calendar dateByAddingComponents:comp_m toDate:self.monthShowing options:0];
    self.monthShowing = date_m;
    [selectDateButton setAlpha:1];
    [selectDateView removeFromSuperview];
}
- (void)initYearButtons
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp_last= [calendar components:unit fromDate:date_last];
    if (date_first == nil) {
        for (int i = 1; i <=CommonYearsNum; i++) {
            NSString *title = [NSString stringWithFormat:@"%d",[comp_last year]-CommonYearsNum+i];
            CGSize size = [title sizeWithFont:PMFont2];
            
            SelectButton *button  = [[SelectButton alloc] initWithFrame:CGRectMake(24, 32*(i-1), size.width, size.height)];
            button.label.text = title;
            button.myTag = [comp_last year]-CommonYearsNum+i;
            [button addTarget:self action:@selector(yearButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [yearView addSubview:button];
            [yearView setContentSize:CGSizeMake(100,32*(i-1)+size.height)];
            [yearButtons addObject:button];
        }
        
    }else
    {
         NSDateComponents *comp_first = [calendar components:unit fromDate:date_first];
        for (int i = 0; i <=[comp_last year]-[comp_first year]; i ++)
        {
            NSString *title = [NSString stringWithFormat:@"%d",[comp_first year]+i];
            CGSize size = [title sizeWithFont:PMFont2];
            
            SelectButton *button  = [[SelectButton alloc] initWithFrame:CGRectMake(24, 24+32*i, size.width, size.height)];
            button.label.text = title;
            button.myTag =[comp_first year]+i;
            [button addTarget:self action:@selector(yearButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [yearView addSubview:button];
            [button setBackgroundColor:[UIColor redColor]];
            [yearView setContentSize:CGSizeMake(100,24+32*i+size.height)];
            [yearButtons addObject:button];
       }
  
    }
    if (yearView.contentSize.height>yearView.frame.size.height) {
        yearView.contentOffset = CGPointMake(0, yearView.contentSize.height-yearView.frame.size.height);
    }
     NSDateComponents *comp_now = [calendar components:unit fromDate:self.monthShowing];
    
    for (int i = 0 ; i <[yearButtons count]; i++) {
        SelectButton *button = [yearButtons objectAtIndex:i];
        if (button.myTag == [comp_now year]) {
            [self yearButtonPressed:button];
        }
    }
  
}
- (void)yearButtonPressed:(SelectButton *)sender
{
    [MobClick event:umeng_event_click label:@"YearButtonPressed_SelectCalendarView"];
    yearSelected = sender.myTag;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp_last = [calendar components:unit fromDate:date_last];
    NSDateComponents *comp_first = [calendar components:unit fromDate:date_first];
    for (int i = 0 ; i < [monthButtons count];i++) {
        SelectButton *button = [monthButtons objectAtIndex:i];
   
        if ([comp_last year] == [comp_first year]) {
            if (i+1 > [comp_last month] || i+1 < [comp_first month]) {
                [button setEnabled:NO];
                [button setAlpha:0.5];
            }else
            {
                [button setEnabled:YES];
                [button setAlpha:1];
                
            }
        }else
        {
            if (yearSelected == [comp_last year]) {
                if (i+1 > [comp_last month] ) {
                    [button setEnabled:NO];
                    [button setAlpha:0.5];
                }else
                {
                    [button setEnabled:YES];
                    [button setAlpha:1];
                }

            }else if (yearSelected == [comp_first year]) {
                if ( i+1 < [comp_first month]) {
                    [button setEnabled:NO];
                     [button setAlpha:0.5];
                }else
                {
                    [button setEnabled:YES];
                    [button setAlpha:1];
                }

                
            }else
            {
      
              [button setEnabled:YES];
              [button setAlpha:1];

            }
        }
    }
    for (int i = 0 ; i <[yearButtons count]; i++) {
        [[yearButtons objectAtIndex:i] setBackgroundColor:[UIColor clearColor]];
        
    }
    [sender setBackgroundColor:PMColor2];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat containerWidth = self.bounds.size.width - (CALENDAR_MARGIN * 2);
    self.cellWidth = (containerWidth / 7.0) - CELL_BORDER_WIDTH;
    CGFloat containerHeight = ([self numberOfWeeksInMonthContainingDate:self.monthShowing] * (self.cellWidth + CELL_BORDER_WIDTH) + DAYS_HEADER_HEIGHT);
    
    CGRect newFrame = self.frame;
    newFrame.size.height = containerHeight + CALENDAR_MARGIN + TOP_HEIGHT;
    self.frame = newFrame;
    _highlight.frame = CGRectMake(1, 1, self.bounds.size.width - 2, 1);
    
    _titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, TOP_HEIGHT);
    _prevButton.frame = CGRectMake(BUTTON_MARGIN, BUTTON_MARGIN, 48, 38);
    _nextButton.frame = CGRectMake(self.bounds.size.width - 48 - BUTTON_MARGIN, BUTTON_MARGIN, 48, 38);
    
    _calendarContainer.frame = CGRectMake(CALENDAR_MARGIN, CGRectGetMaxY(self.titleLabel.frame), containerWidth, containerHeight);
    _daysHeader.frame = CGRectMake(0, 0, self.calendarContainer.frame.size.width, DAYS_HEADER_HEIGHT);
    
    CGRect lastDayFrame = CGRectZero;
    for (UILabel *dayLabel in self.dayOfWeekLabels) {
        dayLabel.frame = CGRectMake(CGRectGetMaxX(lastDayFrame) + CELL_BORDER_WIDTH, lastDayFrame.origin.y, self.cellWidth, self.daysHeader.frame.size.height);
        lastDayFrame = dayLabel.frame;
    }

    
    for (DateButton *dateButton in self.dateButtons) {
        [dateButton removeFromSuperview];
    }
    NSDate *date = [self firstDayOfMonthContainingDate:self.monthShowing];
    uint dateButtonPosition = 0;
    while ([self dateIsInMonthShowing:date]) {
        DateButton *dateButton = [self.dateButtons objectAtIndex:dateButtonPosition];
        
        dateButton.date = date;
        if ([dateButton.date isEqualToDate:_selectedDate]) {
            dateButton.backgroundColor = self.selectedDateBackgroundColor;
            [dateButton setTitleColor:_selectedDateTextColor forState:UIControlStateNormal];
        } else if ([self dateIsToday:dateButton.date]) {
            [dateButton setTitleColor:_currentDateTextColor forState:UIControlStateNormal];
            dateButton.backgroundColor = _currentDateBackgroundColor;
        } else if ([self dateIsAvailable:dateButton.date])
        {
            dateButton.backgroundColor = _dateBackgroundColor;
            [dateButton setTitleColor:_availableDateTextColor forState:UIControlStateNormal];
        }else
        {
             dateButton.backgroundColor = _dateBackgroundColor;
            [dateButton setTitleColor:_unavailableDateTextColor forState:UIControlStateNormal];
        }
        
        [dateButton addTarget:self action:@selector(dateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        dateButton.frame = [self calculateDayCellFrame:date];
        [self.calendarContainer addSubview:dateButton];
        date = [self nextDay:date];
        dateButtonPosition++;
        
    }

    
    
}

- (void)moveCalendarToPreviousMonth {
    [MobClick event:umeng_event_click label:@"MoveCalendarToPreviousMonth_SelectCalendarView"];
    _nextButton.alpha = 1;
//    NSDate *date_m = [[self firstDayOfMonthContainingDate:self.monthShowing] dateByAddingTimeInterval:-100000];
//    self.monthShowing = date_m;
}
- (void)moveCalendarToNextMonth {
    [MobClick event:umeng_event_click label:@"MoveCalendarToNextMonth_SelectCalendarView"];
    _prevButton.alpha = 1;
//    NSDateComponents* comp_m = [[NSDateComponents alloc]init];
//    [comp_m setMonth:1];
//    NSDate *date_m = [self.calendar dateByAddingComponents:comp_m toDate:self.monthShowing options:0];
//    self.monthShowing = date_m;
    
}

- (void)setMonthShowing:(NSDate *)aMonthShowing {
    _monthShowing = aMonthShowing;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY年 M月";
    self.titleLabel.text = [dateFormatter stringFromDate:aMonthShowing];
    [self setNeedsLayout];
    
}
- (void)dateButtonPressed:(DateButton *)sender {

      [MobClick event:umeng_event_click label:@"DateButtonPressed_SelectCalendarView"];
    for (int i = 0; i<[self.dateButtons count]; i++)
    {
        DateButton *dateButton = [_dateButtons objectAtIndex:i];
        if ([dateButton.date isEqualToDate:_selectedDate]) {
            dateButton.backgroundColor = self.selectedDateBackgroundColor;
            [dateButton setTitleColor:_selectedDateTextColor forState:UIControlStateNormal];
        } else if ([self dateIsToday:dateButton.date]) {
            [dateButton setTitleColor:_currentDateTextColor forState:UIControlStateNormal];
            dateButton.backgroundColor = _currentDateBackgroundColor;
         } else if ([self dateIsAvailable:dateButton.date])
         {
            dateButton.backgroundColor = _dateBackgroundColor;
            [dateButton setTitleColor:_availableDateTextColor forState:UIControlStateNormal];
        }else
        {
            dateButton.backgroundColor = _dateBackgroundColor;
            [dateButton setTitleColor:_unavailableDateTextColor forState:UIControlStateNormal];
        }
    }

}


- (NSDate *)nextDay:(NSDate *)date {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    return [self.calendar dateByAddingComponents:comps toDate:date options:0];
}
- (CGRect)calculateDayCellFrame:(NSDate *)date {
    int row = [self weekNumberInMonthForDate:date] - 1;
    int placeInWeek = (([self dayOfWeekForDate:date] - 1) - self.calendar.firstWeekday + 8) % 7;
    
    return CGRectMake(placeInWeek * (self.cellWidth + CELL_BORDER_WIDTH), (row * (self.cellWidth + CELL_BORDER_WIDTH)) + CGRectGetMaxY(self.daysHeader.frame) + CELL_BORDER_WIDTH, self.cellWidth, self.cellWidth);
}
- (int)dayOfWeekForDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:NSWeekdayCalendarUnit fromDate:date];
    return comps.weekday;
}
- (int)weekNumberInMonthForDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:(NSWeekOfMonthCalendarUnit) fromDate:date];
    return comps.weekOfMonth;
}


- (BOOL)dateIsAvailable:(NSDate *)date
{
    return YES;
}
- (BOOL)dateIsToday:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp_ = [calendar components:unit fromDate:date];
    NSDateComponents *comp_now = [calendar components:unit fromDate:[NSDate date]];
    if ([comp_ year] == [comp_now year] && [comp_ month] == [comp_now month] && [comp_ day] == [comp_now day])
        return YES;
    else return NO;
}
- (BOOL)dateIsInMonthShowing:(NSDate *)date {
    NSDateComponents *comps1 = [self.calendar components:(NSMonthCalendarUnit) fromDate:self.monthShowing];
    NSDateComponents *comps2 = [self.calendar components:(NSMonthCalendarUnit) fromDate:date];
    return comps1.month == comps2.month;
}
- (NSDate *)firstDayOfMonthContainingDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    [comps setDay:1];
    return [self.calendar dateFromComponents:comps];
}
- (int)numberOfWeeksInMonthContainingDate:(NSDate *)date {
    return [self.calendar rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:date].length;
}
- (NSArray *)getDaysOfTheWeek {
    NSArray *weekdays = [[NSArray alloc] initWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
    return weekdays;
}
- (NSArray *)getMonthsOfYear {
    NSArray *months = [[NSArray alloc] initWithObjects:@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月", nil];
    return months;
}
- (void)setTitleFont:(UIFont *)font
{
    _titleLabel.font = font;
}
- (void)setTitleColor:(UIColor *)color
{
    _titleLabel.textColor = color;
}
- (void)setDateButtonColor:(UIColor *)color
{
    _dateBackgroundColor = color;
}
- (void)setDayOfWeekFont:(UIFont *)font
{
    for (UILabel *label in self.dayOfWeekLabels) {
        label.font = font;
    }
}
- (void)setDayOfWeekTextColor:(UIColor *)color
{
    for (UILabel *label in self.dayOfWeekLabels) {
        label.textColor = color;
    }
}
- (void)setDateFont:(UIFont *)font
{
    for (DateButton *dateButton in self.dateButtons) {
        dateButton.titleLabel.font = font;
    }
}
- (void)setDateTextColor:(UIColor *)color
{
    for (DateButton *dateButton in self.dateButtons) {
        [dateButton setTitleColor:color forState:UIControlStateNormal];
    }
}
- (void)setDateSelectedBackgroundColor:(UIColor *)color
{
    _selectedDateBackgroundColor = color;
}
- (void)setTheAvailableDateTextColor:(UIColor *)color
{
    _availableDateTextColor = color;
}
- (void)setTheUnavailableDateTextColor:(UIColor *)color
{
    _unavailableDateTextColor = color;
}
- (void)setDateSelectedTextColor:(UIColor *)color
{
    _selectedDateTextColor = color;
}
- (void)setTodayDateBackgroundColor:(UIColor *)color
{
    _currentDateBackgroundColor = color;
}
- (void)setDateContainerColor:(UIColor *)color
{
    _calendarContainer.backgroundColor = color;
}
- (void)setInnerContainerColor:(UIColor *)color
{
    _calendarContainer.layer.borderColor = color.CGColor;
}
- (void)setTodayDateTextColor:(UIColor *)color
{
    _currentDateTextColor = color;
}
@end