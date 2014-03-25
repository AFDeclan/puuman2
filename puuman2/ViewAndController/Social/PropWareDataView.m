//
//  PropWareDataView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PropWareDataView.h"
#import "ColorsAndFonts.h"

@implementation PropWareDataView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        propImageView = [[AFImageView alloc] initWithFrame:CGRectMake(0, 40,96, 96)];
        [propImageView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:propImageView];
        
       
        
        mask_name = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 96,32)];
        [mask_name setBackgroundColor:[UIColor whiteColor]];
        [mask_name setAlpha:0.5];
        [propImageView addSubview:mask_name];
        
        name_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 96, 32)];
        [name_label setTextAlignment:NSTextAlignmentCenter];
        [name_label setTextColor:PMColor2];
        [name_label setFont:PMFont4];
        [name_label setNumberOfLines:2];
        [name_label setBackgroundColor:[UIColor clearColor]];
        [mask_name  addSubview:name_label];
        
        status_label = [[UILabel alloc] initWithFrame:CGRectMake(12, 20, 84, 12)];
        [status_label setTextColor:PMColor3];
        [status_label setFont:PMFont3];
        [status_label setBackgroundColor:[UIColor clearColor]];
        [self  addSubview:status_label];
        
        mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [mask setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:mask];
    }
    return self;
}

- (void)setDataWithWareName:(NSString *)wareNmae andStatus:(NSString *)staus andWarePic:(NSString *)pic
{

    [name_label setText:wareNmae];
    [status_label setText:staus];
    [propImageView setImage:[UIImage imageNamed:pic]];
    [mask setAlpha:0.3];
}

@end
