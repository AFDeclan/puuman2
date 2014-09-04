//
//  BabyLineChartView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-9-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyLineChartView.h"

#define MinSubDistance 12
#define LineChartViewHeight 544
#define LineChartViewWidth 408


@implementation BabyLineChartView

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
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 544, 408)];
    [scroll setContentSize:CGSizeMake(544*2, 408)];
    [scroll setBackgroundColor:[UIColor clearColor]];
    [scroll setPagingEnabled:YES];
    [scroll setDelegate:self];
    [scroll setShowsHorizontalScrollIndicator:NO];
    [scroll setShowsVerticalScrollIndicator:NO];
    [self addSubview:scroll];
    lineChartHeight = [[LineChartView alloc] initWithFrame:CGRectMake(0, 0, 544, 408)];
    [scroll addSubview:lineChartHeight];
    lineChartWeight = [[LineChartView alloc] initWithFrame:CGRectMake(544, 0, 544, 408)];
    [scroll addSubview:lineChartWeight];
    
    pageControl = [[AFPageControl alloc] initWithFrame:CGRectMake(0, 332, 544, 6)];
    pageControl.pointSize = CGSizeMake(6, 6);
    pageControl.currentPage = 1;
    pageControl.numberOfPages = 2;
    pageControl.hidesForSinglePage = YES;
    pageControl.userInteractionEnabled = NO;
    pageControl.scrollView = scroll;
    [pageControl setBackgroundColor:[UIColor whiteColor]];
    [pageControl setAlpha:0.5];
    [self addSubview:pageControl];
    
    [pageControl setAlpha:1];
    
    [lineChartHeight initWithHeightType:YES];
    [lineChartWeight initWithHeightType:NO];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [scrollView setPagingEnabled:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setPagingEnabled:NO];
}
@end
