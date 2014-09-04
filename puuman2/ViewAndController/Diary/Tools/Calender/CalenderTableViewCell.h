//
//  CalenderTableViewCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-6-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalenderTableViewCell : UITableViewCell
{
    UILabel *labels[6][7];
    UITapGestureRecognizer *gestureRecognizer[6][7];
    NSDate *showDate, *startDate;
    NSInteger weekCnt;
}
- (void)buildMonthWithCurrentIndex:(NSInteger)index;
@end
