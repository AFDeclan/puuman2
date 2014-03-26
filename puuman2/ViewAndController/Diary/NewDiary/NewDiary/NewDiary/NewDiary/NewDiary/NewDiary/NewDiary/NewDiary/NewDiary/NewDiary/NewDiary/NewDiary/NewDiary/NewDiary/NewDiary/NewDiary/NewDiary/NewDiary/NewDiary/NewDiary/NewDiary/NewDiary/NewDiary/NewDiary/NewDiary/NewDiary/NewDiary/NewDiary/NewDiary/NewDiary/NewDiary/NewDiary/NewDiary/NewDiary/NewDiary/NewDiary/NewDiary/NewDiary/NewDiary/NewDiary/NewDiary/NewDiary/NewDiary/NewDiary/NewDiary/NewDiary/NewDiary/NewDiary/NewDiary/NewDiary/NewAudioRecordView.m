//
//  NewAudioRecordView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "NewAudioRecordView.h"
#import "ColorsAndFonts.h"
#import "ErrorLog.h"
const NSTimeInterval MAX_DURATION = 90;
@implementation NewAudioRecordView
@synthesize delegate =_delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
        [self setRecordSource];
    }
    return self;
}

- (void)initialization
{
    isRecording = NO;
    isRecorded = NO;
    

    recordBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 224, 224)];
    [recordBg setImage:[UIImage imageNamed:@"btn_record_diary.png"]];
    [recordBg setBackgroundColor:[UIColor clearColor]];
    [self addSubview:recordBg];
    
    progress = [[NewAudioProgressView alloc] initWithFrame:CGRectMake(0, 0, 224, 224)];
    [self addSubview:progress];
    [progress setMaxTime:MAX_DURATION];
    [progress setCurrentTime:0];
    
    recordBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 224, 224)];
    [recordBtn setBackgroundColor:[UIColor clearColor]];
    [recordBtn addTarget:self action:@selector(playStopOrReset) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:recordBtn];
     
}

- (void)setRecordSource
{
    recordedFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingString:@"RecordedFile.aac"]];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if(session == nil)
    {
        
        [ErrorLog errorLog:@"Error creating session" fromFile:@"NewAudioDiaryViewController.m" error:sessionError];
        NSLog(@"Error creating session: %@", [sessionError description]);
    }
    else
        [session setActive:YES error:nil];
   
}

- (void)refreshProgress
{
    if ([audioRecorder currentTime] >2) {
        [recordBtn setEnabled:YES];
    }
  
    [progress setCurrentTime:[audioRecorder currentTime]];
}

- (void)playStopOrReset
{
    if (isRecorded) {
        [self restartRecord];
    }else{
        if (isRecording) {
            [self stopRecord];
        }else{
            [self startRecord];
        }
    }
}

- (void)restartRecord
{
    if (audioRecorder)
    {
        audioRecorder = nil;
    }
    [progress setCurrentTime:0];
    isRecorded = NO;
    [_delegate restartRecord];
}

- (void)startRecord
{
    [recordBtn setEnabled:NO];
    [_delegate startRecord];
    [progress setCurrentTime:0];
    isRecording = YES;
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:48000.0],AVSampleRateKey,
                              [NSNumber numberWithInt:kAudioFormatMPEG4AAC], AVFormatIDKey,
                              [NSNumber numberWithInt:1], AVNumberOfChannelsKey,nil];
  
    audioRecorder = [[AVAudioRecorder alloc] initWithURL:recordedFile settings:settings error:nil];
    [audioRecorder prepareToRecord];
    [audioRecorder recordForDuration:MAX_DURATION];
     timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(refreshProgress) userInfo:nil repeats:YES];

}

- (void)stopRecord
{
    [timer invalidate];
    timer = nil;
    [progress setCurrentTime:0];
    isRecording = NO;
    isRecorded = YES;
    [_delegate stopRecord];
    if ([audioRecorder isRecording]) {
        [audioRecorder stop];
    }
    
}

- (NSURL *)recordUrl
{
    return recordedFile;
}

- (NSTimeInterval)recordTime
{

    return [audioRecorder  currentTime];
}

- (void)removeRecord
{
    if ([audioRecorder isRecording]) {
        [timer invalidate];
        timer = nil;
        [audioRecorder stop];
        recordedFile = nil;
    }

}

@end
