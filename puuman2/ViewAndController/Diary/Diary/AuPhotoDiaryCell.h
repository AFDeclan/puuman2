//
//  AuPhotoDiaryCell.h
//  puman
//
//  Created by Declan on 13-12-28.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "DiaryCell.h"
#import <AVFoundation/AVFoundation.h>
#import "CircleProgress.h"

@interface AuPhotoDiaryCell : DiaryCell <AVAudioPlayerDelegate>
{
    NSTimer *_timer;
    AVAudioPlayer* _audioPlayer;
    UIImageView *_photoView;
    CircleProgress *_circleProgress;
    UIButton *_playStopBtn;
    UIImage *photo;
    UIImageView *titleView;
    UILabel *titleLabel;
}

@end
