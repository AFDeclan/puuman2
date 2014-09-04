//
//  BabyLineChartView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-9-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineChartView.h"
#import "AFPageControl.h"

@interface BabyLineChartView : UIView<UIScrollViewDelegate>
{
    UIScrollView *scroll;
    LineChartView *lineChartHeight;
    LineChartView *lineChartWeight;
    AFPageControl *pageControl;
}


@end
