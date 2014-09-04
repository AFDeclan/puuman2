//
//  VaccineInfoTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "VaccineInfoTableViewCell.h"
#import "ColorsAndFonts.h"
#import "BabyData.h"
#import "NSDate+Compute.h"
#import "DateFormatter.h"
#import "UserInfo.h"
#import "MainTabBarController.h"

@implementation VaccineInfoTableViewCell
@synthesize delegate = _delegate;
@synthesize vacIndex = _vacIndex;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initialization];
        if ([[MainTabBarController sharedMainViewController] isVertical]) {
            [self setVerticalFrame];
        }else {
            [self setHorizontalFrame];
        }
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(setHorizontalFrame) name:NOTIFICATION_Horizontal object:nil];
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(setVerticalFrame) name:NOTIFICATION_Vertical object:nil];

        self.contentView.layer.masksToBounds = YES;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)initialization
{
    canUnFold = YES;
    icon_status = [[UIImageView alloc] initWithFrame:CGRectMake(32, 32, 32, 32)];
    [self.contentView addSubview:icon_status];
    
    time_line = [[UIImageView alloc] initWithFrame:CGRectMake(48, 0, 1, 96)];
    [time_line setImage:[UIImage imageNamed:@"dotline_vac_baby.png"]];
    [self.contentView addSubview:time_line];
    
    
    label_status = [[UILabel alloc] initWithFrame:CGRectMake(96, 20, 336, 16)];
    [label_status setFont:PMFont2];
    [label_status setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:label_status];
    
    info_date = [[UILabel alloc] initWithFrame:CGRectMake(96, 40, 336, 10)];
    [info_date setFont:PMFont3];
    [info_date setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:info_date];
    
    info_name = [[UILabel alloc] initWithFrame:CGRectMake(120, 56, 224, 16)];
    [info_name setFont:PMFont2];
    [info_name setBackgroundColor:[UIColor clearColor]];
    [info_name setTextAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:info_name];
    
    info_age = [[UILabel alloc] initWithFrame:CGRectMake(138, 13, 48, 24)];
    [info_age setFont:PMFont1];
    [info_age setBackgroundColor:[UIColor clearColor]];
    [info_age setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:info_age];
    
    partLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 94, 432, 2)];
    [self.contentView addSubview:partLine];
    
    selectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 432, 96)];
    [selectedBtn addTarget:self action:@selector(selectedBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView  addSubview:selectedBtn];
    
    [self initDateView];

}

- (void)initDateView
{
    
    dateView = [[UIView alloc] initWithFrame:CGRectMake(0, 96, 432, 192)];
    [dateView setBackgroundColor:PMColor5];
    [self.contentView addSubview:dateView];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 432, 1)];
    [lineView setBackgroundColor:PMColor4];
    [dateView addSubview:lineView];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(192 , 12, 55, 20)];
    timeLabel.text = @"接种日期";
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.font = PMFont3;
    [dateView addSubview:timeLabel];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 45, 432,156)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setBackgroundColor:PMColor5];
    [dateView addSubview:datePicker];
    datePicker.maximumDate = [NSDate date];
    datePicker.minimumDate = [[UserInfo sharedUserInfo] createTime];

    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake(20, 12, 30, 20)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:PMColor6 forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:PMFont3];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [dateView addSubview:cancelBtn];
    
    saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setFrame:CGRectMake(382, 12, 30, 20)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn.titleLabel setFont:PMFont3];
    [saveBtn setTitleColor:PMColor6 forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [dateView addSubview:saveBtn];
    
}

- (void)saveBtnClick
{
     [[BabyData sharedBabyData] updateVaccineAtIndex:_vacIndex withDoneTime:datePicker.date];
     [_delegate saveBtnClick:_vacIndex];
}

- (void)selectedBtnClick
{
    [_delegate selectedBtnClick:_vacIndex withCanUnFold:canUnFold];
    [datePicker setDate:[NSDate date] animated:YES];
}

