//
//  DiaryHeaderView.m
//  puman
//
//  Created by 祁文龙 on 13-11-13.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "DiaryProgressHeaderView.h"
#import "DiaryViewController.h"
#import "Device.h"
#import "ColorsAndFonts.h"
#import "ImportStore.h"

@implementation DiaryProgressHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
        isFinished = NO;
        [self setAlpha:0.5];
    
    }
    return self;
}


- (void)initialization
{
    
    bg_view =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
    [bg_view.layer setCornerRadius:10];
    [bg_view.layer setMasksToBounds:YES];
    [self addSubview:bg_view];
    
    progress = [[UIScrollView alloc] initWithFrame:CGRectMake(2, 2,self.frame.size.width - 4, 16)];
    [progress setScrollEnabled:NO];
    [progress.layer setCornerRadius:8];
    [progress.layer setMasksToBounds:YES];
    [self addSubview:progress];
    [progress setContentSize:CGSizeMake(self.frame.size.width*2, 16)];
    
    bg_progress =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width - 4,16)];

    [bg_progress.layer setCornerRadius:8];
    [bg_progress.layer setMasksToBounds:YES];
    [bg_progress setBackgroundColor:PMColor3];
    [progress setContentOffset:CGPointMake(self.frame.size.width, 0)];
    [progress addSubview:bg_progress];
    [bg_view setBackgroundColor:PMColor4];

   
}

- (void)diaryLoadedcnt:(int)cnt totalCnt:(int)totalCnt
{
    
    
    if (cnt < totalCnt) {
        _totalCnt = totalCnt;
        _cnt = cnt;
       
        if (_cnt >_totalCnt) {
            _cnt = _totalCnt;
        }
        
        if (!timer) {
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshProgress) userInfo:nil repeats:YES];
        }

    }else{
        if (cnt == totalCnt) {
            if (timer) {
                [timer invalidate];
                timer =nil;
            }
            [self finished];
        }
    }
    
}

- (void)refreshProgress
{
    CGPoint pos = progress.contentOffset;
    if (_cnt >_totalCnt) {
        _cnt = _totalCnt;
    }
    pos.x = ViewWidth(progress)-ViewWidth(progress)*_cnt/_totalCnt;
    [progress setContentOffset:pos animated:NO];
    
}


- (void)finished
{
    isFinished = YES;

    if (progress.contentOffset.x  >0) {
        [self refreshProgress];
        [[DiaryViewController sharedDiaryViewController] loadDownFindished];
      
    }
   
}

@end
