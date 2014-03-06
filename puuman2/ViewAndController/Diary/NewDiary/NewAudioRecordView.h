//
//  NewAudioRecordView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewAudioProgressView.h"
#import <AVFoundation/AVFoundation.h>
@protocol NewAudioRecordDelegate;
@interface NewAudioRecordView : UIView<AVAudioRecorderDelegate>
{
  
    UIImageView *recordBg;
    NewAudioProgressView *progress;
    UIButton *recordBtn;
    NSURL *recordedFile;
    AVAudioRecorder *audioRecorder;
    BOOL isRecording;
    BOOL isRecorded;
    NSTimer *timer;
}

@property (assign,nonatomic)id<NewAudioRecordDelegate>delegate;
- (NSURL *)recordUrl;
- (void)restartRecord;
- (NSTimeInterval)recordTime;
- (void)removeRecord;
@end

@protocol NewAudioRecordDelegate <NSObject>
- (void)restartRecord;
- (void)stopRecord;
- (void)startRecord;
@end