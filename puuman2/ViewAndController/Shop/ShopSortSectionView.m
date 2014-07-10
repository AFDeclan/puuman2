//
//  ShopSortSectionView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ShopSortSectionView.h"

@implementation ShopSortSectionView

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
    priceBtn = [[AFSelecedTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 64, 96)];
    [priceBtn setSelectedImg:[UIImage imageNamed:@"btn_price_shop1.png"] andUnselectedImg:[UIImage imageNamed:@"btn_price_shop.png"]];
    [priceBtn addTarget:self action:@selector(priceBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:priceBtn];
    
    heatBtn = [[AFSelecedTextImgButton alloc] initWithFrame:CGRectMake(0, 96, 64, 96)];
    [heatBtn setSelectedImg:[UIImage imageNamed:@"btn_heat_shop1.png"] andUnselectedImg:[UIImage imageNamed:@"btn_heat_shop.png"]];
    [heatBtn addTarget:self action:@selector(heatBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:heatBtn];
    
    timeBtn = [[AFSelecedTextImgButton alloc] initWithFrame:CGRectMake(0, 96*2, 64, 96)];
    [timeBtn setSelectedImg:[UIImage imageNamed:@"btn_time_shop1.png"] andUnselectedImg:[UIImage imageNamed:@"btn_time_shop.png"]];
    [timeBtn addTarget:self action:@selector(timeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:timeBtn];
    [self priceBtnPressed];
}

- (void)priceBtnPressed
{
    [priceBtn selected];
    [timeBtn unSelected];
    [heatBtn unSelected];
    
}

- (void)timeBtnPressed
{
    [timeBtn selected];
    [priceBtn unSelected];
    [heatBtn unSelected];
}

- (void)heatBtnPressed
{
    [heatBtn selected];
    [timeBtn unSelected];
    [priceBtn unSelected];
}

@end
