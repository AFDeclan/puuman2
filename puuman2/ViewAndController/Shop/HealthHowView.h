//
//  HealthHowView.h
//  puman
//
//  Created by 祁文龙 on 13-12-20.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallingView.h"
#import "TeachingView.h"
#import "TeachedView.h"
#import "HappyView.h"
@protocol HealthHowViewDelegate;
@interface HealthHowView : UIView<UIScrollViewDelegate>
{
    CallingView *call;
    HappyView *happy;
    TeachedView *teached;
    TeachingView *teaching;
    NSInteger pageOnShow;
    UIScrollView *content;
    UIPageControl *pageControl;
}
@property (weak,nonatomic)id<HealthHowViewDelegate>howdelegate;
- (void)remove;
@end

@protocol HealthHowViewDelegate <NSObject>

- (void)setFlagImg:(NSString *)imgName andTitle:(NSString *)title andDetail:(NSString *)detail;

@end
