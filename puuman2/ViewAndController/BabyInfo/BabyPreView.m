//
//  BabyPreView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-15.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyPreView.h"
#import "ColorsAndFonts.h"
#import "AFImageView.h"
#import "UniverseConstant.h"
#import "MainTabBarController.h"
#import "DateFormatter.h"
#import "NSDate+Compute.h"
#import "BabyData.h"

#define columnB @"http://appui.oss-cn-hangzhou.aliyuncs.com/%E5%AD%95%E6%9C%9F%E5%9B%BE%E7%89%87%EF%BC%88%E4%BA%A7%E6%A3%80%EF%BC%89/"
#define columnA @"http://appui.oss-cn-hangzhou.aliyuncs.com/%E5%AD%95%E6%9C%9F%E5%9B%BE%E7%89%87%EF%BC%88%E6%89%8B%E7%BB%98%EF%BC%89/"
static NSString *clonumAimages[40] = {@"1week%402x.jpg",@"2week%402x.jpg",@"3week%402x.jpg",@"4week%402x.jpg",@"5week%402x.jpg",@"6week%402x.jpg",@"7week%402x.jpg",@"8week%402x.jpg",@"9week%402x.jpg",@"10week%402x.jpg",@"11week%402x.jpg",@"12week%402x.jpg",@"13week%402x.jpg",@"14week%402x.jpg",@"15week%402x.jpg",@"16week%402x.jpg",@"17week%402x.jpg",@"18week%402x.jpg",@"19week%402x.jpg",@"20week%402x.jpg",@"21week%402x.jpg",@"22week%402x.jpg",@"23week%402x.jpg",@"24week%402x.jpg",@"25week%402x.jpg",@"26week%402x.jpg",@"27week%402x.jpg",@"28week%402x.jpg",@"29week%402x.jpg",@"30week%402x.jpg",@"31week%402x.jpg",@"32week%402x.jpg",@"33week%402x.jpg",@"34week%402x.jpg",@"35week%402x.jpg",@"36week%402x.jpg",@"37week%402x.jpg",@"38week%402x.jpg",@"39week%402x.jpg",@"40week%402x.jpg"};
static NSString *clonumBimages[40] = {@"1week-b%402x.PNG",@"2week-b%402x.PNG",@"3week-b%402x.PNG",@"4week-b%402x.PNG",@"5week-b%402x.PNG",@"6week-b%402x.PNG",@"7week-b%402x.PNG",@"8week-b%402x.PNG",@"9week-b%402x.PNG",@"10week-b%402x.PNG",@"11week-b%402x.PNG",@"12week-b%402x.PNG",@"13week-b%402x.PNG",@"14week-b%402x.PNG",@"15week-b%402x.PNG",@"16week-b%402x.PNG",@"17week-b%402x.PNG",@"18week-b%402x.PNG",@"19week-b%402x.PNG",@"20week-b%402x.PNG",@"21week-b%402x.PNG",@"22week-b%402x.PNG",@"23week-b%402x.PNG",@"24week-b%402x.PNG",@"25week-b%402x.PNG",@"26week-b%402x.PNG",@"27week-b%402x.PNG",@"28week-b%402x.PNG",@"29week-b%402x.PNG",@"30week-b%402x.PNG",@"31week-b%402x.PNG",@"32week-b%402x.PNG",@"33week-b%402x.PNG",@"34week-b%402x.PNG",@"35week-b%402x.PNG",@"36week-b%402x.PNG",@"37week-b%402x.PNG",@"38week-b%402x.PNG",@"39week-b%402x.PNG",@"40week-b%402x.PNG"};
#define  BABY_COLUMN_CNT   40

@implementation BabyPreView
@synthesize columnImgBMode = _columnImgBMode;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [showAndHiddenBtn setAlpha:0];
        [leftView setAlpha:0];
        [self initialization];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
    }
    return self;
}

