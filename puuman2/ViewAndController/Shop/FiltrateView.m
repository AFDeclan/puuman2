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
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 16, 604, 178)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:headerView];
    
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 604, 20)];
    [headerView setBackgroundColor:PMColor6];
    [self addSubview:headerView];
    
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 604, 20)];
    [footerView setBackgroundColor:PMColor6];
    [self addSubview:footerView];
    
 
    
    

}


- (void)show
{
    [headerView setFrame:CGRectMake(0, 0, 604, 16)];
    [footerView setFrame:CGRectMake(0, 194, 604, 20)];

}
- (void)hidden
{
    [headerView setFrame:CGRectMake(0, 0, 604, 20)];
    [footerView setFrame:CGRectMake(0, 20, 604, 20)];
}


@end
