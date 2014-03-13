//
//  AddInfoCalendar.m
//  puman
//
//  Created by 祁文龙 on 13-10-24.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "AddInfoCalendar.h"
#import "BabyData.h"

@implementation AddInfoCalendar
@synthesize delegate = _delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.nextButton.alpha = 0;
        [self setDefaultStyle];
        [self initSelectViewWithFromDate:[[BabyData sharedBabyData] babyBirth] toDate:[NSDate date]];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];

}
- (void)dateButtonPressed:(DateButton *)sender
{
    [_delegate calendar:self selectedButton:sender];
    [super dateButtonPressed:sender];
    
}
- (BOOL)dateIsAvailable:(NSDate *)date
{
    NSDate *birthday = [[BabyData sharedBabyData] babyBirth];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp_birthday = [calendar components:unit fromDate:birthday];
    NSDateComponents *comp_now = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *comp_date = [calendar components:unit fromDate:date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if ([comp_now month]==[comp_birthday month]&&[comp_now year]==[comp_birthday year]) {
        [self.prevButton setAlpha:0];
    }
    
    dateFormatter.dateFormat = @"D";
    int day_now = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    int day_birthday = [[dateFormatter stringFromDate:birthday] intValue];
    int day_date = [[dateFormatter stringFromDate:date] intValue];
    if (([comp_date year] > [comp_birthday year] && [comp_date year] <  [comp_now year])
        ||([comp_date year] == [comp_birthday year] && day_date >= day_birthday && [comp_date year] < [comp_now year])
        ||([comp_date year] == [comp_now year] && day_date <= day_now && [comp_date year] > [comp_birthday year])
        ||([comp_date year] == [comp_birthday year] && [comp_date year] == [comp_now year] && day_now >= day_date && day_date >= day_birthday)) {
        return YES;
        
    }else return NO;
    

}
- (void)moveCalendarToPreviousMonth {
    self.nextButton.alpha = 1;
    NSDate *date_m = [[self firstDayOfMonthContainingDate:self.monthShowing] dateByAddingTimeInterval:-100000];
    NSDate *birthday = [[BabyData sharedBabyData] babyBirth];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comps_m = [calendar components:unit fromDate:date_m];
    NSDateComponents *comps_birthday = [calendar components:unit fromDate:birthday];
    if (([comps_birthday month]>=[comps_m month]&&[comps_birthday year]==[comps_m year])||[comps_birthday year]>[comps_m year]) {
        self.prevButton.alpha = 0;
    }
    
    self.monthShowing = date_m;
}
- (void)moveCalendarToNextMonth {
    self.prevButton.alpha = 1;
    NSDateComponents* comp_m = [[NSDateComponents alloc]init];
    [comp_m setMonth:1];
    NSDate *date_m = [self.calendar dateByAddingComponents:comp_m toDate:self.monthShowing options:0];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comps_m = [calendar components:unit fromDate:date_m];
    NSDateComponents *comps_now = [calendar components:unit fromDate:[NSDate date]];
    if (([comps_now month]<=[comps_m month]&&[comps_now year]==[comps_m year])||[comps_now year]<[comps_m year]) {
        self.nextButton.alpha = 0;
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