- (void)initialization
{
      selectedIndex = 1;
    bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [bgScrollView setScrollEnabled:NO];
    [bgScrollView setContentSize:CGSizeMake(816, 576)];
    [rightView addSubview:bgScrollView];
    
    
    bgLine = [[UIView alloc] initWithFrame:CGRectMake(134, 476, 548, 1)];
    [bgLine setBackgroundColor:PMColor3];
    [bgScrollView addSubview:bgLine];
    _columnImgBMode = NO;
   
    
    
    _titles = [[UIScrollView alloc] initWithFrame:CGRectMake(74, 480, 688, 24)];
    [bgScrollView addSubview:_titles];
    
    _points = [[UIScrollView alloc] initWithFrame:CGRectMake(134, 474, 548, 4)];
    [_points setBackgroundColor:[UIColor clearColor]];
    [bgScrollView addSubview:_points];
    
    _controlView = [[UIScrollView alloc] initWithFrame:CGRectMake(24, 0, 816, 0)];
    [_controlView setDelegate:self];
    [_controlView setPagingEnabled:YES];
    [_controlView setBackgroundColor:[UIColor clearColor]];
    [_controlView setFrame:CGRectMake(0, 0, 816, 576)];
    [_controlView setContentSize:CGSizeMake( 40*816, 576)];

    [bgScrollView addSubview:_controlView];
    NSArray *ages = [[NSDate date] ageFromDate:[[BabyData sharedBabyData] babyBirth]];
    int age = 0;
    if ([ages count] == 2) {
    
        age = [[ages objectAtIndex:0] intValue];
        
    }
    for (int i = 0; i<BABY_COLUMN_CNT; i++) {
        UILabel *week = [[UILabel alloc]init];
        
        [week setTextAlignment:NSTextAlignmentCenter];
        [week setFont:PMFont2];
        [week setBackgroundColor:[UIColor clearColor]];
        [week setFrame:CGRectMake(i*272+272, 0, 120, 24)];
        [self setColumnLabel:week withIndex:i+1];
        [_titles addSubview:week];
        if (age >= i+1) {
            [week setTextColor:PMColor6];
        }else{
            [week setTextColor:PMColor2];
        }  
        
    }

    for (int i = 0; i<BABY_COLUMN_CNT; i++) {
        
        UIImageView *point = [[UIImageView alloc] initWithFrame:CGRectMake(i*272, 0, 4, 4)];
        [point setImage:[UIImage imageNamed:@"dot3_baby_diary.png"]];
        [_points addSubview:point];
        
        
    }

    UITapGestureRecognizer *gestureRecognizer= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
    [_controlView addGestureRecognizer:gestureRecognizer];
  
    
}

#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
//    if (index == selectedIndex ) {
//        [self showPhotoAtIndex:index];
//    }
    
    
}

- (void)tapped
{
//    float x = _scrollView.contentOffset.x;
//    int index =x/416;
//    [self showPhotoAtIndex:index+1];
    
}

- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{
    
    return 272;
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    
    return BABY_COLUMN_CNT+2;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView == _controlView) {
        CGPoint pos= _controlView.contentOffset;
        
        float nowX = pos.x/816;
        float indexX = (int)(pos.x/816);
        selectedIndex = pos.x/816 +1;
        [[[_showColumnView cellForIndex:selectedIndex] viewWithTag:12] setAlpha:(nowX-indexX)*0.5];
        [[[_showColumnView cellForIndex:selectedIndex+1] viewWithTag:12] setAlpha:0.5-(nowX-indexX)*0.5];
        SetViewLeftUp([[_showColumnView cellForIndex:selectedIndex] viewWithTag:11], 8, (nowX-indexX)*32);
        SetViewLeftUp([[_showColumnView cellForIndex:selectedIndex+1] viewWithTag:11], 8,32- (nowX-indexX)*32);
        SetViewLeftUp([[_showColumnView cellForIndex:selectedIndex] viewWithTag:12], 8, (nowX-indexX)*32);
        SetViewLeftUp([[_showColumnView cellForIndex:selectedIndex+1] viewWithTag:12], 8,32- (nowX-indexX)*32);
        pos.x = pos.x*272/816;
        [_showColumnView setContentOffset:pos];
        [_points setContentOffset:pos];
        [_titles setContentOffset:pos];
        if (selectedIndex == 0) {
            [[[_showColumnView cellForIndex:selectedIndex+1] viewWithTag:12] setAlpha:0];
     
            SetViewLeftUp([[_showColumnView cellForIndex:selectedIndex+1] viewWithTag:11], 8,0);
            SetViewLeftUp([[_showColumnView cellForIndex:selectedIndex+1] viewWithTag:12], 8,0);
        }
        if (selectedIndex == BABY_COLUMN_CNT) {
            [[[_showColumnView cellForIndex:selectedIndex] viewWithTag:12] setAlpha:0];
       
            SetViewLeftUp([[_showColumnView cellForIndex:selectedIndex+1] viewWithTag:11], 8,0);
            SetViewLeftUp([[_showColumnView cellForIndex:selectedIndex+1] viewWithTag:12], 8,0);
        }
        
    }
    
    
}

