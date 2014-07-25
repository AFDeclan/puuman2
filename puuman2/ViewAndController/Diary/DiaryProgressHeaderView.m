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
@synthesize isDiary =_isDiary;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
        _isDiary = YES;
        isFinished = NO;
        [self setAlpha:1];
    
    }
    return self;
}


- (void)initialization
{
    
    bg_view =[[UIImageView alloc] initWithFrame:CGRectMake(48, 0, self.frame.size.width-40-48-40, 20)];
    [bg_view.layer setCornerRadius:10];
    [bg_view.layer setMasksToBounds:YES];
    [self addSubview:bg_view];

    
    progress = [[UIScrollView alloc] initWithFrame:CGRectMake(48, 0,self.frame.size.width-40-48-40, 20)];
    [progress setScrollEnabled:NO];
    [progress.layer setCornerRadius:10];
    [progress.layer setMasksToBounds:YES];
    [self addSubview:progress];
    [progress setContentSize:CGSizeMake((self.frame.size.width-40-48-40)*2, 20)];
     bg_progress =[[UIImageView alloc] initWithFrame:CGRectMake(48, 0,self.frame.size.width-40-48-40,20)];
    [progress setContentOffset:CGPointMake(self.frame.size.width-40, 0)];
    [progress addSubview:bg_progress];
    

   
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

- (void)setIsDiary:(BOOL)isDiary
{
    _isDiary = isDiary;
    if (_isDiary) {
        [bg_progress setBackgroundColor:PMColor3];
        [bg_view setBackgroundColor:PMColor4];

    }else{
        [bg_progress setBackgroundColor:RGBColor(239, 84, 77)];
        [bg_view setBackgroundColor:RGBColor(239, 128, 123)];

    }
}
- (void)refreshProgress
{
    CGPoint pos = progress.contentOffset;
    if (_cnt >_totalCnt) {
        _cnt = _totalCnt;
    }
    pos.x =self.frame.size.width-self.frame.size.width*_cnt/_totalCnt;
    [progress setContentOffset:pos animated:YES];
    if (_isDiary) {
        [[DiaryViewController sharedDiaryViewController] diaryLoaded];
    }else{
        [[DiaryViewController sharedDiaryViewController] setImportTotalNum:0];
        [[ImportStore shareImportStore] addNewDiary];
        [[DiaryViewController sharedDiaryViewController] refreshTable];
        [[ImportStore shareImportStore] reset];
    }
    
    [self performSelector:@selector(reset) withObject:nil afterDelay:0];

}



- (void)finished
{
    isFinished = YES;
    if (progress.contentOffset.x  >0) {

        [UIView animateWithDuration:0.5 animations:^{
           // progress.contentOffset = CGPointMake(0, 0);
            [self refreshProgress];
            [self setAlpha:0];
        }];
      
    }
   
}

- (void)reset
{
    isFinished = NO;

}
@end
