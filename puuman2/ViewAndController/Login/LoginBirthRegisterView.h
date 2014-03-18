//
//  LoginPregnancyRegisterView.h
//  puman
//
//  Created by 祁文龙 on 13-10-17.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "BirthCalendar.h"
#import "AFTextImgButton.h"

typedef enum{

    kGenderBoy,
    kGenderGirl,
    kGenderNone
} BabyType;
@protocol LoginBirthViewDelegate;
@interface LoginBirthRegisterView : UIView<UITextFieldDelegate,BirthCalendarDelegate>
{
    CustomTextField *name_textfield;
    CustomTextField *age;
    AFTextImgButton *boy;
    AFTextImgButton *girl;
    UIView *calendarView;
    NSDate *birthday;
    UIImageView *portrait;
    BirthCalendar *_calendar;
    UIImageView *imgIcon;
    BabyType babyType;
}
@property (assign,nonatomic) id <LoginBirthViewDelegate> delegate;
@property (nonatomic, assign) enum userIdentity identity;
- (void)resigntextField;
-(void)setHorizontalFrame;
-(void)setVerticalFrame;
- (NSString *)babyName;
- (NSDate *)birthDate;
- (BabyType)babyType;
@end
@protocol LoginBirthViewDelegate <NSObject>
@optional
- (void)isFinished;
- (void)unFinished;
@end