- (void)cancelBtnClick
{
    [_delegate cancelBtnClick:_vacIndex];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setVacIndex:(NSInteger)vacIndex
{
    _vacIndex = vacIndex;
    NSDictionary *vacInfo = [[BabyData sharedBabyData] vaccineAtIndex:_vacIndex];
    NSString *name = [vacInfo valueForKey:kVaccine_Name];
    if(NSNotFound != [name rangeOfString:@"（"].location)
    {
        int location = [name rangeOfString:@"（"].location;
        name = [name substringToIndex:location];
    }
    [info_name setText:name];
     NSDate *doneDate = [vacInfo valueForKey:kVaccine_DoneTime];
    if (doneDate) {
        NSArray *age = [doneDate ageFromDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
        if ([age count] == 3)
        {
            int year  = [[age objectAtIndex:0] integerValue];
            int month  = [[age objectAtIndex:1] integerValue];
            month = month + 12*year;
            [info_age setText:[NSString stringWithFormat:@"%d",month]];
            [info_date setText:[DateFormatter stringFromDate:doneDate]];
        }
        [self setDoneStyle];

    }else{
        NSArray *age = [[NSDate date] ageFromDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
        NSInteger month = 0;
        if ([age count] == 3)
        {
            month = [[age objectAtIndex:0] integerValue] * 12 + [[age objectAtIndex:1] integerValue];
        }
        NSArray *suitMonths = [[vacInfo valueForKey:kVaccine_SuitMonth] componentsSeparatedByString:@"~"];
        NSInteger startMonth = 0, endMonth = 0;
        if ([suitMonths count] == 2)
        {
            startMonth = [[suitMonths objectAtIndex:0] integerValue];
            endMonth = [[suitMonths objectAtIndex:1] integerValue];
        }
        NSInteger suitMonth = [[vacInfo valueForKey:kVaccine_SuitMonth] integerValue];
        
        [info_age setText:[NSString stringWithFormat:@"%d",suitMonth]];
        [info_date setText:@""];
        if (month >= startMonth && month < endMonth) {
            [self setNowStyle];
        } else if(month<startMonth) {
            [self setFutureStyle];
        } else {
            [self setDonePreStyle];
        }
    }
}


- (void)setDonePreStyle
{
    canUnFold = YES;
    [icon_status setImage:[UIImage imageNamed:@"icon_vac2_baby.png"]];
    [label_status setText:@"已经在        月龄接种（待确认）"];
    [label_status setTextColor:PMColor2];
    [info_age setTextColor:PMColor2];
    [info_date setTextColor:PMColor2];
    [info_name setTextColor:PMColor2];
    [self.contentView setBackgroundColor:PMColor4];
     [partLine setImage:[UIImage imageNamed:@"line4_baby.png"]];
}

- (void)setDoneStyle
{
    canUnFold = NO;
    [icon_status setImage:[UIImage imageNamed:@"icon_vac1_baby.png"]];
    [label_status setText:@"已经在        月龄接种"];
    [label_status setTextColor:PMColor2];
    [info_age setTextColor:PMColor2];
    [info_date setTextColor:PMColor2];
    [info_name setTextColor:PMColor2];
    [self.contentView setBackgroundColor:PMColor4];
     [partLine setImage:[UIImage imageNamed:@"line4_baby.png"]];
}

- (void)setNowStyle
{
    canUnFold = YES;
    [icon_status setImage:[UIImage imageNamed:@"icon_vac3_baby.png"]];
    [label_status setText:@"建议在        月龄接种（推荐）"];
    [label_status setTextColor:[UIColor whiteColor]];
    [info_age setTextColor:[UIColor whiteColor]];
    [info_date setTextColor:[UIColor whiteColor]];
    [info_name setTextColor:[UIColor whiteColor]];
    [self.contentView setBackgroundColor:PMColor6];
     [partLine setImage:[UIImage imageNamed:@"line2_baby.png"]];
}
- (void)setFutureStyle
{
    canUnFold = NO;
    [icon_status setImage:[UIImage imageNamed:@"icon_vac4_baby.png"]];
    [label_status setText:@"建议在        月龄接种"];
    [label_status setTextColor:PMColor7];
    [info_age setTextColor:PMColor7];
    [info_date setTextColor:PMColor7];
    [info_name setTextColor:PMColor7];
    [self.contentView setBackgroundColor:PMColor6];
    [partLine setImage:[UIImage imageNamed:@"line2_baby.png"]];
}


-(void)setVerticalFrame
{
    SetViewLeftUp(saveBtn, 332, 12);
    SetViewLeftUp(datePicker, -25, 45);
}

-(void)setHorizontalFrame
{
    SetViewLeftUp(saveBtn, 382, 12);
    SetViewLeftUp(datePicker, 0, 45);

}

-(void)dealloc
{
    [MyNotiCenter removeObserver:self];
}
@end
