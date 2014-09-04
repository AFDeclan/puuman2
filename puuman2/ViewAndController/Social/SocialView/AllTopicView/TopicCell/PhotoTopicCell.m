//
//  PhotoTopicCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PhotoTopicCell.h"
#import "DiaryFileManager.h"
#import "DetailShowViewController.h"
#import "DiaryFileManager.h"
#import "AsyncImgView.h"

@implementation PhotoTopicCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       

    }
    return self;
}

- (void)buildWithReply:(Reply *)reply
{
    selectedIndex = 1;

    _photoPaths = [reply photoUrls];
    if (_showColumnView) {
        [_showColumnView removeFromSuperview];
    }
    _showColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(112, 12, 416, 192)];
    [_showColumnView setBackgroundColor:[UIColor clearColor]];
    [_showColumnView setColumnViewDelegate:self];
    [_showColumnView setViewDataSource:self];
    [_showColumnView setPagingEnabled:NO];
    [_showColumnView setScrollEnabled:YES];
    [contentView addSubview:_showColumnView];
    
    if (_scrollView) {
        [_scrollView removeFromSuperview];
    }
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(112, 12, 416, 192)];
    [_scrollView setDelegate:self];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setContentSize:CGSizeMake( [_photoPaths count]*416, 192)];
    [contentView addSubview:_scrollView];
    
    UITapGestureRecognizer *gestureRecognizer= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
    [_scrollView addGestureRecognizer:gestureRecognizer];
    CGRect frame = contentView.frame;
    frame.size.height =216;
    [contentView setFrame:frame];
    [super buildWithReply:reply];
 

}

#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
    [self showPhotoAtIndex:index];
}

- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{
    
    if (index == 0 || index == [self numberOfColumnsInColumnView:_showColumnView]-1)  {
        return 100;
    }else{
        return 200;
    }
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    
    if (_photoPaths) {
        return [_photoPaths count]+2;
    } else {
        return 2;
    }
    
}


- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    if (index == 0 || index == [self numberOfColumnsInColumnView:columnView]-1) {
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
        NSString * cellIdentifier = @"photoTopicShowColumnCell";
        UITableViewCell *cell = [columnView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            AsyncImgView *imgView = [[AsyncImgView alloc] initWithFrame:CGRectMake(4, 0, 192, 192)];
            [imgView setContentMode:UIViewContentModeScaleAspectFill];
            UIImage *photo = [UIImage imageNamed:@"pic_default_diary.png"];
            [imgView setImage:photo];
            imgView.tag = 11;
            imgView.layer.masksToBounds = YES;
            [cell.contentView addSubview:imgView];
            UIImageView *mask = [[UIImageView alloc] initWithFrame:CGRectMake(4, 0, 192, 192)];
            mask.tag = 12;
            [cell.contentView addSubview:mask];
        }
        
        AsyncImgView *photoView = (AsyncImgView *)[cell viewWithTag:11];
        UIImage *photo = [UIImage imageNamed:@"pic_default_diary.png"];
        [photoView setImage:photo];
        if (_photoPaths) {
            [photoView loadImgWithUrl:[_photoPaths objectAtIndex:index-1]];
        }
        [photoView setContentMode:UIViewContentModeScaleAspectFit];
        
        UIImageView *mask = (UIImageView *)[cell viewWithTag:12];
        [mask setBackgroundColor:[UIColor whiteColor]];
        
        if (selectedIndex == index) {
            [mask setAlpha:0];
        }else{
            [mask setAlpha:0.7];
        }
        
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;

    }
}

- (void)tapped
{
    float x = _scrollView.contentOffset.x;
    int index =x/416;
    [self showPhotoAtIndex:index];
}

- (void)showPhotoAtIndex:(NSInteger)index
{
    [DetailShowViewController showPhotosPath:_photoPaths atIndex:index andTitle:_reply.RTitle];
}

- (void)dealloc
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        CGPoint pos= _scrollView.contentOffset;
        float nowX = pos.x/416;
        float indexX = (int)(pos.x/416);
        selectedIndex = pos.x/416 +1;
        [[[_showColumnView cellForIndex:selectedIndex] viewWithTag:12] setAlpha:(nowX-indexX)*0.7];
        [[[_showColumnView cellForIndex:selectedIndex+1] viewWithTag:12] setAlpha:0.7-(nowX-indexX)*0.7];
        pos.x = pos.x*200/416;
        [_showColumnView setContentOffset:pos];
        if (selectedIndex == 0) {
            [[[_showColumnView cellForIndex:selectedIndex+1] viewWithTag:12] setAlpha:0];
        }
        if (selectedIndex == [_photoPaths count]) {
            [[[_showColumnView cellForIndex:selectedIndex] viewWithTag:12] setAlpha:0];
        }
        
    }
    
    
}


+ (CGFloat)heightForReply:(Reply *)reply andIsMyTopic:(BOOL)isMytopic andTopicType:(TopicType)type;
{
    return 216;
}

@end
