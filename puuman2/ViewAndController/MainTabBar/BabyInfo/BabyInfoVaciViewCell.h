//
//  BabyInfoVaciViewCell.h
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "AnimateShowLabel.h"
#import "AFColorButton.h"
#import "AddInfoCalendar.h"
#import "BabyInfoIconViewDelegate.h"
#import "VaccineInfoTableViewCell.h"

@interface BabyInfoVaciViewCell : UITableViewCell <UITableViewDataSource,UITableViewDelegate,AddInfoCalendarDelegate,BabyInfoIconViewDelegate,VaccineCellDelegate>
{
    UITableView *dataTable;
    NSInteger selectVaccine;
    
    CustomTextField *statusText;
    UIButton *selectedDateBtn;
    UITextView *detail;
    AnimateShowLabel *nameLabel;
    AFColorButton *alreadyBtn;
    AFColorButton *notBtn;
    AFTextImgButton *backBtn;
    UIView *maskView;
    BOOL  right;
    NSDate *date;
    AddInfoCalendar *_calendar;
    NSInteger suitMonth;
    UIView *emptyView;
    UIView *leftView;
    UIView *rightView;
    UIButton *leftBtn;
    UIView *lineView;
    UIButton *backUpBtn;
    
}

@property (nonatomic,assign) id<BabyInfoIconViewDelegate>delegate;
- (void)refresh;

@end
