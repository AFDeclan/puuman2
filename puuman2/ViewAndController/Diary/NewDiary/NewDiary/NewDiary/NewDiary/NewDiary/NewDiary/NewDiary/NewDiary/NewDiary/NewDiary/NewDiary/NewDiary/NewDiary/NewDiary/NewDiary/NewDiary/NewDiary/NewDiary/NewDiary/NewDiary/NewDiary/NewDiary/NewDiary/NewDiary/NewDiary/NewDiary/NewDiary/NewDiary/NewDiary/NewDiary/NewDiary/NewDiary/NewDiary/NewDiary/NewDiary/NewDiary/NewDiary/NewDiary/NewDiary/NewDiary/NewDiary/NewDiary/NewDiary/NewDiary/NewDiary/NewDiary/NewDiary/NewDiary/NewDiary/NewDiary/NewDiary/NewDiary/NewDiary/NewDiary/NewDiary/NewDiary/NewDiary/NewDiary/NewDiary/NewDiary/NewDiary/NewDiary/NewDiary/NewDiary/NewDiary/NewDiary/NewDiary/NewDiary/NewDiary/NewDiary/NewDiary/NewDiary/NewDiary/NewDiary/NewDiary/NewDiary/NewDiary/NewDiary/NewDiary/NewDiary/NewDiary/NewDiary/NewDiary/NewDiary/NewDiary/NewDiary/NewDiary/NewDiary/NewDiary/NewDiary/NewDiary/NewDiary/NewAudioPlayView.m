//
//  NewAudioPlayView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "NewAudioPlayView.h"
#include "ColorsAndFonts.h"
#import "ErrorLog.h"

@implementation NewAudioPlayView
@synthesize delegate =_delegate;
@synthesize playFile = _playFile;
@synthesize maxTime = _maxTime;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
        
    }
    return self;
}

- (void)initialization
{

    playBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
    [playBg setImage:[UIImage imageNamed:@"btn_play_diary.png"]];
    [playBg setBackgroundColor:[UIColor clearColor]];
    [self addSubview:playBg];
    
    progress = [[NewAudioProgressView alloc] initWithFrame:playBg.frame];
    [self addSubview:progress];
    
    
    playBtn = [[UIButton alloc] initWithFrame:playBg.frame];
    [playBtn setBackgroundColor:[UIColor clearColor]];
    [playBtn addTarget:self action:@selector(playOrStop) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:playBtn];

    
}
- (void)setPlayFile:(NSURL *)playFile
{
    _playFile =playFile;
    if (playFile) {
        NSError *playerError;
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:playFile error:&playerError];
        if (player == nil)
        {
            
            [ErrorLog errorLog: @"Error creating player:" fromFile:@"NewAudioDiaryViewController.m" error:playerError];
            NSLog(@"Error creating player: %@", [playerError description]);
        }
        player.delegate = self;
        [progress setCurrentTime:0];
        [self setMaxTime:[player duration]];
       
    }else{
        if ([player isPlaying])
        {
            [self stopPlay];
            
        }
    }
   
}
- (void)setMaxTime:(NSTimeInterval)maxTime
{
    _maxTime = maxTime;
    [progress setMaxTime:maxTime];
}


- (void)playOrStop
{
    if ([player isPlaying])
    {
         [self stopPlay];
        
    }else{
       
        [self startPlay];
    }
    
}

- (void)startPlay
{
    [playBg setImage:[UIImage imageNamed:@"btn_stop_diary.png"]];
    [progress setCurrentTime:0];
    [player play];
    [_delegate startPlay];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(refreshProgress) userInfo:nil repeats:YES];
}


- (void)stopPlay
{
    [playBg setImage:[UIImage imageNamed:@"btn_play_diary.png"]];
    [progress setCurrentTime:0];
    [timer invalidate];
    timer = nil;
    [player stop];
    [player setCurrentTime:0];
    [_delegate stopPlay];
}

- (void)refreshProgress
{
    [progress setMaxTime:[player duration]];
    [progress setCurrentTime:[player currentTime]];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [progress setCurrentTime:0];
    [timer invalidate];
    timer = nil;
    [playBg setImage:[UIImage imageNamed:@"btn_play_diary.png"]];
    [_delegate stopPlay];
    
}

- (void)removePlay
{
    if ([player isPlaying]) {
        [timer invalidate];
         timer = nil;
        [player stop];
        _playFile = nil;
    }
}
@end
