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
//#import "CustomAlertView.h"
//#import "DetailsShowView.h"
#import "UIImage+CroppedImage.h"
#import "DiaryViewController.h"

@implementation AuPhotoDiaryCell

@synthesize reuseIdentifier = _reuseIdentifier;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //在这里初始化控件（可重用的部分）
        [MyNotiCenter addObserver:self selector:@selector(stopCircleAudio) name:Noti_PauseMultiMedia object:nil];
        
        _photoView = [[UIImageView alloc] initWithFrame:CGRectMake(56, 24, 416, 416)];
        [_content addSubview:_photoView];
        UITapGestureRecognizer *tapPhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPhoto)];
        [_photoView addGestureRecognizer:tapPhoto];
        [_photoView setBackgroundColor:[UIColor clearColor]];
        _photoView.userInteractionEnabled = YES;
        
        UIImageView *bgBtnView = [[UIImageView alloc] initWithFrame:CGRectMake(216, 392, 96, 96)];
        [_content addSubview:bgBtnView];
        [bgBtnView setImage:[UIImage imageNamed:@"circle_audio_diary.png"]];
        
        _playStopBtn = [[UIButton alloc] initWithFrame:bgBtnView.frame];
        [_playStopBtn setImage:[UIImage imageNamed:@"btn_play3_diary.png"] forState:UIControlStateNormal];
        [_playStopBtn addTarget:self action:@selector(playStopCircleAudio) forControlEvents:UIControlEventTouchUpInside];
        _circleProgress = [[CircleProgress alloc] initWithFrame:_playStopBtn.frame];
        [_circleProgress setTrackTintColor:PMColor7];
        [_circleProgress setProgressTintColor:PMColor6];
        [_circleProgress setProgress:0];
        [_content addSubview:_circleProgress];
        [_content addSubview:_playStopBtn];
      

        
        titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 416, 80)];
        [titleView setImage:[UIImage imageNamed:@"block_photo_diary.png"]];
        [titleView setBackgroundColor:[UIColor clearColor]];
        [_content bringSubviewToFront:titleView];
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 416, 80)];
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
    //在这里调整控件坐标，填充内容
    photo = [DiaryFileManager thumbImageForPath:[self.diaryInfo valueForKey:kFilePathName]];
    photo = [UIImage croppedImage:photo WithHeight:592 andWidth:640];
    [_photoView setImage:photo];
    
    NSString *filePath = [self.diaryInfo valueForKey:kFilePath2Name];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filePath] error:nil];
    [_audioPlayer prepareToPlay];
    [_audioPlayer setDelegate:self];
     _content.frame = CGRectMake(0,0,ContentWidth,488);
    [super buildCellViewWithIndexRow:index abbreviated:abbr];

   
}
- (void)playStopCircleAudio
{
    [_circleProgress setProgress:0];
    if (_audioPlayer == nil) return;
    if ([_audioPlayer isPlaying])    //停止播放
    {
        [self stopCircleAudio];
    }
    else    //开始或继续播放
    {
        [_audioPlayer play];
        NSTimeInterval interval = [_audioPlayer duration] / 100;
        if (interval < 0.05) interval = 0.05;
        if (interval > 1) interval = 1;
        _timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(updateCircleAudioProgress) userInfo:nil repeats:YES];
        [_playStopBtn setImage:[UIImage imageNamed:@"btn_stop2_diary.png"] forState:UIControlStateNormal];
    }
}
- (void)stopCircleAudio
{
    [_audioPlayer stop];
    [_audioPlayer setCurrentTime:0];
    [self updateCircleAudioProgress];
    [_timer invalidate];
    _timer = nil;
    [_playStopBtn setImage:[UIImage imageNamed:@"btn_play3_diary.png"] forState:UIControlStateNormal];
}

- (void)updateCircleAudioProgress
{
    //progressView
    [_circleProgress setProgress:[_audioPlayer currentTime] / [_audioPlayer duration]];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [_audioPlayer setCurrentTime:0];
    [_circleProgress setProgress:0 ];
    [_timer invalidate];
    _timer = nil;
    [_playStopBtn setImage:[UIImage imageNamed:@"btn_play3_diary.png"] forState:UIControlStateNormal];
}

- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}

- (void)share:(id)sender
{
//    //子类重载
//    NSString *text;
//    NSString *title = [self.diaryInfo valueForKey:kTitleName];
//    [[DiaryViewController sharedDiaryViewController] shareDiaryWithText:text title:title image:photo];
   // [CustomAlertView sharedInView:nil content:@"分享本条日记到......？" shareText:text title:title image:photo];
    
}

- (void)showPhoto
{
    
 // [DetailsShowView showPhoto:photo];
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
