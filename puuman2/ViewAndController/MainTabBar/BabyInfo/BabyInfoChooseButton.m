//
//  BabyInfoChooseButton.m
//  puuman2
//
//  Created by AF_Bigwaves on 14-6-30.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoChooseButton.h"
#import "ColorsAndFonts.h"

@implementation BabyInfoChooseButton
@synthesize type = _type;

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
    
    stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 32, 22)];
    [stateLabel setFont:PMFont2];
    [self addSubview:stateLabel];
    
    detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 0,95 , 22)];
    [detailLabel setFont:PMFont2];
    [self addSubview:detailLabel];
    
    instLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,24, 210, 46)];
    [instLabel setNumberOfLines:2];
    [self addSubview:instLabel];

}

- (void)setType:(BabyInfoType)type
{
    _type = type;
    switch (type) {
        case kBabyInfoHeight:
        {
            [iconView setImage:[UIImage imageNamed:@"icon_height_babyInfo.png"]];
            [stateLabel setText:@"身高"];
            [stateLabel setTextColor:PMColor4];
            [detailLabel setText:@"(四周前)"];
            [detailLabel setTextColor:PMColor4];
            [instLabel setText:@"50.5cm"];
            [instLabel setTextColor:[UIColor whiteColor]];
            [instLabel setFont:PMFont1];
        }
            break;
        case kBabyInfoWeight:
        {
            [iconView setImage:[UIImage imageNamed:@"icon_weight_babyInfo.png"]];
            [stateLabel setText:@"体重"];
            [stateLabel setTextColor:PMColor4];
            [detailLabel setText:@"(四周前)"];
            [detailLabel setTextColor:PMColor4];
            [instLabel setText:@"15.5kg"];
            [instLabel setTextColor:[UIColor whiteColor]];
            [instLabel setFont:PMFont1];
        }
            break;
        case kBabyInfoVaci:
        {
            [iconView setImage:[UIImage imageNamed:@"icon_vaci_babyInfo.png"]];
            [stateLabel setText:@"疫苗"];
            [stateLabel setTextColor:PMColor4];
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
            [stateLabel setText:@"道具"];
            [stateLabel setTextColor:PMColor4];
            [instLabel setText:@"商品名称"];
            [instLabel setTextColor:PMColor4];
        }
            break;
        case kBabyInfoModle:
        {
            [iconView setImage:[UIImage imageNamed:@"icon_model_babyInfo.png"]];
            [stateLabel setText:@"道具"];
            [stateLabel setTextColor:PMColor2];
            [instLabel setText:@"商品名称商品名称"];
            [instLabel setTextColor:PMColor2];
            
        }
            break;
        case kBabyInfoBModle:
        {
            [iconView setImage:[UIImage imageNamed:@"icon_model_babyInfo.png"]];
            [stateLabel setFrame:CGRectMake(30, 0, 85, 22)];
            [stateLabel setText:@"切换到B超"];
            [stateLabel setTextColor:PMColor2];

        }
            break;
        
        default:
            break;
    }
}


@end
