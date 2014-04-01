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
    label_first = [[UILabel alloc] initWithFrame:CGRectMake(66, 24, 366, 16)];
    [label_first setBackgroundColor:[UIColor clearColor]];
    [label_first setFont:PMFont2];
    [label_first setTextColor:PMColor2];
    [label_first setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:label_first];
    
    label_second = [[UILabel alloc] initWithFrame:CGRectMake(66, 0, 366, 16)];
    [label_second setBackgroundColor:[UIColor clearColor]];
    [label_second setFont:PMFont2];
    [label_second setTextColor:PMColor2];
    [label_second setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:label_second];
    label_compare = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 144, 80)];
    [label_compare setBackgroundColor:[UIColor clearColor]];
    [label_compare setFont:PMFont2];
    [label_compare setTextColor:PMColor1];
    [label_compare setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:label_compare];
    
    line = [[UIImageView alloc] init];
    [line setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@""]]];
    
}


- (void)buildWithData:(id)data andUserData:(id)userData andDataType:(PartnerDataInfoType )type
{

    switch (type) {
        case kPartnerBirthday:
        {
            [label_first setAlpha:1];
            SetViewLeftUp(label_second, 66, 40);

        }
            break;
        case kPartnerHeight:
        {
             [label_first setAlpha:0];
              SetViewLeftUp(label_second, 66, 56);
            if ([data floatValue] != 0) {
                 [label_second  setText:[NSString stringWithFormat:@"%0.1fkg",[data floatValue]]];
                if ([userData floatValue] !=0) {
                    if ([userData floatValue]>[data floatValue]) {
                         [label_compare setText:[NSString stringWithFormat:@"低%fcm",[userData floatValue]-[data floatValue]]];
                    }else if ([userData floatValue] == [data floatValue])
                    {
                        [label_compare setText:@"一样高"];
                    }else{
                        [label_compare setText:[NSString stringWithFormat:@"高%fcm",[data floatValue]-[userData floatValue]]];
                    }
                   
                }else{
                
                }
            }else{
        
            }
          
        }
            
            break;
        case kPartnerWeight:
        {
            [label_first setAlpha:0];
            SetViewLeftUp(label_second, 66, 56);
            if ([data floatValue] != 0) {
                [label_second  setText:[NSString stringWithFormat:@"%0.1fkg",[data floatValue]]];
                if ([userData floatValue] !=0) {
                    if ((float)[userData floatValue]>[data floatValue]) {
                        [label_compare setText:[NSString stringWithFormat:@"轻%fkg",[userData floatValue]-[data floatValue]]];
                    }else if ([userData floatValue] == [data floatValue])
                    {
                        [label_compare setText:@"一样重"];
                    }else{
                        [label_compare setText:[NSString stringWithFormat:@"重%fkg",[data floatValue]-[userData floatValue]]];
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
