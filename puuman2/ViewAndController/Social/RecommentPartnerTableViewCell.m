//
//  RecommentPartnerTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "RecommentPartnerTableViewCell.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"
#import "BabyData.h"
#import "NSDate+Compute.h"

@implementation RecommentPartnerTableViewCell

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
    icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [self addSubview:icon];
    
    label_first = [[UILabel alloc] initWithFrame:CGRectMake(66, 24, 366, 16)];
    [label_first setBackgroundColor:[UIColor clearColor]];
    [label_first setFont:PMFont2];
    [label_first setTextColor:PMColor2];
    [label_first setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:label_first];
    
    label_second = [[UILabel alloc] initWithFrame:CGRectMake(66, 0, 366, 16)];
    [label_second setBackgroundColor:[UIColor clearColor]];
    [label_second setFont:PMFont2];
    [label_second setTextColor:PMColor2];
    [label_second setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:label_second];
    label_compare = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 144, 16)];
    [label_compare setBackgroundColor:[UIColor clearColor]];
    [label_compare setFont:PMFont2];
    [label_compare setTextColor:PMColor1];
    [label_compare setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:label_compare];
    
    line = [[UIImageView alloc] init];
    [line setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@""]]];
    
}


- (void)buildWithData:(Member *)data andUserData:(Member *)userData andDataType:(PartnerDataInfoType )type;
{
    

    switch (type) {
        case kPartnerBirthday:
        {
            [label_first setAlpha:1];
            [icon setImage:[UIImage imageNamed:@"icon_time2_topic.png"]];
            SetViewLeftUp(icon, 32, 36);
            SetViewLeftUp(label_second, 66, 40);
            SetViewLeftUp(label_compare, 432, 40);
            if ([[data babyInfo] WhetherBirth]) {
                label_first.text = [[NSDate date] ageStrFromDate:[[data babyInfo] Birthday]];
                label_second.text = [[[data babyInfo] Birthday] constellation];
                if ([[userData babyInfo] WhetherBirth]) {
                    label_compare.text = [[[userData babyInfo] Birthday] compareFromDate:[[data babyInfo] Birthday]];
                }
            }else{
                label_first.text = @"";
                label_second.text = @"";
            }

        }
            break;
        case kPartnerHeight:
        {
            SetViewLeftUp(icon, 32, 28);
            [icon setImage:[UIImage imageNamed:@"icon_height_topic.png"]];
             [label_first setAlpha:0];
              SetViewLeftUp(label_second, 66, 32);
            SetViewLeftUp(label_compare, 432, 32);

            if ([data BabyHeight] != 0) {
                 [label_second  setText:[NSString stringWithFormat:@"%0.1fcm",[data BabyHeight]]];
                if ([userData BabyHeight] !=0) {
                    if ([userData BabyHeight]>[data BabyHeight]) {
                         [label_compare setText:[NSString stringWithFormat:@"低%0.1fcm",[userData BabyHeight]-[data BabyHeight]]];
                    }else if ([userData BabyHeight] == [data BabyHeight])
                    {
                        [label_compare setText:@"一样高"];
                    }else{
                        [label_compare setText:[NSString stringWithFormat:@"高%0.1fcm",[data BabyHeight]-[userData BabyHeight]]];
                    }
                   
                }else{
                
                }
            }else{
        
            }
          
        }
            
            break;
        case kPartnerWeight:
        {
            SetViewLeftUp(icon, 32, 28);
            [icon setImage:[UIImage imageNamed:@"icon_weight_topic.png"]];
            [label_first setAlpha:0];
            SetViewLeftUp(label_second, 66, 32);
            SetViewLeftUp(label_compare, 432, 32);

            if ([data BabyWeight] != 0) {
                [label_second  setText:[NSString stringWithFormat:@"%0.1fkg",[data BabyWeight]]];
                if ([userData BabyWeight] !=0) {
                    if ((float)[userData BabyWeight]>[data BabyWeight]) {
                        [label_compare setText:[NSString stringWithFormat:@"轻%0.1fkg",[userData BabyWeight]-[data BabyWeight]]];
                    }else if ([userData BabyWeight] == [data BabyWeight])
                    {
                        [label_compare setText:@"一样重"];
                    }else{
                        [label_compare setText:[NSString stringWithFormat:@"重%0.1fkg",[data BabyWeight]-[userData BabyWeight]]];
                    }
                    
                }else{
                    
                }
            }else{
                
            }
        }
          
            break;
    

        default:
            break;
    }
    
}
- (void)setFirst:(NSString *)first andSecond:(NSString *)second andCompared:(NSString *)compared;
{
    if ([first isEqualToString:@""]) {
        [label_first setAlpha:0];
         SetViewLeftUp(label_second, 66, 40);
    }else{
        [label_first setAlpha:1];
        [label_first setText:first];
        SetViewLeftUp(label_second, 66, 56);
    }
    [label_second  setText:second];
    [label_compare setText:compared];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
