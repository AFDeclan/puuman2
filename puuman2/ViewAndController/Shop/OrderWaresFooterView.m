//
//  OrderWaresFooterView.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-24.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "OrderWaresFooterView.h"
#import "UniverseConstant.h"
#import "PaidViewController.h"
#import "MainTabBarController.h"

@implementation OrderWaresFooterView
@synthesize section = _section;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    selectedBtn = [[ColorButton alloc] init];
    [self addSubview:selectedBtn];
    SetViewLeftUp(selectedBtn, 0, 8);
    [selectedBtn addTarget:self action:@selector(selectedButtonSelectedWithButton) forControlEvents:UIControlEventTouchUpInside];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(540 - 16 - 164, 0, 160, 32)];
    [priceLabel setBackgroundColor:[UIColor clearColor]];
    [priceLabel setTextAlignment:NSTextAlignmentRight];
    [priceLabel setTextColor:PMColor6];
    [priceLabel setFont:PMFont2];
    [priceLabel setText:@"￥2345.00"];
    [selectedBtn addSubview:priceLabel];
    
    infolabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 160, 32)];
    [infolabel setBackgroundColor:[UIColor clearColor]];
    [infolabel setTextColor:PMColor3];
    [infolabel setFont:PMFont4];
    [infolabel setText:@"物流信息"];
    [self addSubview:infolabel];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 540, 32)];
    [button addTarget:self action:@selector(selected) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor clearColor]];
    [self  addSubview:button];
    [button setAlpha:0];
    [self setBackgroundColor:PMColor5];
    
}

- (void)setSection:(NSInteger)section
{
    _section = section;
    if (section  == 0) {
        [priceLabel setAlpha:1];
        [selectedBtn setAlpha:1];
        [infolabel setAlpha:0];
        [selectedBtn initWithTitle:@"付款" andButtonType:kBlueRight];
        [button setAlpha:0];
    }else if(section  == 1)
    {
        [infolabel setAlpha:1];
        [selectedBtn setAlpha:0];
        [priceLabel setAlpha:0];
        [button setAlpha:1];

    }else{
        [infolabel setAlpha:0];
        [priceLabel setAlpha:0];
        [selectedBtn setAlpha:1];
        [selectedBtn initWithTitle:@"评价" andButtonType:kBlueRight];
        [button setAlpha:0];

    }
}

- (void)selected
{

}

- (void)selectedButtonSelectedWithButton
{
    if (_section == 0) {
        PaidViewController *paidVC =[[PaidViewController alloc] initWithNibName:nil bundle:nil];
        [[MainTabBarController sharedMainViewController].view addSubview:paidVC.view];
        [paidVC setControlBtnType:kOnlyCloseButton];
        [paidVC setTitle:@"结算" withIcon:nil];
        [paidVC show];
    }
}

@end
