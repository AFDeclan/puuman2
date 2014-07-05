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
#import "ColorButton.h"
#import "AddInfoCalendar.h"
#import "BabyInfoIconViewDelegate.h"

@interface BabyInfoVaciViewCell : UITableViewCell <UITableViewDataSource,UITableViewDelegate,AddInfoCalendarDelegate,BabyInfoIconViewDelegate>
{
    UITableView *dataTable;
    NSInteger selectVaccine;
    
    CustomTextField *statusText;
    UIButton *selectedDateBtn;
    UITextView *detail;
    AnimateShowLabel *nameLabel;
    ColorButton *alreadyBtn;
    ColorButton *notBtn;
    AFTextImgButton *backBtn;
    UIView *maskView;
    BOOL  right;
    NSDate *date;
    AddInfoCalendar *_calendar;
    NSInteger suitMonth;
    UIView *emptyView;
    UIView *leftView;
    UIView *rightView;
    
}

@property (nonatomic,assign) id<BabyInfoIconViewDelegate>delegate;
- (void)refresh;

@end
