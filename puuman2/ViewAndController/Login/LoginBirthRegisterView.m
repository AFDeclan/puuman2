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
#import "TaskCell.h"
#import "UIImage+CroppedImage.h"
#import "MainTabBarController.h"

#define _NAME_MAX_LENGTH_ 30
@implementation LoginBirthRegisterView
@synthesize delegate = _delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
        [[UserInfo sharedUserInfo] babyInfo].delegate = self;
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
    [[[UserInfo sharedUserInfo] babyInfo] setDelegate:self];
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(0, 16, 704, 16)];
    [title setFont:PMFont2];
    [title setText:@"请输入宝宝的基本信息"];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setTextColor:PMColor3];
    [title setBackgroundColor:[UIColor clearColor]];
    [self addSubview:title];
    
    portraitView=[[AFImageView alloc] initWithFrame:CGRectMake(282, 64, 140, 140)];
  //  [portraitView setImage:[UIImage imageNamed:@"pic_born_login.png"]];
    ;
    portraitView.layer.cornerRadius = 70;
    portraitView.layer.masksToBounds = YES;
    portraitView.layer.shadowRadius =0.1;
    portraitView.contentMode = UIViewContentModeScaleAspectFill;
    [portraitView getImage:[[[UserInfo sharedUserInfo] babyInfo] PortraitUrl] defaultImage:@"pic_born_login.png"];
     portraitView.image =[UIImage croppedImage:portraitView.image WithHeight:224 andWidth:224];
     portraitView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[ UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPortrait)];
    [portraitView addGestureRecognizer:tap];
    [portraitView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:portraitView];
    
    
    name_textfield = [[CustomTextField alloc] initWithFrame:CGRectMake(224, 248,256, 48)];
    [name_textfield setPlaceholder:@"名字"];
    name_textfield.keyboardType = UIKeyboardTypeDefault;
    name_textfield.returnKeyType = UIReturnKeyNext;
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
    
    if ([[UserInfo sharedUserInfo] logined])
    {
        name_textfield.text = [[[UserInfo sharedUserInfo] babyInfo] Nickname];
        if ([[[UserInfo sharedUserInfo] babyInfo] WhetherBirth])
        {
            [self selectDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
            if ([[[UserInfo sharedUserInfo] babyInfo] Gender]) {
                babyType = kGenderBoy;
                [boy selected];
                [girl unSelected];
            }else{
                
                
                babyType = kGenderGirl;
                [girl selected];
                [boy unSelected];
            }
        }
        
        
    }else{
        babyType = kGenderNone;
    }
}
-(void)tapPortrait{
  
    NewTextPhotoSelectedViewController *chooseView = [[NewTextPhotoSelectedViewController alloc] initWithNibName:nil bundle:nil];
       [[MainTabBarController sharedMainViewController].view addSubview:chooseView.view];
        [chooseView setDelegate:self];
        [chooseView setIsMiddle:YES];
        [chooseView setStyle:ConfirmError];
        [chooseView show];


}
-(void)selectedPhoto:(UIImage *)img{

    
    [[UserInfo sharedUserInfo] uploadPortrait:img];
    
    
}

- (void)portraitUploadFinish:(BOOL)suc
{
    if (suc) {
        [[TaskCell sharedTaskCell] reloadPortrait];
        [portraitView getImage:[[[UserInfo sharedUserInfo] babyInfo] PortraitUrl] defaultImage:default_portrait_image];
         portraitView.image =[UIImage croppedImage:portraitView.image WithHeight:224 andWidth:224];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == name_textfield) {
        [name_textfield resignFirstResponder];
    }
    return YES;
}
@end
