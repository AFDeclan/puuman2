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
        UIImageView *triImgView = [[UIImageView alloc] initWithFrame:CGRectMake(48, 0, 1, 40)];
        triImgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_timeline_diary"]];
        [self addSubview:triImgView];
        [self initContentView];
        _isDiary = YES;
        isFinished = NO;
        
    }
    return self;
}


- (void)initContentView
{
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
    UIImageView *bgImg =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
    [bgImg setBackgroundColor:PMColor4];
    [_contentView addSubview:bgImg];
    button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 448, 32)];
    [button setAdjustsImageWhenDisabled:NO];
    [button setBackgroundColor:[UIColor clearColor]];
    [button addTarget:self action:@selector(scan:)  forControlEvents:UIControlEventTouchUpInside];
    [button setEnabled:NO];
    progress = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 448, 32)];
    [progress setScrollEnabled:NO];
    [_contentView addSubview:progress];
    [progress setContentSize:CGSizeMake(448*2, 32)];
    UIImageView *bg =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 448, 32)];
    [bg setBackgroundColor:RGBColor(159, 199, 225)];
    [progress setContentOffset:CGPointMake(448, 0)];
    [progress addSubview:bg];
    icon = [[UIImageView alloc] initWithFrame:CGRectMake(6, 6, 24, 24)];
    [icon setImage:[UIImage imageNamed:@"icon1_download_diary.png"]];
    [_contentView addSubview:icon];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(96, 10, 224, 12)];
    [title setTextColor:PMColor6];
    [title setFont:PMFont3];
    [title setBackgroundColor:[UIColor clearColor]];
    [_contentView addSubview:button];
    [self addSubview:_contentView];
   
}

- (void)diaryLoadedcnt:(int)cnt totalCnt:(int)totalCnt
{
    if (!isFinished) {
        _totalCnt = totalCnt;
        _cnt = cnt;
        NSTimeInterval time = 0;
        if (_isDiary) {
            time = 0.5;
        }else{
            time = 0.1;
        }
        
        
        if (!timer) {
           
            timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(refreshProgress) userInfo:nil repeats:YES];
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
        [title setText:@"正在下载您的日记...... "];
    }else{
        [title setText:@"正在导入照片...... "];
    }
}
- (void)refreshProgress
{
    CGPoint pos = progress.contentOffset;
    pos.x =448-448*_cnt/_totalCnt;
    [UIView animateWithDuration:0.5 animations:^{
        progress.contentOffset = pos;
    }];
}

-(void)setBgPointY:(float)pointY;
{

    [bgView setFrame:CGRectMake(0,pointY, 320, 48)];
    pointY = pointY+8>0?pointY+8:0;
    [button setFrame:CGRectMake(178, pointY, 448, 32)];
    
}

- (void)finished
{
    isFinished = YES;
    if (progress.contentOffset.x  >0) {
        [icon setImage:[UIImage imageNamed:@"icon2_download_diary.png"]];
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
    [icon setImage:[UIImage imageNamed:@"icon1_download_diary.png"]];
    if (_isDiary) {
        [title setText:@"正在下载您的日记...... "];
    }else{
        [title setText:@"正在导入照片...... "];
    }
}
@end
