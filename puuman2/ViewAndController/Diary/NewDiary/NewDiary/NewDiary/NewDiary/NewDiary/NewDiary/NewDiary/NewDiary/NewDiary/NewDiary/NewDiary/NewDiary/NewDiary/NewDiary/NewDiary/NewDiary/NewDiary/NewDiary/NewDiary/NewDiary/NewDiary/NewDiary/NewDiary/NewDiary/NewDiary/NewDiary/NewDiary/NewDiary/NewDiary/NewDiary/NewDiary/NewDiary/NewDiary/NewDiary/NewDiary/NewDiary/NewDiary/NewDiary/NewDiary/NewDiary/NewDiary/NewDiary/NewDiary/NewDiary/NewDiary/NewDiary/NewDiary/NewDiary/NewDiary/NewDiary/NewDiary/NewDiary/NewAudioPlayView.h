//
//  NewAudioPlayView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewAudioProgressView.h"
#import <AVFoundation/AVFoundation.h>
@protocol NewAudioPlayDelegate;
@interface NewAudioPlayView : UIView<AVAudioPlayerDelegate>
{
    AVAudioPlayer *player;
    UIImageView *playBg;
    NewAudioProgressView *progress;
    UIButton *playBtn;
    NSTimer *timer;
}
@property (assign,nonatomic) NSURL *playFile;
@property (assign,nonatomic) NSTimeInterval maxTime;
@property (assign,nonatomic)id<NewAudioPlayDelegate>delegate;
- (void)removePlay;
- (void)stopPlay;
- (void)startPlay;
@end
@protocol NewAudioPlayDelegate <NSObject>
- (void)stopPlay;
- (void)startPlay;
@end