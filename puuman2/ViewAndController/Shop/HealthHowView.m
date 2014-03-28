//
//  HealthHowView.m
//  puman
//
//  Created by 祁文龙 on 13-12-20.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "HealthHowView.h"

@implementation HealthHowView
@synthesize howdelegate = _howdelegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        pageOnShow = 0;
        content = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 640, 360)];
        [content setContentSize:CGSizeMake(frame.size.width*4, frame.size.height)];
        [content setShowsHorizontalScrollIndicator:NO];
        [content setShowsVerticalScrollIndicator:NO];
        [content setPagingEnabled:YES];
        [content setDelegate:self];
        [self addSubview:content];
        [self initialization];
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(220, 330, 200, 30)];
        pageControl.numberOfPages = 4;
        pageControl.currentPage = 0;
        [self addSubview:pageControl];
 
    }
    return self;
}
- (void)setHowdelegate:(id<HealthHowViewDelegate>)howdelegate
{
    _howdelegate = howdelegate;
    switch (pageOnShow) {
        case 0:
            [_howdelegate  setFlagImg:@"num1_insure_shop.png"  andTitle:@"" andDetail:@"拨打高端医疗咨询热线，高端医疗险顾问为您提供咨询服务"];
            break;
        case 1:
            [_howdelegate setFlagImg:@"num2_insure_shop.png"  andTitle:@"" andDetail:@"针对您的特定需求，高端医疗险顾问会甄选适宜的产品，并将相关计划与您做充分说明与沟通，直至您选择满意的产品"];
            break;
        case 2:
            [_howdelegate setFlagImg:@"num3_insure_shop.png"  andTitle:@"" andDetail:@"协助做投保与承保事宜，以使保单顺利承保"];
            break;
        case 3:
            [_howdelegate setFlagImg:@"num4_insure_shop.png"  andTitle:@"" andDetail:@"投保后的持续服务"];
            break;
            
        default:
            break;
     }
}
- (void)initialization
{
     call =[[CallingView alloc] initWithFrame:CGRectMake(0, 0, 640, 360)];
    [content addSubview:call];

    happy =[[HappyView alloc] initWithFrame:CGRectMake(640*3, 0, 640, 360)];
    [content addSubview:happy];
    teached =[[TeachedView alloc] initWithFrame:CGRectMake(640*2, 0, 640, 360)];
    [content addSubview:teached];
    teaching =[[TeachingView alloc] initWithFrame:CGRectMake(640, 0, 640, 360)];
    [content addSubview:teaching];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    NSInteger page = (int)(scrollView.contentOffset.x/640);
    if (pageOnShow != page) {
        switch (page) {
            case 0:
                [_howdelegate  setFlagImg:@"num1_insure_shop.png"  andTitle:@"" andDetail:@"拨打高端医疗咨询热线，高端医疗险顾问为您提供咨询服务"];
                break;
            case 1:
                [_howdelegate setFlagImg:@"num2_insure_shop.png"  andTitle:@"" andDetail:@"针对您的特定需求，高端医疗险顾问会甄选适宜的产品，并将相关计划与您做充分说明与沟通，直至您选到满意的产品"];
                break;
            case 2:
                [_howdelegate setFlagImg:@"num3_insure_shop.png"  andTitle:@"" andDetail:@"协助做投保与承保事宜，以使保单顺利承保"];
                break;
            case 3:
                [_howdelegate setFlagImg:@"num4_insure_shop.png"  andTitle:@"" andDetail:@"投保后的持续服务"];
                break;
                
            default:
                break;
        }
        pageControl.currentPage =page;

    }
    NSLog(@"%d",page);
    if (page == 1) {
        [teaching restart];
    }else{
        [teaching pause];
    }
    if (page == 2) {
        [teached restart];
    }else{
        [teached pause];
    }
    pageOnShow = page;
    
}
- (void)remove
{
    [teached remove];
    [teaching remove];
    [call remove];
    [happy remove];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
