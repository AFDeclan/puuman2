//
//  VideoShowViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "VideoShowViewController.h"
#import "UniverseConstant.h"
#import "ColorsAndFonts.h"
#import "MainTabBarController.h"
#import "ShareSelectedViewController.h"

@interface VideoShowViewController ()

@end

@implementation VideoShowViewController
@synthesize delegate = _delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    contentView = [[UIView alloc]initWithFrame:CGRectMake(0, -768, 1024, 768)];
    contentView.backgroundColor = [UIColor blueColor];
    //[contentView setAlpha:0.2];
    [self.view addSubview:contentView];
   // NSURL *movieURL = [NSURL fileURLWithPath:nil];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"hh" ofType:@"mov"];
    NSURL *movieURL = [NSURL fileURLWithPath:path];
    MPMoviePlayerController *moveController = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    [moveController prepareToPlay];
    [moveController play];
    [self.view addSubview:moveController.view];
    [moveController.view setBackgroundColor:[UIColor clearColor]];
    [moveController.backgroundView setBackgroundColor:[UIColor clearColor]];
     moveController.shouldAutoplay = YES;
    [moveController setControlStyle:MPMovieControlModeDefault];
    [moveController setFullscreen: YES];
     moveController.scalingMode = MPMovieScalingModeAspectFit;
    [moveController.view setFrame:CGRectMake(0, 0, 1024, 768)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:moveController];
    
  
    
    // Do any additional setup after loading the view.
}
-(void)movieFinished:(NSNotification*)notify{

    MPMoviePlayerController *theMovie = [notify object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
    [theMovie.view removeFromSuperview];
    [self initialization];

}

-(void)initialization{
    
//    contentView = [[UIView alloc]initWithFrame:CGRectMake(0, -768, 1024, 768)];
//    contentView.backgroundColor = [UIColor blueColor];
//    //[contentView setAlpha:0.2];
//    [self.view addSubview:contentView];
    //UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(180, 320, 270, 190)];
    shareView = [[UIView alloc] init];
    [shareView setBackgroundColor:[UIColor clearColor]];
   // UIView *closeView =[[UIView alloc] initWithFrame:CGRectMake(640, 320, 270, 190)];
    closeView = [[UIView alloc] init];
    [closeView setBackgroundColor:[UIColor clearColor]];
    UILabel *mainLab = [[UILabel alloc] initWithFrame:CGRectMake(408,216, 215, 25)];
    [contentView addSubview:shareView];
    [contentView addSubview:closeView];
    
    mainLab.text = @"您觉得这段视频......";
    mainLab.textColor = [UIColor whiteColor];
    [mainLab setFont:[UIFont fontWithName:nil size:25.0f]];
    [contentView addSubview:mainLab];
   // UILabel *subLab1 = [[UILabel alloc] initWithFrame:CGRectMake(180, 480, 270, 40)];
    UILabel *subLab1 =[[UILabel alloc] initWithFrame:CGRectMake(0, 200, 270, 40)];
    subLab1.text = @"太赞了，必须分享";
    subLab1.textColor = [UIColor whiteColor];
    [subLab1 setFont:[UIFont fontWithName:nil size:30.0f]];
    [shareView  addSubview:subLab1];
  //  UILabel *subLab = [[UILabel alloc]initWithFrame:CGRectMake(640, 480, 270, 40)];
    UILabel *subLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 270, 40)];
    subLab.text = @"太丑了，马上销毁";
    subLab.textColor = [UIColor whiteColor];
    [subLab setFont:[UIFont fontWithName:nil size:30.0f]];
    [closeView addSubview:subLab];
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   // shareBtn.frame = CGRectMake(240, 320, 128, 128);
    shareBtn.frame = CGRectMake(60, 0, 128, 128);
    [shareBtn setImage:[UIImage imageNamed:@"btn1.png"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:shareBtn];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  //  closeBtn.frame = CGRectMake(690, 320, 128, 128);
    closeBtn.frame = CGRectMake(60, 0, 128, 128);
    [closeBtn setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnPressed)forControlEvents:UIControlEventTouchUpInside];
    [closeView addSubview:closeBtn];

//    [UIView animateWithDuration:1 animations:^{
//        closeView.frame = CGRectMake(640, 768, 270, 190);
//        shareView.frame =CGRectMake(180, 768, 270, 190);
//        
//    } completion:^(BOOL finished){
//        closeView.frame = CGRectMake(640, 320, 270, 90);
//        shareView.frame = CGRectMake(180, 320, 270, 190);
//       
//        
//    }];
    [self showShareView];
    [self showCloseView];

}

- (void)share
{
    [ShareSelectedViewController shareText:nil title:nil image:nil];
}

 -(void)closeBtnPressed
{
    [_delegate closeShowVideo];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void)showShareView{
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = 1;
    CGMutablePathRef positionPath =CGPathCreateMutable();
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [positionAnimation setBeginTime:0];
    CGPathMoveToPoint(positionPath, NULL, [shareView layer].position.x, [shareView layer].position.y);
    CGPathAddQuadCurveToPoint(positionPath, NULL, [shareView layer].position.x, [shareView layer].position.y, [shareView layer].position.x, [shareView layer].position.y-320);
    positionAnimation.path = positionPath;
    [shareView.layer addAnimation:positionAnimation forKey:@"position"];
    SetViewLeftUp(shareView, 180, 768);
    
}
-(void)showCloseView{

    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = 1;
    CGMutablePathRef positionPath = CGPathCreateMutable();
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [positionAnimation setBeginTime:0.1];
    CGPathMoveToPoint(positionPath, NULL, [closeView layer].position.x, [closeView layer].position.y);
    CGPathAddQuadCurveToPoint(positionPath, NULL, [closeView layer].position.x, [closeView layer].position.y, [closeView layer].position.x, [closeView layer].position.y-320);
    positionAnimation.path = positionPath;
    [closeView.layer addAnimation:positionAnimation forKey:@"position"];
    SetViewLeftUp(closeView, 640, 768);

}


@end
