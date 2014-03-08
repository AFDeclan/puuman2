//
//  LoginPregnancyRegisterView.m
//  puman
//
//  Created by 祁文龙 on 13-10-17.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "LoginBirthRegisterView.h"
#import "ColorsAndFonts.h"
#import "UserInfo.h"
#import "BabyData.h"
#import "MainTabBarController.h"

#define _NAME_MAX_LENGTH_ 30
@implementation LoginBirthRegisterView
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
    return birthday;
}

- (BabyType)babyType;
{
    return babyType;
}

- (void) initialize
{
    birthday = nil;
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(0, 16, 704, 16)];
    [title setFont:PMFont2];
    [title setText:@"请输入宝宝的基本信息"];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setTextColor:PMColor3];
    [self addSubview:title];
    
    portrait=[[UIImageView alloc] initWithFrame:CGRectMake(282, 64, 140, 140) ];
    [portrait setImage:[UIImage imageNamed:@"pic_born_login.png"]];
    [portrait setBackgroundColor:[UIColor clearColor]];

    [self addSubview:portrait];
    
    
    name_textfield = [[CustomTextField alloc] initWithFrame:CGRectMake(224, 248,256, 48)];
    [name_textfield setPlaceholder:@"名字"];
    name_textfield.delegate = self;
    [self addSubview:name_textfield];
     boy = [[AFTextImgButton alloc] initWithFrame:CGRectMake(224, 312, 120, 48)];
    [boy setTitle:@"男宝宝" andImg:[UIImage imageNamed:@"icon_male_baby.png"] andButtonType:kButtonTypeTwo];
    [boy setBackgroundColor:PMColor5];
    [boy addTarget:self action:@selector(gender:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:boy];
    
    girl = [[AFTextImgButton alloc] initWithFrame:CGRectMake(360, 312, 120, 48)];
    [girl setTitle:@"女宝宝" andImg:[UIImage imageNamed:@"icon_female_baby.png"] andButtonType:kButtonTypeTwo];
    [girl addTarget:self action:@selector(gender:) forControlEvents:UIControlEventTouchUpInside];
    [girl setBackgroundColor:PMColor5];
    [self addSubview:girl];
    
    age = [[CustomTextField alloc] initWithFrame:CGRectMake(224, 376,256, 48)];
    [age setPlaceholder:@"生日"];
    [age setEnabled:NO];
    [self addSubview:age];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(254, 376, 256, 48)];
    [button addTarget:self action:@selector(selectedAge) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    babyType = kGenderNone;
    
    if ([[UserInfo sharedUserInfo] logined])
    {
        name_textfield.text = [[BabyData sharedBabyData] babyName];
        if ([[BabyData sharedBabyData] babyHasBorned])
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
    [calendarView setFrame:CGRectMake(362, 169, 300, 490)];
}
-(void)setVerticalFrame
{
    CGRect frame = _calendar.frame;
    frame.origin.y = 20;
    [_calendar setFrame:frame];
    [imgIcon setAlpha:1];
    [calendarView setFrame:CGRectMake(234, 583, 300, 490)];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    BOOL isAllowEdit = YES;
    if([string length]>range.length&&[textField.text length]+[string length]-range.length>_NAME_MAX_LENGTH_)
    {
      
        isAllowEdit = NO;
    }
   
    if (range.length == 1 && range.location == 0) {
        [self isFinishedwithNameHas:NO];
    }else{
        [self isFinishedwithNameHas:YES];
    }
    
    return isAllowEdit;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}
- (void)resigntextField
{
    
    [calendarView setAlpha:0];
    [name_textfield resignFirstResponder];
}

- (void)gender:(UIButton *)sender
{
    
    if (sender==girl) {
        babyType = kGenderGirl;
        [girl selected];
        [boy unSelected];
    }else{
        
        babyType = kGenderBoy;
        [boy selected];
        [girl unSelected];
    }
    [self isFinished];
    [calendarView setAlpha:0];
    [name_textfield resignFirstResponder];
    
}
- (void)selectedAge
{
    [MobClick event:umeng_event_click label:@"AgeCanlendar_LoginBirthRegisterView"];
    [name_textfield resignFirstResponder];
    [self initWithCanlendar];
}
- (void)initWithCanlendar
{
    if (!calendarView) {
        [calendarView removeFromSuperview];
        calendarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 490)];
        _calendar = [[BirthCalendar alloc]initWithFrame:CGRectMake(0, 0, 300, 325)];
        _calendar.frame = CGRectMake(0, 20, 300, 470);
        _calendar.delegate = self;
        [calendarView setAlpha:0];
        [calendarView addSubview:_calendar];
       imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(138, 0, 24, 23)];
        [imgIcon setImage:[UIImage imageNamed: @"tri_login_diary.png"]];
        [calendarView addSubview:imgIcon];
    }
    if (calendarView.alpha == 0) {
        [UIView animateWithDuration:0.5
                         animations:^{
                             [calendarView setAlpha:1];
                         }];
        [[MainTabBarController sharedMainViewController].view addSubview:calendarView];
    }
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [calendarView setAlpha:0];
    return YES;
}

- (void)calendar:(BirthCalendar *)calendar selectedButton:(DateButton *)sender
{
    if ([calendar dateIsAvailable:sender.date])
    {
        sender.backgroundColor = calendar.selectedDateBackgroundColor;
        calendar.selectedDate = sender.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"YYYY-M-d";
        age.text = [dateFormatter stringFromDate:sender.date];
        birthday = sender.date;
        [calendarView setAlpha:0];
    }else
    {
        age.text = @"请输入正确日期";
        calendar.selectedDate = nil;
        birthday = nil;
    }
    [self isFinished];
}
- (void)selectDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-M-d";
    age.text = [dateFormatter stringFromDate:date];
    birthday = date;
}
- (void)isFinished
{
    if (birthday != nil &&
        ![[name_textfield.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""] && babyType != kGenderNone) {
        [_delegate isFinished];
    }else{
      [_delegate unFinished];
    }
  
}

- (void)isFinishedwithNameHas:(BOOL)hasName
{
    if (hasName&& babyType != kGenderNone&&birthday != nil) {
        [_delegate isFinished];
    }else{
        [_delegate unFinished];
    }
}

@end
