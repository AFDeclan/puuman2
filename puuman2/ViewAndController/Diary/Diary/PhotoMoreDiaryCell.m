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
        _showColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(56, 24, 416, 192)];
        [_showColumnView setBackgroundColor:[UIColor clearColor]];
        [_showColumnView setViewDelegate:self];
        [_showColumnView setViewDataSource:self];
        [_showColumnView setPagingEnabled:NO];
        [_content addSubview:_showColumnView];

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
    NSString *photoPathsString = [self.diaryInfo objectForKey:kFilePathName];
    _photoPaths = [photoPathsString componentsSeparatedByString:@"#@#"];
    if ([_photoPaths count] >1) {
          [_showColumnView reloadData];
    }
  
    _content.frame = CGRectMake(112,kHeaderHeight,ContentWidth,height);
    [super buildCellViewWithIndexRow:index abbreviated:abbr];
}


#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
    if (index == selectedIndex ) {
        [self showPhotoAtIndex:index];
    }
   

}

- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{

    if (index == 0 || index == [_photoPaths count]+1)  {
        return 96;
    }else{
        return 192;
    }
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    
    return [_photoPaths count]+2;
    
}

- (void)scrollViewDidScroll:(UIColumnView *)scrollView
{
   
    float x = scrollView.contentOffset.x;
    int index =2+ (x-96)/192;
    [[[scrollView cellForIndex:selectedIndex] viewWithTag:12] setAlpha:0.5];
    selectedIndex = index;
    [[[scrollView cellForIndex:selectedIndex] viewWithTag:12] setAlpha:0];
    
}

- (void)scrollViewDidEndDecelerating:(UIColumnView *)scrollView
{

    [scrollView setContentOffset:CGPointMake((selectedIndex-1)*192 , 0) animated:YES];
}

- (void)scrollViewDidEndDragging:(UIColumnView *)scrollView willDecelerate:(BOOL)decelerate;
{
    [scrollView setContentOffset:CGPointMake((selectedIndex-1)*192 , 0) animated:YES];
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
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 192, 192)];
            imgView.tag = 11;
            [cell.contentView addSubview:imgView];
            UIImageView *mask = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 192, 192)];
            mask.tag = 12;
            [cell.contentView addSubview:mask];
        }
        UIImage *photo = [DiaryFileManager imageForPath:[_photoPaths objectAtIndex:index-1]];
       // photo = [UIImage croppedImage:photo WithHeight:384 andWidth:384];
        UIImageView *photoView = (UIImageView *)[cell viewWithTag:11];
        [photoView setImage:photo];
        
        UIImageView *mask = (UIImageView *)[cell viewWithTag:12];
        [mask setBackgroundColor:[UIColor whiteColor]];
        
        if (selectedIndex == index) {
            [mask setAlpha:0];
        }else{
            [mask setAlpha:0.5];
        }
        return cell;

    }
}

- (void)showPhotoAtIndex:(NSInteger)index
{

    [DetailShowViewController showPhotosPath:_photoPaths atIndex:index-1];
    
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
