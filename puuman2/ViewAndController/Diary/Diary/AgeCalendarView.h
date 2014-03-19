//
//  AgeCalendarView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-18.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFTextImgButton.h"

@interface AgeCalendarView : UIScrollView
{
    NSDate *date_firstDay;
    NSDate *date_nextFirstDay;
    NSInteger days;
    NSInteger now_day;
    NSInteger month;
    NSInteger now_month;
    UILabel *labels[6][7];
    AFTextImgButton *_preBtn, *_nextBtn;
    UITapGestureRecognizer *gestureRecognizer[6][7];
    
    BOOL birth;
    UILabel *titleLabel;
    UILabel *yearLabel;
    UILabel *monthLabel;
    int num;
    BOOL next;
    
}
- (void)nowMonth;
- (BOOL)getBitrh;
- (NSInteger)getmonth;
@end
