//
//  ShopSectionView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ShopSectionView.h"
#import "UniverseConstant.h"

@implementation ShopSectionView

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
    showAllShop = YES;
    showWareInfo = NO;
    sortView = [[ShopSortSectionView alloc] initWithFrame:CGRectMake(0, 0, 64, 96*3)];
    [self addSubview:sortView];
    [sortView setAlpha:0];
    
    wareInfoView = [[WareInfoSectionView alloc] initWithFrame:CGRectMake(0, 0, 64, 96*2)];
    [self addSubview:wareInfoView];
    [wareInfoView setAlpha:0];

    [MyNotiCenter addObserver:self selector:@selector(showWareInfo:) name:Noti_ShowWareInfo object:nil];
    [MyNotiCenter addObserver:self selector:@selector(showAllShop:) name:Noti_ShowAllShopView object:nil];
}

- (void)showWareInfo:(NSNotification *)notification
{
    showWareInfo = [[notification object] boolValue];
    [UIView animateWithDuration:0.5 animations:^{
        if (showWareInfo) {
            [wareInfoView setAlpha:1];
            [sortView setAlpha:0];
        }else{
            [wareInfoView setAlpha:0];
            if (showAllShop) {
                [sortView setAlpha:1];
            }

        }
    }];
 
}

- (void)showAllShop:(NSNotification *)notification
{
    showAllShop = [[notification object] boolValue];
    if (showWareInfo) {
        [wareInfoView setAlpha:0];
        [sortView setAlpha:1];
    }else{
        [sortView setAlpha:0];
    
    }
}


- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}

@end
