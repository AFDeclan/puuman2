//
//  VideoShowButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "VideoShowButton.h"

@implementation VideoShowButton
@synthesize delegate = _delegate;
@synthesize clickEnable = _clickEnable;

- (id)initWithFrame:(CGRect)frame fileName:(NSString *)fileName
{
    self = [super initWithFrame:frame];
    if (self)
    {
        currentProperty = 1;
        NSDictionary *gifLoopCount = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
        
        gifProperties = [NSDictionary dictionaryWithObject:gifLoopCount forKey:(NSString *)kCGImagePropertyGIFDictionary];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"gif"];
        gif = CGImageSourceCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:filePath], (__bridge CFDictionaryRef)gifProperties);
        countProperty =CGImageSourceGetCount(gif);
//        [self showGifAtIndex:currentProperty];
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:imgView];
        playBtn = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.height - frame.size.width)/2, 0, frame.size.height, frame.size.height)];
        [playBtn setBackgroundColor:[UIColor clearColor]];
        [playBtn addTarget:self action:@selector(showVideo) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:playBtn];
        refs = [[NSMutableArray alloc] init];
        for (int i =0; i<countProperty; i++) {
            CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, i, (__bridge CFDictionaryRef)gifProperties);
            [refs addObject:[UIImage imageWithCGImage:ref]];
            if (i == 0) {
                [imgView setImage:[UIImage imageWithCGImage:ref]];
            }
        }
    }
    return self;
}

-(void)startGif
{
    
    [playBtn setEnabled:YES];
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(play) userInfo:nil repeats:YES];
  // [timer fire];
}


- (void)showGifAtIndex:(NSInteger)index
{
   // CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (__bridge CFDictionaryRef)gifProperties);
    
    [imgView setImage:[refs objectAtIndex:index]];
   // CFRelease(ref);

}

-(void)play
{
    currentProperty ++;
    currentProperty = currentProperty%countProperty;
   [self showGifAtIndex:currentProperty];
    
}

- (void)dealloc
{
    NSLog(@"dealloc");
    CFRelease(gif);
   
}

- (void)showVideo
{
    [_delegate showVideo];
    [playBtn setEnabled:NO];
    [self stopGif];
    
}

- (void)stopGif
{
    [timer invalidate];
    timer = nil;
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

@end
