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
#import "AFImageView.h"


@implementation PhotoTopicCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       

    }
    return self;
}

- (void)buildWithReply:(Reply *)reply
{
    
    _photoPaths = [reply photoUrls];
    if (_showColumnView) {
        [_showColumnView removeFromSuperview];
    }
    _showColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(56, 0, 536, 112)];
    [_showColumnView setBackgroundColor:[UIColor clearColor]];
    [_showColumnView setViewDelegate:self];
    [_showColumnView setViewDataSource:self];
    [_showColumnView setPagingEnabled:NO];
    [_showColumnView setScrollEnabled:YES];
    [contentView addSubview:_showColumnView];
  
    CGRect frame = contentView.frame;
    frame.size.height =128;
    
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
    
    return 128;
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    
    return [_photoPaths count];
    
}


- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
        NSString * cellIdentifier = @"photoTopicShowColumnCell";
        UITableViewCell *cell = [columnView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            AFImageView *imgView = [[AFImageView alloc] initWithFrame:CGRectMake(0, 0, 112, 112)];
            imgView.tag = 11;
            [cell.contentView addSubview:imgView];
        }
    
   

        AFImageView *photoView = (AFImageView *)[cell viewWithTag:11];
        [photoView setImage:[DiaryFileManager thumbImageForPath:[_photoPaths objectAtIndex:index]]];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
        
    
}

- (void)showPhotoAtIndex:(NSInteger)index
{
    
    [DetailShowViewController showPhotosPath:_photoPaths atIndex:index-1];
    
}


+ (CGFloat)heightForReply:(Reply *)reply andIsMyTopic:(BOOL)isMytopic andTopicType:(TopicType)type;
{
 
    return 128;
    
}

@end
