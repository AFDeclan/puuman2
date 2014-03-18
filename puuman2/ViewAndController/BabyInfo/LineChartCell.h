//
//  LineChartCell.h
//  puman
//
//  Created by 祁文龙 on 13-10-22.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineChartView.h"
#import "AFPageControl.h"


@interface LineChartCell : UITableViewCell<UIScrollViewDelegate>
{
    UIScrollView *scroll;
    LineChartView *lineChartHeight;
    LineChartView *lineChartWeight;
    AFPageControl *pageControl;
    
}
- (void)setViewIsHeight:(BOOL)isHeight;
@end
