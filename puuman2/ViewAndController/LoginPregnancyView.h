//
//  LoginBirthRegisterView.h
//  puman
//
//  Created by 祁文龙 on 13-10-17.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "PregnancyCalendar.h"

@protocol LoginPregnancyViewDelegate;
@interface LoginPregnancyView : UIView<UITextFieldDelegate,PregnancyCalendarDelegate>
{
    CustomTextField *name_textfield;
    CustomTextField *birthday;
    UIView *calendarView;
    NSDate *_date;
    PregnancyCalendar *_calendar;
    UIImageView *imgIcon;
}
@property (assign,nonatomic) id <LoginPregnancyViewDelegate> delegate;
@property (nonatomic, assign) enum userIdentity identity;

- (void)resigntextField;
- (NSString *)babyName;
- (NSDate *)birthDate;
-(void)setHorizontalFrame;
-(void)setVerticalFrame;
@end
@protocol LoginPregnancyViewDelegate <NSObject>
@optional
- (void)isFinished;
- (void)unFinished;
@end