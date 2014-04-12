//
//  VideoDiaryCell.m
//  puman
//
//  Created by Declan on 13-12-28.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "VideoDiaryCell.h"
#import "MainTabBarController.h"
#import "DiaryFileManager.h"
#import "Device.h"
#import "DetailShowViewController.h"
#import "UniverseConstant.h"
#import "UIImage+CroppedImage.h"
#import "UIImageView+AnimateFade.h"


@implementation VideoDiaryCell

@synthesize reuseIdentifier = _reuseIdentifier;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //在这里初始化控件（可重用的部分）
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(56, 24, 416, 416)];
        [_imgView setBackgroundColor:[UIColor clearColor]];
        _imgView.userInteractionEnabled = YES;
        [_content addSubview:_imgView];
        
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.frame = CGRectMake(216, 184, 96, 96);
        [_playBtn setImage:[UIImage imageNamed:@"btn_play_diary.png"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
        [_content addSubview:_playBtn];
        
        titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 416, 80)];
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

- (void)buildCellViewWithIndexRow:(NSUInteger)index abbreviated:(BOOL)abbr
{
    titleLabel.text = [self.diaryInfo valueForKey:kTitleName];
    if ([[self.diaryInfo valueForKey:kTitleName] isEqualToString:@""]) {
        [titleView setAlpha:0];
    }else{
        [titleView setAlpha:1];
    }
    [_shareBtn setAlpha:0];
    [_imgView setImage:[UIImage imageNamed:@"pic_default_diary.png"]];
    _content.frame = CGRectMake(112,kHeaderHeight,ContentWidth,440);
    [super buildCellViewWithIndexRow:index abbreviated:abbr];
    //在这里调整控件坐标，填充内容
}

- (void)loadInfo
{
    [super loadInfo];
    UIImage *image = [DiaryFileManager imageForVideo:[self.diaryInfo valueForKey:kFilePathName]];
    image  = [UIImage croppedImage:image WithHeight:832 andWidth:832];
    [_imgView fadeToImage:image];
}

- (void)playVideo
{
   [DetailShowViewController showVideo:[self.diaryInfo valueForKey:kFilePathName]];
}

- (void)share:(id)sender
{
    //子类重载
    
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    //去除临时控件，准备重用
}

+ (CGFloat)heightForDiary:(NSDictionary *)diaryInfo abbreviated:(BOOL)abbr 
{
    return 440;
}

@end
