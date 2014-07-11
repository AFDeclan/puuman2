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
    sortView = [[ShopSortSectionView alloc] initWithFrame:CGRectMake(0, 0, 64, 96*3)];
    [self addSubview:sortView];
    [sortView setAlpha:0];
    
 

    [MyNotiCenter addObserver:self selector:@selector(showAllShop:) name:Noti_ShowAllShopView object:nil];
}



- (void)showAllShop:(NSNotification *)notification
{
    showAllShop = [[notification object] boolValue];
    if (showAllShop) {
        [sortView setAlpha:1];
        [sortView refresh];
    }else{
        [sortView setAlpha:0];
    
    }
}


- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}

@end
