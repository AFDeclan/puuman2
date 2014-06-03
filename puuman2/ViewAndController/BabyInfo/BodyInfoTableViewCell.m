//
//  BodyInfoTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-13.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BodyInfoTableViewCell.h"
#import "ColorsAndFonts.h"
#import "BabyData.h"
#import "NSDate+Compute.h"
#import "DateFormatter.h"

@implementation BodyInfoTableViewCell

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
    icon = [[UIImageView alloc] initWithFrame:CGRectMake(16, 24, 16, 16)];
    [icon setImage:[UIImage imageNamed:@"icon_time_baby.png"]];
    [self.contentView addSubview:icon];
    
    info_age = [[UILabel alloc] initWithFrame:CGRectMake(32, 24, 184, 16)];
    [info_age setFont:PMFont2];
    [info_age setTextColor:PMColor7];
    [info_age setText:@"12岁1个月12天"];
    [info_age setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:info_age];
    
    info_height = [[UILabel alloc] initWithFrame:CGRectMake(107, 49, 64, 24)];
    [info_height setFont:PMFont1];
    [info_height setText:@"999.9"];
    [info_height setTextAlignment:NSTextAlignmentCenter];
    [info_height setTextColor:[UIColor whiteColor]];
    [info_height setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:info_height];
    
    info_weight = [[UILabel alloc] initWithFrame:CGRectMake(107, 81, 64, 24)];
    [info_weight setFont:PMFont1];
    [info_weight setText:@"99"];
    [info_weight setTextColor:[UIColor whiteColor]];
    [info_weight setTextAlignment:NSTextAlignmentCenter];
    [info_weight setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:info_weight];
    label_height = [[UILabel alloc] initWithFrame:CGRectMake(72, 56, 138, 16)];
    [label_height setFont:PMFont2];
    [label_height setTextColor:PMColor7];
    [label_height setText:@"身高               cm"];
    [label_height setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:label_height];
    label_weight = [[UILabel alloc] initWithFrame:CGRectMake(72, 88, 138, 16)];
    [label_weight setFont:PMFont2];
    [label_weight setTextColor:PMColor7];
    [label_weight setText:@"体重               kg"];
    [label_weight setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:label_weight];
 
    
    info_date = [[UILabel alloc] initWithFrame:CGRectMake(16, 112, 200, 12)];
    [info_date setFont:PMFont3];
    [info_date setTextColor:PMColor7];
    [info_date setText:@"2013.12.12"];
    [info_date setBackgroundColor:[UIColor clearColor]];
    [info_date setAlpha:0.5];
    [self.contentView addSubview:info_date];
    
    UIImageView *partLine  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 134, 216, 2)];
    [partLine setImage:[UIImage imageNamed:@"line1_baby.png"]];
    [partLine setAlpha:0.5];
    [self.contentView addSubview:partLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfoIndex:(NSInteger)index
{
    NSDictionary *record = [[BabyData sharedBabyData] recordAtIndex:[[BabyData sharedBabyData] recordCount]-index-1];
    float  record_weight =[[record valueForKey:kBabyData_Weight] floatValue];
    float record_height =[[record valueForKey:kBabyData_Height] floatValue];
    if (record_height == 0) {
        [info_height setAlpha:0];
        [label_height setAlpha:0];
    }else
    {
        [info_height setAlpha:1];
        [label_height setAlpha:1];
        info_height.text = [NSString stringWithFormat:@"%0.1f",record_height];
    }
    if (record_weight == 0) {
        [info_weight setAlpha:0];
        [label_weight setAlpha:0];
       
    }else
    {
        [info_weight setAlpha:1];
        [label_weight setAlpha:1];
        info_weight.text = [NSString stringWithFormat:@"%0.1f",record_weight];
    }
    info_date.text = [DateFormatter stringFromDate:[record valueForKey:kBabyData_Date]];
    NSArray *age = [[record valueForKey:kBabyData_Date] ageFromDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday];
    if ([age count] == 3)
    {
        NSString *str_age = @"";
        int yearNum = [[age objectAtIndex:0] intValue];
        int monthNum = [[age objectAtIndex:1] intValue];
        int dayNum = [[age objectAtIndex:1] intValue];
        if (yearNum !=0 ) {
          str_age = [str_age stringByAppendingFormat:@"%d年",yearNum];
        }
        if (monthNum !=0 ) {
            str_age = [str_age stringByAppendingFormat:@"%d个月",monthNum];
        }
        if (dayNum !=0 ) {
            str_age = [str_age stringByAppendingFormat:@"%d天",dayNum];
        }
        info_age.text = str_age;
    }
 
}

@end
