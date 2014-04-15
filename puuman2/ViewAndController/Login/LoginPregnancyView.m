//
//  LoginBirthRegisterView.m
//  puman
//
//  Created by 祁文龙 on 13-10-17.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "LoginPregnancyView.h"
#import "ColorsAndFonts.h"
#import "UserInfo.h"
#import "BabyData.h"
#import "MainTabBarController.h"

#define _NAME_MAX_LENGTH_ 30

@implementation LoginPregnancyView
@synthesize delegate = _delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         [self initialize];
    }
    return self;
}

- (NSString *)babyName
{
    return name_textfield.text;
}

- (NSDate *)birthDate
{
    return _date;
}

- (void) initialize
{
    _date = nil;
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(0, 16, 704, 16)];
    [title setFont:PMFont2];
    [title setText:@"请输入宝宝的基本信息"];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setTextColor:PMColor3];
    [title setBackgroundColor:[UIColor clearColor]];
    [self addSubview:title];
    
    UIImageView *portrait=[[UIImageView alloc] initWithFrame:CGRectMake(282, 64, 140, 140) ];
    [portrait setImage:[UIImage imageNamed:@"pic_pre_login.png"]];
    [portrait setBackgroundColor:[UIColor clearColor]];
    [self addSubview:portrait];
    
    name_textfield = [[CustomTextField alloc] initWithFrame:CGRectMake(224, 248,256, 48)];
    [name_textfield setPlaceholder:@"宝宝乳名（可空缺）"];
    name_textfield.delegate = self;
    name_textfield.keyboardType = UIKeyboardTypeDefault;
    name_textfield.returnKeyType = UIReturnKeyNext;
    [self addSubview:name_textfield];
    
    birthday = [[CustomTextField alloc] initWithFrame:CGRectMake(224, 312,256, 48)];
    [birthday setPlaceholder:@"预产期"];
    [birthday setEnabled:NO];
    [self addSubview:birthday];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(224, 312, 256, 48)];
    [button addTarget:self action:@selector(selectedBirthDay) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];

    
    if ([[UserInfo sharedUserInfo] logined])
    {
        name_textfield.text = [[BabyData sharedBabyData] babyName];
        if (![[BabyData sharedBabyData] babyHasBorned])
        {
            [self selectDate:[[BabyData sharedBabyData] babyBirth]];
        }
    }
}
-(void)setHorizontalFrame
{
    CGRect frame = _calendar.frame;
    frame.origin.y = 0;
    [_calendar setFrame:frame];
    [imgIcon setAlpha:0];
  
    [calendarView setFrame:CGRectMake(362, 106, 300, 490)];
}
-(void)setVerticalFrame
{
    CGRect frame = _calendar.frame;
    frame.origin.y = 20;
   [_calendar setFrame:frame];
    [imgIcon setAlpha:1];
    [calendarView setFrame:CGRectMake(234, 520, 300, 490)];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  
        BOOL isAllowEdit = YES;
        if([string length]>range.length&&[textField.text length]+[string length]-range.length>_NAME_MAX_LENGTH_)
        {
            
            isAllowEdit = NO;
        }
        
        if (range.length == 1 && range.location == 0) {
            if ([[UserInfo sharedUserInfo] logined])
            {
                [self isFinished];
            }
        }else{
            if ([[UserInfo sharedUserInfo] logined])
            {
                [self isFinished];
            }
        }
        
    return isAllowEdit;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [calendarView setAlpha:0];
    return YES;
}
- (void)resigntextField
{
    [calendarView setAlpha:0];
    [name_textfield resignFirstResponder];
}

- (void)initWithCanlendar
{
    if (!calendarView) {
        [calendarView removeFromSuperview];
         calendarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 490)];
         _calendar = [[PregnancyCalendar alloc] initWithFrame:CGRectMake(0, 0, 300, 325)];
        _calendar.frame = CGRectMake(0, 20, 300, 470);
        _calendar.delegate = self;
        
        [calendarView addSubview:_calendar];
         imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(138, 0, 24, 23)];
        [imgIcon setImage:[UIImage imageNamed: @"tri_login_diary.png"]];
        [calendarView addSubview:imgIcon];
    }
    [calendarView setAlpha:1];
    [[MainTabBarController sharedMainViewController].view addSubview:calendarView];
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
    
}
- (void)selectedBirthDay
{
    
     [MobClick event:umeng_event_click label:@"BirthDayCanlendar_LoginPregnancyView"];
    [name_textfield resignFirstResponder];
    [self initWithCanlendar];
}
- (void)calendar:(PregnancyCalendar *)calendar selectedButton:(DateButton *)sender
{
    if ([calendar dateIsAvailable:sender.date]||[calendar dateIsToday:sender.date]) {
        sender.backgroundColor = calendar.selectedDateBackgroundColor;
        calendar.selectedDate = sender.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"YYYY-M-d";
        birthday.text = [dateFormatter stringFromDate:sender.date];
        _date = sender.date;
        [calendarView setAlpha:0];
    }else
    {
        birthday.text = @"请输入正确日期";
        calendar.selectedDate = nil;
        _date = nil;
    }
    [self isFinished];
}
- (void)selectDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-M-d";
    birthday.text = [dateFormatter stringFromDate:date];
    _date = date;
}
- (void)isFinished
{
    if (_date != nil) {
        [_delegate isFinished];
    }else{
      [_delegate unFinished];
    }
  
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == name_textfield) {
        [name_textfield resignFirstResponder];
    }
    return YES;
}
@end
