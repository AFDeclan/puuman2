//
//  HeightPartnerDataCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BodyPartnerDataCell.h"
#import "ColorsAndFonts.h"
#import "NSDate+Compute.h"
#import "UniverseConstant.h"

@implementation BodyPartnerDataCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        histogram = [[UIView alloc] init];
        [self addSubview:histogram];
        date_info = [[UILabel alloc] initWithFrame:CGRectMake(0, 224-16, 96,16 )];
        [date_info setBackgroundColor:[UIColor clearColor]];
        [date_info setTextColor:[UIColor whiteColor]];
        [date_info setFont:PMFont4];
        [date_info setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:date_info];
        
        data_info = [[UILabel alloc] initWithFrame:CGRectMake(0, 224-16, 96,16 )];
        [data_info setBackgroundColor:[UIColor clearColor]];
        [data_info setFont:PMFont4];
        [data_info setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:data_info];
        
        mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 96, 224)];
        [mask setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:mask];
    }
    return self;
}

- (void)setBodyData:(float)bodyValue andTheDate:(NSDate *)date andHighest:(float)highest andLowest:(float)lowest andIsHeight:(BOOL) height;
{
    
    
    if (highest == lowest) {
        [histogram setFrame:CGRectMake(0, 224-200, 96, 200)];
    }else{
        float h = 50+(bodyValue-lowest)*(highest -lowest)/(200-50);
        [histogram setFrame:CGRectMake(0, 224-h, 96, h)];
    }
    if (bodyValue == highest) {
        [mask setAlpha:0];
    }else if(bodyValue == lowest){
        [mask setAlpha:0.5];
    }else{
        [mask setAlpha:0.3];
    }
    [data_info setText:[NSString stringWithFormat:@"%0.1fcm",bodyValue]];
    [date_info setText:@"比我大2天"];
    SetViewLeftUp(data_info, 0, ViewY(histogram)-16);
    
    if (height) {
        [histogram setBackgroundColor:RGBColor(246, 114, 99)];
        [data_info setTextColor:RGBColor(246, 114, 99)];
    }else{
         [histogram setBackgroundColor:RGBColor(228, 206, 58)];
        [data_info setTextColor:RGBColor(228, 206, 58)];
    }
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
