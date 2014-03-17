//
//  PregnancyCalendar.m
//  puman
//
//  Created by 祁文龙 on 13-10-24.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "PregnancyCalendar.h"

@implementation PregnancyCalendar
@synthesize delegate = _delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.prevButton.alpha = 0;
        [self setDefaultStyle];
        
        NSDateComponents *comp_d = [[NSDateComponents alloc] init];
        [comp_d setDay:300];
        NSDate *date_d = [self.calendar dateByAddingComponents:comp_d toDate:[NSDate date] options:0];
        [self initSelectViewWithFromDate:[NSDate date] toDate:date_d];
    }
    return self;
}
- (void)dateButtonPressed:(DateButton *)sender
{
    
    [_delegate calendar:self selectedButton:sender];
    [super dateButtonPressed:sender];
    
}
- (BOOL)dateIsAvailable:(NSDate *)date
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp_ = [calendar components:unit fromDate:date];
    NSDateComponents *comp_now = [calendar components:unit fromDate:[NSDate date]];
    if ([comp_ year] > [comp_now year] ||
        ([comp_ year] == [comp_now year] && [comp_ month] > [comp_now month]) ||
        ([comp_ year] == [comp_now year] && [comp_ month] == [comp_now month] && [comp_ day] > [comp_now day]))
        return YES;
    else return NO;
}
- (void)moveCalendarToNextMonth
{
    [super moveCalendarToNextMonth];
    
    NSDateComponents* comp_m = [[NSDateComponents alloc]init];
    [comp_m setMonth:1];
    
    NSDateComponents *comp_d = [[NSDateComponents alloc] init];
    [comp_d setDay:300];
    
    NSDate *date_m = [self.calendar dateByAddingComponents:comp_m toDate:self.monthShowing options:0];
    NSDate *date_d = [self.calendar dateByAddingComponents:comp_d toDate:[NSDate date] options:0];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comps_m = [calendar components:unit fromDate:date_m];
    NSDateComponents *comps_d = [calendar components:unit fromDate:date_d];
    
    
    if (([comps_d month]<=[comps_m month]&&[comps_d year]==[comps_m year])||[comps_d year]<[comps_m year]) {
        self.nextButton.alpha = 0;
    }
    self.monthShowing = date_m;
    
    
}
- (void)moveCalendarToPreviousMonth
{
    [super moveCalendarToPreviousMonth];
    NSDate *date_m = [[self firstDayOfMonthContainingDate:self.monthShowing] dateByAddingTimeInterval:-100000];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comps_m = [calendar components:unit fromDate:date_m];
    NSDateComponents *comps_now = [calendar components:unit fromDate:[NSDate date]];
    
    if (([comps_now month]>=[comps_m month]&&[comps_now year]==[comps_m year])||[comps_now year]>[comps_m year]) {
        self.prevButton.alpha = 0;
    }
    
    self.monthShowing = date_m;
}
- (void)setDefaultStyle
{
    self.backgroundColor = PMColor4;
    [self setTitleColor:PMColor1];
    [self setTitleFont:PMFont2];
    
    [self setDayOfWeekFont:PMFont3];
    [self setDayOfWeekTextColor:UIColorFromRGB(0x999999)];
    [self setDateFont:[UIFont boldSystemFontOfSize:16.0f]];
    [self setDateTextColor:UIColorFromRGB(0x393B40)];
    [self setAvailableDateTextColor:PMColor1];
    [self setUnavailableDateTextColor:PMColor2];
    
    [self setDateBackgroundColor:UIColorFromRGB(0xF2F2F2)];
    [self setDateContainerColor:UIColorFromRGB(0xDAE1E6)];
    
    [self setSelectedDateTextColor:UIColorFromRGB(0xF2F2F2)];
    [self setSelectedDateBackgroundColor:UIColorFromRGB(0x88B6DB)];
    [self setCurrentDateTextColor:UIColorFromRGB(0xF2F2F2)];
    [self setCurrentDateBackgroundColor:[UIColor lightGrayColor]];
    
}


@end

