//
//  PhotoMoreDiaryCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-11.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PhotoMoreDiaryCell.h"
#import "DiaryFileManager.h"
#import "UIImage+CroppedImage.h"
#import "DetailShowViewController.h"
#import "UIImage+Scale.h"

@implementation PhotoMoreDiaryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, ContentWidth, 24)];
        [titleLabel setFont:PMFont1];
        [titleLabel setTextColor:PMColor1];
        [_content addSubview:titleLabel];
        [titleLabel setAlpha:0];
       
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(56, 24, 416, 192)];
        [_scrollView setDelegate:self];
        [_scrollView setPagingEnabled:YES];
        [_content addSubview:_scrollView];
        UITapGestureRecognizer *gestureRecognizer= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
        [_scrollView addGestureRecognizer:gestureRecognizer];
       
    }
    return self;
}

- (void)buildCellViewWithIndexRow:(NSUInteger)index abbreviated:(BOOL)abbr
{
    [_shareBtn setAlpha:1];
    float height = 0;
    titleLabel.text = [self.diaryInfo valueForKey:kTitleName];
    if ([[self.diaryInfo valueForKey:kTitleName] isEqualToString:@""]) {
        [titleLabel setAlpha:0];
    }else{
        height += 40;
        [titleLabel setAlpha:1];
    }
    height +=24;
    SetViewLeftUp(_showColumnView, 56, height);
    height +=192;
    selectedIndex = 1;
    _photoPaths = [NSArray arrayWithObjects:@"pic_default_diary.png",@"pic_default_diary.png",@"pic_default_diary.png", nil];
    if (_showColumnView) {
        [_showColumnView removeFromSuperview];
    }
    _showColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(56, 24, 416, 192)];
    [_showColumnView setBackgroundColor:[UIColor clearColor]];
    [_showColumnView setViewDelegate:self];
    [_showColumnView setViewDataSource:self];
    [_showColumnView setPagingEnabled:NO];
    [_showColumnView setScrollEnabled:NO];
    [_content addSubview:_showColumnView];
    [_content bringSubviewToFront:_scrollView];
    _content.frame = CGRectMake(112,kHeaderHeight,ContentWidth,height);
    [super buildCellViewWithIndexRow:index abbreviated:abbr];
}

- (void)loadInfo
{
    [super loadInfo];
    
    NSString *photoPathsString = [self.diaryInfo objectForKey:kFilePathName];
    _photoPaths = [photoPathsString componentsSeparatedByString:@"#@#"];
    [_scrollView setContentSize:CGSizeMake( [_photoPaths count]*416, 192)];
    if ([_photoPaths count] >1) {
        [_showColumnView reloadData];
    }

}

#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
    if (index == selectedIndex ) {
        [self showPhotoAtIndex:index];
    }
   

}

- (void)tapped
{
    float x = _scrollView.contentOffset.x;
    int index =x/416;
    [self showPhotoAtIndex:index+1];

}

- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{

    if (index == 0 || index == [_photoPaths count]+1)  {
        return 100;
    }else{
        return 200;
    }
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    
    return [_photoPaths count]+2;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        CGPoint pos= _scrollView.contentOffset;
        float nowX = pos.x/416;
        float indexX = (int)(pos.x/416);
        selectedIndex = pos.x/416 +1;
        [[[_showColumnView cellForIndex:selectedIndex] viewWithTag:12] setAlpha:(nowX-indexX)*0.5];
        [[[_showColumnView cellForIndex:selectedIndex+1] viewWithTag:12] setAlpha:0.5-(nowX-indexX)*0.5];
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

- (void)scrollViewDidEndDecelerating:(UIColumnView *)scrollView
{

}

- (void)scrollViewDidEndDragging:(UIColumnView *)scrollView willDecelerate:(BOOL)decelerate;
{

}
- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    if (index == 0 || index == [_photoPaths count]+1) {
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
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 0, 192, 192)];
            imgView.tag = 11;
            [cell.contentView addSubview:imgView];
            UIImageView *mask = [[UIImageView alloc] initWithFrame:CGRectMake(4, 0, 192, 192)];
            mask.tag = 12;
            [cell.contentView addSubview:mask];
        }
  
        
        
        UIImage *photo = [DiaryFileManager imageForPath:[_photoPaths objectAtIndex:index-1]];
       // photo = [UIImage croppedImage:photo WithHeight:384 andWidth:384];
        if (!photo) {
            photo = [UIImage imageNamed:[_photoPaths objectAtIndex:index-1]];
        }
        UIImageView *photoView = (UIImageView *)[cell viewWithTag:11];
        [photoView setImage:photo];

        UIImageView *mask = (UIImageView *)[cell viewWithTag:12];
        [mask setBackgroundColor:[UIColor whiteColor]];

        if (selectedIndex == index) {
            [mask setAlpha:0];
        }else{
            [mask setAlpha:0.5];
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;

    }
}

- (void)showPhotoAtIndex:(NSInteger)index
{

    [DetailShowViewController showPhotosPath:_photoPaths atIndex:index-1];
    
}

- (void)share:(id)sender
{
    NSString *text;
    UIImage *img;
    
    for (NSString *photoPath in _photoPaths)
    {
        UIImage *photo = [DiaryFileManager imageForPath:photoPath];
        if (photo != nil){
            photo = [photo scaleToWidth:768];
            img = [img addImage:photo];
        }
    }
    NSString *title = [self.diaryInfo valueForKey:kTitleName];
    [ShareSelectedViewController shareText:text title:title image:img];
}

+ (CGFloat)heightForDiary:(NSDictionary *)diaryInfo abbreviated:(BOOL)abbr;
{
    
    CGFloat height = 216;
    if (![[diaryInfo valueForKey:kTitleName] isEqualToString:@""])
        height += 40;
    //计算高度
    return height;
}

@end
