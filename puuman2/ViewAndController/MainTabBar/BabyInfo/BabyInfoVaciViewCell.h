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
#import "BabyInfoIconViewDelegate.h"
#import "VaccineInfoTableViewCell.h"
#import "VaciPopoverContentViewController.h"


@interface BabyInfoVaciViewCell : UITableViewCell <UITableViewDataSource,UITableViewDelegate,BabyInfoIconViewDelegate,VaccineCellDelegate,UIPopoverControllerDelegate,VaccineDateDelegate>
{
    UITableView *dataTable;
    NSInteger selectVaccine;
    NSInteger chooseVaccine;
    CustomTextField *statusText;
    UITextView *detail;
    AnimateShowLabel *nameLabel;
    AFTextImgButton *backBtn;
    NSInteger suitMonth;
    UIView *emptyView;
    UIView *leftView;
    UIView *rightView;
    UIButton *leftBtn;
    UIView *lineView;
    UIButton *backUpBtn;
    UIButton *modifyBtn;
    BOOL dateViewShowed;
    
}
@property (strong,nonatomic) VaciPopoverContentViewController *contentViewContorller;
@property (strong,nonatomic) UIPopoverController *popoverController;

@property (nonatomic,assign) id<BabyInfoIconViewDelegate>delegate;
+(BabyInfoVaciViewCell *)shareVaccineCell;
- (void)refresh;

@end
