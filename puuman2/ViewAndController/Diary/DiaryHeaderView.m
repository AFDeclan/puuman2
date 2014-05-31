//
//  DiaryHeaderView.m
//  puman
//
//  Created by 祁文龙 on 13-11-13.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "DiaryHeaderView.h"
#import "DiaryViewController.h"
#import "Device.h"
#import "ColorsAndFonts.h"
#import "ImportStore.h"

@implementation DiaryHeaderView
@synthesize isDiary =_isDiary;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
        _isDiary = YES;
        isFinished = NO;
        
    }
    return self;
}


- (void)initialization
{
    
    bg_view =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:bg_view];

    
    progress = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height)];
    [progress setScrollEnabled:NO];
    [self addSubview:progress];
    [progress setContentSize:CGSizeMake(self.frame.size.width*2, self.frame.size.height)];
     bg_progress =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [progress setContentOffset:CGPointMake(self.frame.size.width, 0)];
    [progress addSubview:bg_progress];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [button setAdjustsImageWhenDisabled:NO];
    [button setBackgroundColor:[UIColor clearColor]];
    [button addTarget:self action:@selector(scan:)  forControlEvents:UIControlEventTouchUpInside];
    [button setEnabled:NO];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [title setFont:PMFont2];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setBackgroundColor:[UIColor clearColor]];
    [button addSubview:title];
    [self addSubview:button];

   
}

- (void)diaryLoadedcnt:(int)cnt totalCnt:(int)totalCnt
{
    if (!isFinished) {
        _totalCnt = totalCnt;
        _cnt = cnt;
       
        if (_cnt >_totalCnt) {
            _cnt = _totalCnt;
        }
        if (!timer) {
           
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshProgress) userInfo:nil repeats:YES];
        }
        if (cnt == totalCnt) {
            [timer invalidate];
            timer =nil;
            [self finished];
        }
        

    }
    
}

- (void)setIsDiary:(BOOL)isDiary
{
    _isDiary = isDiary;
    if (_isDiary) {
        [bg_progress setBackgroundColor:PMColor7];
        [bg_view setBackgroundColor:PMColor6];
        [title setTextColor:[UIColor whiteColor]];
        [title setText:@"正在下载同步您的日记...... "];
    }else{
        [bg_progress setBackgroundColor:RGBColor(239, 84, 77)];
        [bg_view setBackgroundColor:RGBColor(239, 128, 123)];
        [title setTextColor:[UIColor whiteColor]];
        [title setText:@"正在导入照片...... "];
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

}



- (void)finished
{
    isFinished = YES;
    if (progress.contentOffset.x  >0) {
        if (_isDiary) {
            [title setText:@"日记下载完成！点击产看查看下吧~"];
        }else{
            [title setText:@"图片导入完成！点击产看查看下吧~"];
        }
        [button setEnabled:YES];
        [UIView animateWithDuration:0.5 animations:^{
            progress.contentOffset = CGPointMake(0, 0);
        }];
    }
   
}

- (void)scan:(UIButton *)sender
{
     [button setEnabled:NO];
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
- (void)reset
{
    isFinished = NO;
    if (_isDiary) {
        [title setText:@"正在下载同步您的日记...... "];
    }else{
        [title setText:@"正在导入照片...... "];
    }
}
@end
