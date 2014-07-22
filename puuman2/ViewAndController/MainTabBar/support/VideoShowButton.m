//
//  VideoShowButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "VideoShowButton.h"
#import "UniverseConstant.h"
#import "MainTabBarController.h"
#import "UpLoaderShareVideo.h"
#import "DiaryModel.h"

@implementation VideoShowButton
@synthesize delegate = _delegate;
@synthesize clickEnable = _clickEnable;

- (id)initWithFrame:(CGRect)frame fileName:(NSString *)fileName
{
    self = [super initWithFrame:frame];
    if (self)
    {
        progress = 0;
        filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"gif"];
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:imgView];
        playBtn = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.height - frame.size.width)/2, 0, frame.size.height, frame.size.height)];
        [playBtn setBackgroundColor:[UIColor clearColor]];
        [playBtn addTarget:self action:@selector(showVideo) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:playBtn];
        refs = [[NSMutableArray alloc] init];

        [MyNotiCenter addObserver:self selector:@selector(downAutoVideo) name:Noti_HasShareVideo object:nil];
        [MyNotiCenter addObserver:self selector:@selector(refreshProgressAutoVideo:) name:Noti_RefreshProgressAutoVideo object:nil];
        [MyNotiCenter addObserver:self selector:@selector(finishDownShareVideo:) name:Noti_FinishShareVideo object:nil];
        [MyNotiCenter addObserver:self selector:@selector(failDownShareVideo) name:Noti_FailShareVideo object:nil];
        [MyNotiCenter addObserver:self selector:@selector(startGif) name:Noti_StartGif object:nil];
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(initImgs) object:nil];
        [thread start];
    }
    return self;
}

- (void)initImgs
{
    NSDictionary *gifLoopCount = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
    NSDictionary *gifProperties = [NSDictionary dictionaryWithObject:gifLoopCount forKey:(NSString *)kCGImagePropertyGIFDictionary];
    gif  = CGImageSourceCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:filePath], (__bridge CFDictionaryRef)gifProperties);
    NSInteger countProperty  =CGImageSourceGetCount(gif);
    //        [self showGifAtIndex:currentProperty];

    for (int i =0; i<countProperty; i++) {
        CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, i, (__bridge CFDictionaryRef)gifProperties);
        [refs addObject:[UIImage imageWithCGImage:ref]];
        if (i == 0) {
            [imgView setImage:[UIImage imageWithCGImage:ref]];
        }
    }
    [imgView setAnimationImages:refs];
    imgView.animationDuration=2.0;
    imgView.animationRepeatCount=0;

}

-(void)startGif
{
    [imgView startAnimating];
    [self setClickEnable:YES];
}





- (void)showVideo
{
   //filePath = [[NSBundle mainBundle] pathForResource:@"popeye" ofType:@"mp4"];

    [_delegate showVideoWithVideoPath:filePath];
    [playBtn setEnabled:NO];
    [self stopGif];
}

- (void)stopGif
{
    [imgView stopAnimating];

}

- (void)setClickEnable:(BOOL)clickEnable
{
    _clickEnable = clickEnable;
    if (clickEnable) {
        [playBtn setEnabled:YES];
    }else{
        [playBtn setEnabled:NO];

    }
}

- (void)downAutoVideo
{
    
    SetViewLeftUp(self, ViewX(self),-1*ViewHeight(self));
    [self setClickEnable:NO];
    if ([[MainTabBarController sharedMainViewController] isVertical]) {
        [self setAlpha:0];
    }else{
        [self setAlpha:1];
    }
    UpLoaderShareVideo *downloader = [[UpLoaderShareVideo alloc] init];
    [downloader downloadDataFromUrl:[[UserInfo sharedUserInfo] shareVideo].videoUrl];
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshProgress) userInfo:nil repeats:YES];
    [MainTabBarController sharedMainViewController].hasShareVideo = NO;
    
}

- (void)refreshProgress
{
    [self setAlpha:1];
    [UIView animateWithDuration:1 animations:^{
        SetViewLeftUp(self, ViewX(self), ViewHeight(self)*(progress - 1));
    }];
}


- (void)refreshProgressAutoVideo:(NSNotification *)notification
{
    progress = [[notification object] floatValue];

}

- (void)failDownShareVideo
{
    // _loadingVideo = NO;
    SetViewLeftUp(self, ViewHeight(self), -1 *ViewHeight(self));
    [self setAlpha:0];
    
}



- (void)finishDownShareVideo:(NSNotification *)notification
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    // _loadingVideo = NO;
    [MainTabBarController sharedMainViewController].hasShareVideo = YES;
    filePath = [notification object];
    if (([[DiaryModel sharedDiaryModel] downloadedCnt] == [[DiaryModel sharedDiaryModel] updateCnt]) && [MainTabBarController sharedMainViewController].hasShareVideo) {
        [self performSelector:@selector(startGif) withObject:nil afterDelay:0];
    }
}




- (void)dealloc
{
    NSLog(@"dealloc");
    CFRelease(gif);
    [MyNotiCenter removeObserver:self];
}

@end
