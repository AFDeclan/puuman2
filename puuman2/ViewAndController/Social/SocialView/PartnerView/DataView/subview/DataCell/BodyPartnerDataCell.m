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
@synthesize showLine = _showLine;
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
        line = [[UIView alloc]initWithFrame:CGRectMake(-1, 0, 2, 224)];
        [line setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_timeline_diary.png"]]];
        [self addSubview:line];
        
    }
    return self;
}

- (void)setBodyData:(float)bodyValue andTheDate:(NSDate *)date andHighest:(float)highest andLowest:(float)lowest andIsHeight:(BOOL) height;
{
    
     _height = 0;
     [histogram setFrame:CGRectMake(0, 224, 96, 0)];
    if (bodyValue == 0) {
        _height = 0;
    }else{
        if (highest == lowest) {
            _height = 200;
        }else{
            _height = 50+(bodyValue-lowest)*(highest -lowest)/(200-50);
        }
        
        if (bodyValue == highest) {
            _height = 200;
            [mask setAlpha:0];
        }else if(bodyValue == lowest){
            _height = 50;
            [mask setAlpha:0.5];
        }else{
            [mask setAlpha:0.3];
        }
        
        SetViewLeftUp(data_info, 0, ViewY(histogram)-16);
        
        if (height) {
            [data_info setText:[NSString stringWithFormat:@"%0.1fcm",bodyValue]];
            [histogram setBackgroundColor:RGBColor(246, 114, 99)];
            [data_info setTextColor:RGBColor(246, 114, 99)];
        }else{
            [data_info setText:[NSString stringWithFormat:@"%0.1fkg",bodyValue]];
            [histogram setBackgroundColor:RGBColor(228, 206, 58)];
            [data_info setTextColor:RGBColor(228, 206, 58)];
        }
        [UIView animateWithDuration:0.5 animations:^{
            [histogram setFrame:CGRectMake(0, 224-_height, 96, _height)];
             SetViewLeftUp(data_info, 0, ViewY(histogram)-16);
        }];
        

    }
    
    
    
    
    
}

- (void)setShowLine:(BOOL)showLine
{
    _showLine = showLine;
    if (showLine) {
        [line setAlpha:1];
    }else{
        [line setAlpha:0];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
