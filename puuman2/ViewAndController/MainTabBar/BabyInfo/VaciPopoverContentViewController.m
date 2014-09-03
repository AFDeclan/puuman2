//
//  VaciPopoverContentViewController.m
//  puuman2
//
//  Created by AF_Bigwaves on 14-9-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "VaciPopoverContentViewController.h"
#import "UniverseConstant.h"
#import "BabyData.h"

@interface VaciPopoverContentViewController ()

@end

@implementation VaciPopoverContentViewController
@synthesize vacIndex = _vacIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.contentSizeForViewInPopover = CGSizeMake(285, 185);
        [self initialization];
    }
    return self;
}


- (void) initialization
{
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake(20, 12, 30, 20)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:PMColor6 forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:PMFont3];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setFrame:CGRectMake(235, 12, 30, 20)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn.titleLabel setFont:PMFont3];
    [saveBtn setTitleColor:PMColor6 forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 285, 1)];
    [lineView setBackgroundColor:PMColor4];
    [self.view addSubview:lineView];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 12, 55, 20)];
    timeLabel.text = @"修改时间";
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.font = PMFont3;
    [self.view addSubview:timeLabel];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(25, 45, 240, 100)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [self.view addSubview:datePicker];
    
}

- (void)saveBtnClick
{
     [[BabyData sharedBabyData] updateVaccineAtIndex:_vacIndex withDoneTime:[datePicker date]];
    [_vaccineDelegate saveVacBtnClick:_vacIndex];

}

- (void)cancelBtnClick
{
    [_vaccineDelegate cancelVacBtnClick];

}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
