//
//  PhotoSingleDiaryCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-11.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PhotoSingleDiaryCell.h"
#import "DiaryFileManager.h"
#import "UIImage+CroppedImage.h"
#import "DetailShowViewController.h"
#import "UIImageView+AnimateFade.h"

@implementation PhotoSingleDiaryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        _imgView = [[DiaryImageView alloc] initWithFrame:CGRectMake(56, 24, 416, 416)];
        [_imgView setBackgroundColor:[UIColor clearColor]];
        _imgView.userInteractionEnabled = YES;
        [_content addSubview:_imgView];
        
        UITapGestureRecognizer *tapPhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPhoto)];
        [_imgView addGestureRecognizer:tapPhoto];
        titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 416-80, 416, 80)];
        [titleView setImage:[UIImage imageNamed:@"bg_title_diary.png"]];
        [titleView setBackgroundColor:[UIColor clearColor]];
        [_imgView addSubview:titleView];
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 80)];
        [titleLabel setTextAlignment:NSTextAlignmentRight];
        [titleLabel setFont:PMFont1];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleView addSubview:titleLabel];
        [titleView setAlpha:0];
    }
    return self;
}

- (void)showPhoto
{
    if (_photoPath) {
        [DetailShowViewController showPhotoPath:_photoPath];
     }
    
}

- (void)buildCellViewWithIndexRow:(NSUInteger)index abbreviated:(BOOL)abbr
{
    [_shareBtn setAlpha:1];
    titleLabel.text = [self.diaryInfo valueForKey:kTitleName];
    if ([[self.diaryInfo valueForKey:kTitleName] isEqualToString:@""]) {
        [titleView setAlpha:0];
    }else{
        [titleView setAlpha:1];
    }
    [_imgView setImage:[UIImage imageNamed:@"pic_default_diary.png"]];
    [_imgView reset];
    _content.frame = CGRectMake(112, kHeaderHeight, ContentWidth, 440);
    [super buildCellViewWithIndexRow:index abbreviated:abbr];
}

- (void)loadInfo
{
    [super loadInfo];
    if (_photoPath) return;
    NSString *photoPathsString = [self.diaryInfo objectForKey:kFilePathName];
    NSArray  *photoPaths = [photoPathsString componentsSeparatedByString:@"#@#"];
    for (NSString *photoPath in photoPaths)
    {
        _photoPath = photoPath;
        if (_photoPath != nil) {
            break;
        }
    }
    [_imgView setCropSize:CGSizeMake(832, 832)];
    [_imgView loadImgWithPath:_photoPath];
}

- (void)share:(id)sender
{
    NSString *text = @"";
    NSString *photoPathsString = [self.diaryInfo objectForKey:kFilePathName];
    NSArray  *photoPaths = [photoPathsString componentsSeparatedByString:@"#@#"];
    for (NSString *photoPath in photoPaths)
    {
        _photoPath = photoPath;
        
        if (_photoPath != nil) {
            break;
        }
    }
    UIImage *photo = [DiaryFileManager imageForPath:_photoPath];
    NSString *title = [self.diaryInfo valueForKey:kTitleName];
    [ShareSelectedViewController shareText:text title:title image:photo];

}

- (void)prepareForReuse
{
    [super prepareForReuse];
    _photoPath = nil;
}

+ (CGFloat)heightForDiary:(NSDictionary *)diaryInfo abbreviated:(BOOL)abbr;
{
    return 440;
}



@end
