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

@implementation VaccineInfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (void)initialization
{
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
    
    info_name = [[UILabel alloc] initWithFrame:CGRectMake(176, 56, 224, 16)];
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
    [self addSubview:partLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setVaccineIndex:(NSInteger)index
{
    NSDictionary *vacInfo = [[BabyData sharedBabyData] vaccineAtIndex:index];
    NSString *name = [vacInfo valueForKey:kVaccine_Name];
    if(NSNotFound != [name rangeOfString:@"（"].location)
    {
        int location = [name rangeOfString:@"（"].location;
        name = [name substringToIndex:location];
    }
    [info_name setText:name];
     NSDate *doneDate = [vacInfo valueForKey:kVaccine_DoneTime];
    if (doneDate) {
        NSArray *age = [doneDate ageFromDate:[BabyData sharedBabyData].babyBirth];
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
        NSArray *age = [[NSDate date] ageFromDate:[BabyData sharedBabyData].babyBirth];
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
    [icon_status setImage:[UIImage imageNamed:@"icon_vac4_baby.png"]];
    [label_status setText:@"建议在        月龄接种"];
    [label_status setTextColor:PMColor7];
    [info_age setTextColor:PMColor7];
    [info_date setTextColor:PMColor7];
    [info_name setTextColor:PMColor7];
    [self.contentView setBackgroundColor:PMColor6];
    [partLine setImage:[UIImage imageNamed:@"line2_baby.png"]];
}


@end
