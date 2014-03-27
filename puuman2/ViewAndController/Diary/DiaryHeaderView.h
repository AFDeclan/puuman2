//
//  DiaryHeaderView.h
//  puman
//
//  Created by 祁文龙 on 13-11-13.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaryHeaderView : UIView
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
@property(assign,nonatomic) BOOL isDiary;

- (void)diaryLoadedcnt:(int)cnt totalCnt:(int)totalCnt;
- (void)finished;
@end
