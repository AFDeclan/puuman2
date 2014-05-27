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
- (id)initWithFrame:(CGRect)frame fileName:(NSString *)fileName
{
    self = [super initWithFrame:frame];
    if (self)
    {
        currentProperty = 0;
        NSDictionary *gifLoopCount = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
        
        gifProperties = [NSDictionary dictionaryWithObject:gifLoopCount forKey:(NSString *)kCGImagePropertyGIFDictionary];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"gif"];
        gif = CGImageSourceCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:filePath], (__bridge CFDictionaryRef)gifProperties);
        countProperty =CGImageSourceGetCount(gif);
        [self showGifAtIndex:currentProperty];
        
        playBtn = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.height - frame.size.width)/2, 0, frame.size.height, frame.size.height)];
        [playBtn setBackgroundColor:[UIColor clearColor]];
        [playBtn addTarget:self action:@selector(showVideo) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:playBtn];
        [self startGif];
    }
    return self;
}

-(void)startGif
{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(play) userInfo:nil repeats:YES];
    [timer fire];
}

- (void)showGifAtIndex:(NSInteger)index
{
    CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (__bridge CFDictionaryRef)gifProperties);
    self.layer.contents = (__bridge id)ref;
    CFRelease(ref);

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

@end
