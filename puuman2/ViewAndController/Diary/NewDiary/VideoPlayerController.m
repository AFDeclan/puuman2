//
//  VideoPlayerController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-17.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "VideoPlayerController.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"

@implementation VideoPlayerController
@synthesize delegate = _delegate;
- (id)initWithContentURL:(NSURL *)url
{
    self = [super initWithContentURL:url];
    if (self) {
        [self initizalization];
    }
    return self;
}

- (void)initizalization
{
    
    playBtn = [[UIButton alloc] initWithFrame:CGRectMake(456, 328, 112, 112)];
    [playBtn setImage:[UIImage imageNamed:@"btn_play_diary.png"] forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(playBtnpressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    timeView = [[TimeView alloc] initWithFrame:CGRectMake(16, 16, 80, 80)];
    timeView.layer.cornerRadius = 40;
    timeView.layer.masksToBounds = YES;
    [self.view addSubview:timeView];
    [timeView setBackgroundColor:[UIColor whiteColor]];
    [timeView setAlpha:1];
    [timeView showTimeWithSecond:0];
   

    titleTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(112, 16, 832, 48)];
    [titleTextField setBackgroundColor:PMColor5];
    [self.view addSubview:titleTextField];
    
    closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(960, 704, 48, 48)];
    [closeBtn setImage:[UIImage imageNamed:@"btn_close1.png"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
   
    finishBtn = [[UIButton alloc] initWithFrame:CGRectMake(960, 16, 48, 48)];
    [finishBtn setImage:[UIImage imageNamed:@"btn_finish1.png"] forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(finishBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishBtn];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(setHorizontalFrame) name:NOTIFICATION_Horizontal object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(setVerticalFrame) name:NOTIFICATION_Vertical object:nil];
    

}

- (void)moviePlayerPlaybackDidFinish:(NSNotification*)notification
{
    [timeView stopRecord];
}

- (void)playBtnpressed
{
    
    [timeView startRecord];
    [playBtn setAlpha:0];
    [self play];
}

- (void)closeBtnPressed
{
    [self stop];
    [MyNotiCenter removeObserver:self];
    [_delegate videoClosed];
}

- (void)finishBtnPressed
{
    [timeView stopRecord];
    [self stop];
    [MyNotiCenter removeObserver:self];
    [_delegate videoFinished];
}

- (void)setVerticalFrame
{
    [titleTextField setFrame:CGRectMake(112, 16, 576, 48)];
    SetViewLeftUp(closeBtn, 704, 960);
    SetViewLeftUp(finishBtn, 704, 16);
    SetViewLeftUp(playBtn, 328, 456);
    [self.view setFrame:CGRectMake(0, 0, 768, 1024)];
    
}
- (void)setHorizontalFrame
{
    [titleTextField setFrame:CGRectMake(112, 16, 832, 48)];
    SetViewLeftUp(closeBtn, 960, 704);
    SetViewLeftUp(finishBtn, 960, 16);
    SetViewLeftUp(playBtn, 456, 328);
    [self.view setFrame:CGRectMake(0, 0, 1024, 768)];
}

@end
