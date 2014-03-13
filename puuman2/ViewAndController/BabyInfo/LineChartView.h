//
//  LineChartView.h
//  PuumanForPhone
//
//  Created by 祁文龙 on 14-1-17.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineChart.h"
@interface LineChartView : UIView
{
    UIImageView *bgImgView;
    LineChart *lineChart;
    UILabel *nodataLabel;
    
}
- (void)initWithHeightType:(BOOL)isHeight;
@end
