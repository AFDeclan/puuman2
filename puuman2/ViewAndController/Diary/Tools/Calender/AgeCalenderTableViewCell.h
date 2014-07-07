//
//  AgeCalenderTableViewCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-6-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgeCalenderTableViewCell : UITableViewCell
{
    NSDate *date_firstDay;
    NSDate *date_nextFirstDay;
    UILabel *labels[6][7];
    UITapGestureRecognizer *gestureRecognizer[6][7];
    NSInteger days;
    NSInteger now_day;
    NSInteger month;
    NSInteger now_month;
}
- (void)buildMonthWithCurrentIndex:(NSInteger)index;
@end
