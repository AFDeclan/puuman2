//
//  DiaryHeaderView.h
//  puman
//
//  Created by 祁文龙 on 13-11-13.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaryProgressHeaderView : UIView
{
    UILabel *title;
    UIButton *button;
    UIScrollView * progress;
    UIImageView *bg_view;
    UIImageView *bg_progress;
    NSTimer  *timer;
    int _totalCnt;
    int _cnt;
    
    BOOL isFinished;
}

- (void)diaryLoadedcnt:(int)cnt totalCnt:(int)totalCnt;
- (void)finished;
@end
