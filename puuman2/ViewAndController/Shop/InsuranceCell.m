//
//  InsuranceCell.m
//  puman
//
//  Created by 祁文龙 on 13-11-11.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "InsuranceCell.h"
#import "InsuranceCellSubview.h"
#import "UniverseConstant.h"
#import "MainTabBarController.h"
@implementation InsuranceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = PMColor5;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        CGRect frame = CGRectMake(0, 16, 208, 256);
        for (int i=0; i<3; i++)
        {
            _insuranceView[i] = [[InsuranceCellSubview alloc] initWithFrame:frame];
            [self.contentView addSubview:_insuranceView[i]];
            frame.origin.x += frame.size.width + 8;
        }
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(setHorizontalFrame) name:NOTIFICATION_Horizontal object:nil];
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(setVerticalFrame) name:NOTIFICATION_Vertical object:nil];
    }
    return self;
}

- (void)setVerticalFrame
{
    [self.contentView setAlpha:0];
    
}

- (void)setHorizontalFrame
{
    [self.contentView setAlpha:1];
}

- (void)setInsurances:(NSArray *)insurances;
{
    _insurances = insurances;
    for (int i=0; i<3; i++)
    {
        if (i >= [insurances count])
        {
            [_insuranceView[i] setInsurance:nil];
        }
        else {
            [_insuranceView[i] setInsurance:[insurances objectAtIndex:i]];
        }
    }
}


@end
