//
//  BabyVaccineView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoContentView.h"
#import "CustomTextField.h"
#import "AnimateShowLabel.h"
#import "ColorButton.h"
#import "AFTextImgButton.h"
#import "AddInfoCalendar.h"

@interface BabyVaccineView : BabyInfoContentView<UITableViewDataSource,UITableViewDelegate,AddInfoCalendarDelegate>
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
}
- (void)refresh;
@end
