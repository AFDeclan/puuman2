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
    UIView *bgView;
    UIView *contentView;
    UILabel *title;
    UIImageView *icon;
    UIButton *button;
    UIScrollView * progress;
    NSTimer  *timer;
    int _totalCnt;
    int _cnt;
    BOOL isFinished;
   
}
@property(assign,nonatomic) BOOL isDiary;

- (void)setBgPointY:(float)pointY;
- (void)diaryLoadedcnt:(int)cnt totalCnt:(int)totalCnt;
- (void)finished;
@end
