//
//  CalendarView.h
//  PuumanForPhone
//
//  Created by Declan on 14-1-13.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFTextImgButton.h"
#import "DiaryModel.h"

@interface CalendarView : UIScrollView
{
    NSDate *showDate, *startDate;
    NSInteger weekCnt;
    UILabel *labels[6][7];
    UITapGestureRecognizer *gestureRecognizer[6][7];
    AFTextImgButton *_preBtn, *_nextBtn;
    UILabel *_yearLabel, *_monthLabel;
    
}

- (void)setDate:(NSDate *)date;
- (void)refresh;
- (NSString *)getYear;
- (NSString *)getMonth;
@end
