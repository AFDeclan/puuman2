//
//  FiltrateView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-16.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "FiltrateView.h"
#import "UniverseConstant.h"

@implementation FiltrateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        [self initialization];

    }
    return self;
}

- (void)initialization
{
    titleArray = [[NSArray alloc] initWithObjects:@"品牌",@"价格",@"产地",@"品牌",@"价格",@"产地", nil];
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 16, 604, 178)];
    [contentView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:contentView];
    
    
    
    for (int i = 0; i< 6; i ++) {
    
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(201*(i%3), 89*(i/3), 201, 89)];
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 12, 150, 20)];
        [titleLabel setFont:PMFont2];
        [titleLabel setTextColor:PMColor2];
        [titleLabel setText:[titleArray objectAtIndex:i]];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
        [view addSubview:titleLabel];
        
        if (i % 2 == 0) {
             [view setBackgroundColor:PMColor4];
            
        } else {
        
            [view setBackgroundColor:[UIColor whiteColor]];
            
        }
        [contentView addSubview:view];
    
    }
    
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 604, 20)];
    [headerView setBackgroundColor:RGBColor(229, 105, 104)];
    [self addSubview:headerView];
    
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 604, 20)];
    [footerView setBackgroundColor:RGBColor(229, 105, 104)];
    [self addSubview:footerView];

}


- (void)show
{
    [headerView setFrame:CGRectMake(0, 0, 604, 16)];
    [footerView setFrame:CGRectMake(0, 194, 604, 16)];

}
- (void)hidden
{
    [headerView setFrame:CGRectMake(0, 0, 604, 20)];
    [footerView setFrame:CGRectMake(0, 20, 604, 20)];
}


@end
