//
//  DiaryNewButton.m
//  puman
//
//  Created by 祁文龙 on 13-12-25.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "DiaryNewButton.h"
#import "DiaryViewController.h"
#import "MainTabBarController.h"

@implementation DiaryNewButton
@synthesize commonBtnType =_commonBtnType;
@synthesize newBtnShowed = _newBtnShowed;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _commonBtnType = CameraDiary;
        _newBtnShowed = YES;
        perVertical= ![MainTabBarController sharedMainViewController].isVertical;
        // Initialization code
        [self initialization];
    }
    return self;
}
- (void)initialization
{
    bgCommon = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 56, 62)];
    bgCommon.contentSize = CGSizeMake(56, 123);
    [bgCommon setBackgroundColor:[UIColor clearColor]];
    [bgCommon setScrollEnabled:NO];
    [bgCommon setShowsHorizontalScrollIndicator:NO];
    [bgCommon setShowsVerticalScrollIndicator:NO];
    [self addSubview:bgCommon];
    newBtn =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 56, 88)];
    [newBtn setImage:[UIImage imageNamed:@"btn_more_diary.png"] forState:UIControlStateNormal];
    [newBtn addTarget:self action:@selector(hideOrShowBtns) forControlEvents:UIControlEventTouchUpInside];
    [bgCommon addSubview:newBtn];
  
    commonBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 33, 55, 55)];
    [commonBtn addTarget:self action:@selector(addDiary) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:commonBtn];

}
- (void)setCommonBtnType:(NewButtonType)commonBtnType
{
    switch (commonBtnType) {
        case AudioDiary:
            [commonBtn setImage:[UIImage imageNamed:@"btn2_audio_diary.png"] forState:UIControlStateNormal];
            break;
        case TextDiary:
            [commonBtn setImage:[UIImage imageNamed:@"btn2_text_diary.png"] forState:UIControlStateNormal];
            break;
        case ImportDiary:
            [commonBtn setImage:[UIImage imageNamed:@"btn2_input_diary.png"] forState:UIControlStateNormal];
            break;
        case CameraDiary:
            [commonBtn setImage:[UIImage imageNamed:@"btn2_camera_diary.png"] forState:UIControlStateNormal];
            break;
        case VideoDiary:
             [commonBtn setImage:[UIImage imageNamed:@"btn2_video_diary.png"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    _commonBtnType = commonBtnType;
}
- (void)hideOrShowBtns
{
    if (_newBtnShowed) {
        [self hiddenBtns];
    }else{
        [self showBtns];
    }
}
- (void)showBtns
{
    if (!_newBtnShowed) {
        
        CGRect frame = newBtn.frame;
//        frame.origin.y = 0;
//        [newBtn setFrame:frame];
        frame.origin.y = 35;
         [newBtn setAlpha:1];
        [newBtn setEnabled:NO];
       
        [[DiaryViewController sharedDiaryViewController] showNewDiaryBtns];
        [UIView animateWithDuration:0.5 animations:^{
            newBtn.frame = frame;
            newBtn.alpha = 0;
        }completion:^(BOOL finished) {
            [newBtn setEnabled:YES];
            
        }];
        _newBtnShowed = YES;
    }
    

}
- (void)hiddenBtns
{
    
    if (_newBtnShowed) {
        CGRect frame = newBtn.frame;
//        frame.origin.y = 35;
//        [newBtn setFrame:frame];
        frame.origin.y = 0;
        [newBtn setEnabled:NO];
        [newBtn setAlpha:0];
        [[DiaryViewController sharedDiaryViewController] hideNewDiaryBtns];
        [UIView animateWithDuration:0.5 animations:^{
            newBtn.frame = frame;
            newBtn.alpha = 1;
        }completion:^(BOOL finished) {
            [newBtn setEnabled:YES];
            
        }];
        _newBtnShowed = NO;
    }
   
}
- (void)addDiary
{
    [[DiaryViewController sharedDiaryViewController] showNewDiaryViewWithType:_commonBtnType withTaskInfo:nil];

}
- (BOOL)directionChangedWithVertical:(BOOL)vertical;
{
    BOOL changed;
    if ((vertical && perVertical)||(vertical == NO &&perVertical == NO)) {
       changed = NO;
    }else{
        changed = YES;
    }
    
    perVertical = vertical;
    return changed;
}
- (void)setShowStatus
{
    
    CGRect frame = newBtn.frame;
    frame.origin.y = 35;
    [newBtn setFrame:frame];
    [newBtn setAlpha:0];
}

- (void)setHideStatus
{
    
    CGRect frame = newBtn.frame;
    frame.origin.y = 0;
    [newBtn setFrame:frame];
    [newBtn setAlpha:1];
}


@end
