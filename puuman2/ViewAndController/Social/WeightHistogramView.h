//
//  WeightHistogramView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeightHistogramView : UIView
{
    UIView *histogram;
    UILabel *date_info;
    UILabel *data_info;
    UIView *mask;
}

- (void)setWeight:(float)weight andTheDate:(NSDate *)date andMax:(float)max andMin:(float)min;
@end