- (void)scrollViewDidEndDecelerating:(UIColumnView *)scrollView
{
    
}

- (void)scrollViewDidEndDragging:(UIColumnView *)scrollView willDecelerate:(BOOL)decelerate;
{
    
}
- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    if (index == 0 || index == BABY_COLUMN_CNT+1) {
        static NSString *identify = @"EmptyCell";
        UITableViewCell *cell = [columnView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
        
    }else{
        NSString * cellIdentifier = @"photoShowColumnCell";
        UITableViewCell *cell = [columnView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            AFImageView *imgView = [[AFImageView alloc] initWithFrame:CGRectMake(8, 32, 256, 296)];
             [imgView setImage:[UIImage imageNamed:@"pic_default_baby.png"]];
            imgView.tag = 11;
            [cell.contentView addSubview:imgView];
            UIImageView *mask = [[UIImageView alloc] initWithFrame:CGRectMake(8, 32, 256, 296)];
            mask.tag = 12;
            [cell.contentView addSubview:mask];
        }
        
        
        // photo = [UIImage croppedImage:photo WithHeight:384 andWidth:384];
        AFImageView *photoView = (AFImageView *)[cell viewWithTag:11];
        NSString *imageName = _columnImgBMode ? [NSString stringWithFormat:@"%@%@", columnB,clonumBimages[index -1]] : [NSString stringWithFormat:@"%@%@",columnA,clonumAimages[index-1]];
       
        [photoView getImage:imageName defaultImage:@"pic_default_baby.png"];
        UIImageView *mask = (UIImageView *)[cell viewWithTag:12];
        [mask setBackgroundColor:[UIColor whiteColor]];
        
        if (selectedIndex == index) {
            [mask setAlpha:0];
            SetViewLeftUp(photoView, 8, 0);
            SetViewLeftUp(mask, 8, 0);
        }else{
            [mask setAlpha:0.5];
            SetViewLeftUp(photoView, 8, 32);
            SetViewLeftUp(mask, 8, 32);
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
        
    }
}

- (void)refresh
{

    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
}

- (void)setColumnImgBMode:(BOOL)columnImgBMode
{
    _columnImgBMode = columnImgBMode;
    CGPoint pos = _controlView.contentOffset;
    [_controlView setContentOffset:CGPointZero];
    if (_showColumnView) {
        [_showColumnView removeFromSuperview];
    }
    _showColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(24, 88, 816, 328)];
    [_showColumnView setBackgroundColor:[UIColor clearColor]];
    [_showColumnView setColumnViewDelegate:self];
    [_showColumnView setViewDataSource:self];
    [_showColumnView setPagingEnabled:NO];
    [_showColumnView setScrollEnabled:NO];
    [bgScrollView addSubview:_showColumnView];
    [bgScrollView bringSubviewToFront:_controlView];
    [_controlView setContentOffset:pos];
}

- (void)scrollToToday
{
    NSArray *ages = [[NSDate date] ageFromDate:[[BabyData sharedBabyData] babyBirth]];
    int age = 1;
    if ([ages count] == 2) {
        age = [[ages objectAtIndex:0] intValue];
        
    }
    if (age > 3) {
        [_controlView setContentOffset:CGPointMake(816*(age-2), 0)];
    }
    
    
    [UIView animateWithDuration:0.5 animations:^{
        [_controlView setContentOffset:CGPointMake(816*(age-1), 0)];
    }];

}

-(void)setVerticalFrame
{
    [super setVerticalFrame];
    [bgScrollView setContentOffset:CGPointMake(128, 0)];
    [bgScrollView setFrame:CGRectMake(24, 128, 560, 576)];

}

-(void)setHorizontalFrame
{
    [super setHorizontalFrame];
    [bgScrollView setContentOffset:CGPointMake(0, 0)];

    [bgScrollView setFrame:CGRectMake(24, 0, 816, 576)];
    SetViewLeftUp(bgScrollView, 0, 0);
}

- (void)setColumnLabel:(UILabel *)label withIndex:(NSInteger)index
{
    if (index < 1 || index > BABY_COLUMN_CNT) label.text = @"";
    else label.text = [NSString stringWithFormat:@"孕期第%d周", index];
}

@end
