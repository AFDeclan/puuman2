//
//  AuPhotoDiaryCell.m
//  puman
//
//  Created by Declan on 13-12-28.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "AuPhotoDiaryCell.h"
#import "UniverseConstant.h"
#import "DiaryFileManager.h"
#import "DetailShowViewController.h"
#import "UIImage+CroppedImage.h"
#import "DiaryViewController.h"
#import "ShareSelectedViewController.h"
#import "DiaryImageView.h"

@implementation AuPhotoDiaryCell

@synthesize reuseIdentifier = _reuseIdentifier;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //在这里初始化控件（可重用的部分）
        [MyNotiCenter addObserver:self selector:@selector(stopPlayAudio) name:Noti_PauseMultiMedia object:nil];
        
        _photoView = [[DiaryImageView alloc] initWithFrame:CGRectMake(56, 24, 416, 416)];
        [_content addSubview:_photoView];
        
        UITapGestureRecognizer *tapPhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPhoto)];
        [_photoView addGestureRecognizer:tapPhoto];
        [_photoView setBackgroundColor:[UIColor clearColor]];
        _photoView.userInteractionEnabled = YES;
        
        playBtn = [[NewAudioPlayView alloc] initWithFrame:CGRectMake(216, 392, 96, 96)];
        [playBtn setDelegate:self];
        [_content addSubview:playBtn];
      
      

        
        titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 416, 80)];
        [titleView setImage:[UIImage imageNamed:@"bg_title2_diary.png"]];
        [titleView setBackgroundColor:[UIColor clearColor]];
        [_photoView addSubview:titleView];
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
    
    [_shareBtn setAlpha:1];
    titleLabel.text = [self.diaryInfo valueForKey:kTitleName];
    if ([[self.diaryInfo valueForKey:kTitleName] isEqualToString:@""]) {
        [titleView setAlpha:0];
    }else{
        [titleView setAlpha:1];
    }
    //在这里调整控件坐标，填充内容
    [_photoView setImage:[UIImage imageNamed:@"pic_default_diary.png"]];
    [_photoView reset];
     _content.frame = CGRectMake(112,kHeaderHeight,ContentWidth,488);
    
    NSString *filePath = [self.diaryInfo valueForKey:kFilePath2Name];
    [playBtn setPlayFile:[NSURL fileURLWithPath:filePath]];

    [super buildCellViewWithIndexRow:index abbreviated:abbr];

}

- (void)stopPlayAudio
{
    [playBtn stopPlay];
}

- (void)stopPlay
{

}

- (void)startPlay
{

}

- (void)loadInfo
{
    [super loadInfo];
    [_photoView setCropSize:CGSizeMake(416*2, 416*2)];
    [_photoView loadThumbImgWithPath:[self.diaryInfo valueForKey:kFilePathName]];
    
}


- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}

- (void)share:(id)sender
{    
    //子类重载
    NSString *text = @"";
    UIImage *img;
    NSString *path = [self.diaryInfo valueForKey:kFilePathName];
    img = [DiaryFileManager imageForPath:path];
    NSString *title = [self.diaryInfo valueForKey:kTitleName];
    [ShareSelectedViewController shareText:text title:title image:img];
    
}

- (void)showPhoto
{
    [DetailShowViewController showPhotoPath:[self.diaryInfo valueForKey:kFilePathName] andTitle:titleLabel.text];

}

- (void)prepareForReuse
{
    [super prepareForReuse];
    //去除临时控件，准备重用
}

+ (CGFloat)heightForDiary:(NSDictionary *)diaryInfo abbreviated:(BOOL)abbr
{
    //计算高度
    return 488;
}


@end
