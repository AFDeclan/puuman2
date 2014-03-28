//
//  ShopMenuView.m
//  puman
//
//  Created by 祁文龙 on 13-11-16.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "ShopMenuView.h"
#import "ColorsAndFonts.h"
#import "ShopViewController.h"
#import "ShopModel.h"
#import "MainTabBarController.h"


@implementation ShopMenuView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        menuView = [[MenuView alloc] initWithFrame:CGRectMake(0,0, 216, 384 )];
        [self addSubview:menuView];
        rankView = [[RankView alloc] initWithFrame:CGRectMake(0,0, 216,304)];
        [self addSubview:rankView];
     
    }
    return self;
}


-(void)setVerticalFrame
{
    [rankView setFrame:CGRectMake(0,384, 216, 560 )];
    [rankView setVerticalFrame];
   
}

-(void)setHorizontalFrame
{
    [rankView setFrame:CGRectMake(0,384, 216 ,304 )];
    [rankView setHorizontalFrame];
}



- (void)selectedParentIndex:(NSInteger)parentIndex andChildIndex:(NSInteger)childIndex
{
    [menuView selectedParentIndex:parentIndex andChildIndex:childIndex];
}


- (void)reloadRankView
{
     [rankView sortTableReload];
}

- (void)updateRankView
{
    [rankView sortTableUpdate];
}






@end
