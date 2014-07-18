//
//  BabyInfoChooseButton.m
//  puuman2
//
//  Created by AF_Bigwaves on 14-6-30.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoChooseButton.h"
#import "ColorsAndFonts.h"
#import "BabyData.h"

@implementation BabyInfoChooseButton
@synthesize type = _type;
@synthesize stateLabel = _stateLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initialization];

    }
    return self;
}



- (void)initialization
{
  

    iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [iconView setImage:[UIImage imageNamed:@""]];
    [self addSubview:iconView];
    
    _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 32, 22)];
    [_stateLabel setFont:PMFont2];
    [self addSubview:_stateLabel];
    
    detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 0,95 , 22)];
    [detailLabel setFont:PMFont2];
    [self addSubview:detailLabel];
    
    instLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,24, 180, 46)];
    [instLabel setNumberOfLines:3];
    [self addSubview:instLabel];

}

- (NSString *)timeStrFrom:(NSDate *)date
{
    NSInteger d = [[NSDate date] timeIntervalSinceDate:date] / 24 / 60 / 60;
    if (d == 0) return @"今天";
    if (d == 1) return @"昨天";
    if (d == 2) return @"前天";
    if (d > 30) return @"n天前";
    else return [NSString stringWithFormat:@"%d天前", d];
}

- (void)setType:(BabyInfoType)type
{
    _type = type;
    switch (type) {
        case kBabyInfoHeight:
        {
            [iconView setImage:[UIImage imageNamed:@"icon_height_babyInfo.png"]];
            [_stateLabel setText:@"身高"];
            [_stateLabel setTextColor:PMColor4];
            
            if ([BabyData sharedBabyData].heightArray.count > 0) {
                NSDictionary *dic = [[BabyData sharedBabyData].heightArray lastObject];
                
               instLabel.text = [NSString stringWithFormat:@"%.2fcm",[[dic objectForKey:kBabyData_Height] doubleValue]];
                NSDate *measureDate = [dic valueForKey:kBabyData_Date];
                NSString *str = [self timeStrFrom:measureDate];
                if (str) {
                
                    detailLabel.text = [NSString stringWithFormat:@"(%@)",str];
                } else {
                
                  detailLabel.text = @"没有数据";
                }
            }
            
            //[detailLabel setText:@"(四周前)"];
            [detailLabel setTextColor:PMColor4];
           // [instLabel setText:@"50.5cm"];
            [instLabel setTextColor:[UIColor whiteColor]];
            [instLabel setFont:PMFont1];
        }
            break;
        case kBabyInfoWeight:
        {
            [iconView setImage:[UIImage imageNamed:@"icon_weight_babyInfo.png"]];
            [_stateLabel setText:@"体重"];
            [_stateLabel setTextColor:PMColor4];
            if ([BabyData sharedBabyData].weightArray.count > 0) {
                NSDictionary *dic = [[BabyData sharedBabyData].weightArray lastObject];
                instLabel.text = [NSString stringWithFormat:@"%.2fkg",[[dic objectForKey:kBabyData_Weight] doubleValue]];
                NSDate *measureDate = [dic valueForKey:kBabyData_Date];
                NSString *str = [self timeStrFrom:measureDate];
                if (str) {
                
                    detailLabel.text = [NSString stringWithFormat:@"(%@)",str];
                } else {
                
                    detailLabel.text = @"没有数据";
                }
            }
            
           // [detailLabel setText:@"(四周前)"];
            [detailLabel setTextColor:PMColor4];
           // [instLabel setText:@"15.5kg"];
            [instLabel setTextColor:[UIColor whiteColor]];
            [instLabel setFont:PMFont1];
        }
            break;
        case kBabyInfoVaci:
        {
            [iconView setImage:[UIImage imageNamed:@"icon_vaci_babyInfo.png"]];
            [_stateLabel setText:@"疫苗"];
            [_stateLabel setTextColor:PMColor4];
            [detailLabel setText:@"(4针未接种)"];
            [detailLabel setTextColor:[UIColor redColor]];
            [instLabel setText:@"疫苗名称疫苗名称疫苗名称疫苗名称疫苗名称"];
            [instLabel setTextColor:PMColor4];
            [instLabel setFont:PMFont2];
         
        }
            break;
            
        case kBabyInfoProp:
        {
            [iconView setImage:[UIImage imageNamed:@"icon_prop_babyInfo.png"]];
            [_stateLabel setText:@"道具"];
            [_stateLabel setTextColor:PMColor4];
            [instLabel setText:@"商品名称"];
            [instLabel setTextColor:PMColor4];
        }
            break;
        case kBabyInfoModle:
        {
            [iconView setImage:[UIImage imageNamed:@"icon_model_babyInfo.png"]];
            [_stateLabel setText:@"道具"];
            [_stateLabel setTextColor:PMColor2];
            [instLabel setText:@"商品名称商品名称"];
            [instLabel setTextColor:PMColor2];
            
        }
            break;
        case kBabyInfoBModle:
        {
            [iconView setImage:[UIImage imageNamed:@"icon_model_babyInfo.png"]];
            [_stateLabel setFrame:CGRectMake(30, 0, 85, 22)];
            [_stateLabel setText:@"切换到B超"];
            [_stateLabel setTextColor:PMColor2];

        }
            break;
        
        default:
            break;
    }
}


@end
