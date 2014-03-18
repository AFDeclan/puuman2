//
//  LineChartCell.m
//  puman
//
//  Created by 祁文龙 on 13-10-22.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "LineChartCell.h"
#import "BabyInfoViewController.h"
#import "BabyData.h"
#import "ColorsAndFonts.h"

#define MinSubDistance 12
#define LineChartViewHeight 544
#define LineChartViewWidth 408

@implementation LineChartCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 544, 408)];
        [scroll setContentSize:CGSizeMake(544*2, 408)];
        [scroll setBackgroundColor:[UIColor clearColor]];
        [scroll setPagingEnabled:YES];
        [scroll setDelegate:self];
        [scroll setShowsHorizontalScrollIndicator:NO];
        [scroll setShowsVerticalScrollIndicator:NO];
        [self.contentView addSubview:scroll];
        [self initilzation];

        pageControl = [[AFPageControl alloc] initWithFrame:CGRectMake(0, 316, 544, 6)];
        pageControl.pointSize = CGSizeMake(6, 6);
        pageControl.currentPage = 1;
        pageControl.numberOfPages = 2;
        pageControl.hidesForSinglePage = YES;
        pageControl.userInteractionEnabled = NO;
        pageControl.scrollView = scroll;
        [pageControl setBackgroundColor:[UIColor whiteColor]];
        [pageControl setAlpha:0.5];
        [self.contentView addSubview:pageControl];
        
        [pageControl setAlpha:1];
    }
    return self;
}
- (void)initilzation
{
    lineChartHeight = [[LineChartView alloc] initWithFrame:CGRectMake(0, 0, 544, 408)];
    
    [scroll addSubview:lineChartHeight];
    lineChartWeight = [[LineChartView alloc] initWithFrame:CGRectMake(544, 0, 544, 408)];
    
    [scroll addSubview:lineChartWeight];
}
- (void)setViewIsHeight:(BOOL)isHeight
{
    [lineChartHeight initWithHeightType:YES];
    [lineChartWeight initWithHeightType:NO];
    if (isHeight) {
       
         [scroll scrollRectToVisible:lineChartHeight.frame animated:NO];
    }else{
         [scroll scrollRectToVisible:lineChartWeight.frame animated:NO];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if ((int)(scroll.contentOffset.x/320) == 0) {
//        [[BabyInfoViewController sharedBabyInfoViewController] setIsHeight:YES];
//        
//    }else{
//         [[BabyInfoViewController sharedBabyInfoViewController] setIsHeight:NO];
//    }
    [scrollView setPagingEnabled:YES];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setPagingEnabled:NO];
}
@end
