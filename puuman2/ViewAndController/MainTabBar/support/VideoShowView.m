//
//  VideoShowView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-29.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "VideoShowView.h"
#import "UniverseConstant.h"
#import "ColorsAndFonts.h"
#import "DiaryFileManager.h"
#import "UIImage+CroppedImage.h"

@implementation VideoShowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        contentView = [[UIView alloc]initWithFrame:CGRectMake(0, -768, 1024, 768)];
        contentView.backgroundColor = [UIColor blueColor];
        //[contentView setAlpha:0.2];
        [self addSubview:contentView];
        finishView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        [finishView setImage:nil];
        [self  addSubview:finishView];
//        videoPath = [[NSBundle mainBundle] pathForResource:@"popeye" ofType:@"mp4"];
        videoPath = @"";
//        moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:videoPath]];
        moviePlayer = [[MPMoviePlayerController alloc] init];
        [moviePlayer prepareToPlay];
        [moviePlayer.view setBackgroundColor:[UIColor blackColor]];
        [moviePlayer setShouldAutoplay:NO];
        [moviePlayer setFullscreen:YES];
        [moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
        [moviePlayer.view setFrame:CGRectMake(0, 0, 1024, 768)];
        [contentView addSubview:moviePlayer.view];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
        finishImg = [DiaryFileManager imageForVideo:videoPath withDuraTion:60];

        animates  =[[NSMutableArray alloc] init];
        for (int i = 0; i < 20; i ++) {
//            UIImage *img = [self blurryImage:finishImg withBlurLevel:i*0.1];
            UIImage * img = [[UIImage alloc] init];
            [animates addObject:img];
        }
        [finishView setAlpha:0];
        
        manageView = [[VideoManageView alloc] init];
        [manageView setDelegate:self];
        [self addSubview:manageView];
        [manageView setAlpha:0];
      
    }
    return self;
}
- (void)showVideoView
{
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //    positionAnimation.fillMode = kCAFillModeForwards;
    //    positionAnimation.removedOnCompletion =NO;
    positionAnimation.duration = 1;
    CGMutablePathRef positionPath = CGPathCreateMutable();
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [positionAnimation setBeginTime:0];
    CGPathMoveToPoint(positionPath, NULL, [contentView layer].position.x, [contentView layer].position.y);
    CGPathAddQuadCurveToPoint(positionPath, NULL, [contentView layer].position.x, [contentView layer].position.y, [contentView layer].position.x,[contentView layer].position.y+768);
    positionAnimation.path = positionPath;
    [contentView.layer addAnimation:positionAnimation forKey:@"position"];
    SetViewLeftUp(contentView, 0, 0);
}

-(void)playVideo
{
    [moviePlayer play];
}

-(void)movieFinished:(NSNotification*)notify{
    
    MPMoviePlayerController *moveController = [notify object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:moveController];
   
    [finishView setImage:finishImg];
    [finishView setAlpha:1];
    [contentView removeFromSuperview];
    [manageView setAlpha:1];
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.06];
    scaleAnimation.duration = 0.3f;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion =NO;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [finishView.layer addAnimation:scaleAnimation forKey:@"transform.scale"];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(imgAnimate) userInfo:nil repeats:YES];
    [manageView showAnimate];
}

- (void)imgAnimate
{

    [finishView setImage:[animates objectAtIndex:index]];

                
    NSLog(@"a");
    index ++;
    if (index >= 20) {
        [timer invalidate];
        timer = nil;
    }
}

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}



- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"
                                  keysAndValues:kCIInputImageKey, inputImage,
                        @"inputRadius", @(blur), nil];
    
    CIImage *outputImage = filter.outputImage;
    CIContext *context = [CIContext contextWithOptions:nil]; // save it to self.context
    CGImageRef outImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    return [UIImage imageWithCGImage:outImage];
}

- (void)deleteVideo
{
    SetViewLeftUp(contentView, 0, -768);
    [_delegate deleteVideo];
    [self removeFromSuperview];
}

- (void)shareVideo
{

}

@end
