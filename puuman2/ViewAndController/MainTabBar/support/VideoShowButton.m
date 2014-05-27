//
//  VideoShowButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "VideoShowButton.h"

@implementation VideoShowButton




- (id)initWithFrame:(CGRect)frame fileName:(NSString *)fileName
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSDictionary *gifLoopCount = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
        
        gifProperties = [NSDictionary dictionaryWithObject:gifLoopCount forKey:(NSString *)kCGImagePropertyGIFDictionary];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"gif"];
        gif = CGImageSourceCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:filePath], (__bridge CFDictionaryRef)gifProperties);
        count =CGImageSourceGetCount(gif);
        
        timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(play) userInfo:nil repeats:YES];
        [timer fire];
        count = 82;

    }
    return self;
}

-(void)play
{
    index ++;
    index = index%count;
    CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (__bridge CFDictionaryRef)gifProperties);
    self.layer.contents = (__bridge id)ref;
    CFRelease(ref);
}

- (void)dealloc
{
    NSLog(@"dealloc");
    CFRelease(gif);
   
}

- (void)stopGif
{
    [timer invalidate];
    timer = nil;
}

@end
