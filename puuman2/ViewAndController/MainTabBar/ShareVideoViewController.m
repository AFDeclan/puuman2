//
//  ShareVideoViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-21.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ShareVideoViewController.h"
#import "UniverseConstant.h"
#import "DiaryFileManager.h"
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>
#import "UIImage+Blur.h"

@interface ShareVideoViewController ()

@end

@implementation ShareVideoViewController
@synthesize contentView = _contentView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initialization];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialization
{
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [_contentView setBackgroundColor:PMColor6];
    [self.view addSubview:_contentView];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.view setFrame:CGRectMake(0, 0, 1024, 768)];

    path = [[NSBundle mainBundle] pathForResource:@"popeye" ofType:@"mp4"];
    moviePlayer = [[MPMoviePlayerController alloc] init];
    [moviePlayer setContentURL:[NSURL fileURLWithPath:path]];
    [moviePlayer.view setBackgroundColor:[UIColor blackColor]];
    [moviePlayer setShouldAutoplay:NO];
    [moviePlayer setFullscreen:YES];
    [moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
    [moviePlayer.view setFrame:CGRectMake(0, 0, 1024, 768)];
    [_contentView addSubview:moviePlayer.view];
    [moviePlayer prepareToPlay];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
    finishImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [finishImgView setImage:nil];
    finishImgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_contentView  addSubview:finishImgView];
    
    manageView = [[VideoManageView alloc] init];
    [manageView setDelegate:self];
    [_contentView addSubview:manageView];
    [manageView setAlpha:0];
    
}


-(void)movieFinished:(NSNotification*)notify{
    MPMoviePlayerController *moveController = [notify object];
    [finishImgView setImage:[DiaryFileManager imageForVideo:path withDuraTion:moveController.duration]];
    [self showBlur];
    [manageView setAlpha:1];
    [manageView setFilepath:path];
    [manageView showAnimate];

}

- (void)showBlur
{
    UIImage *screenshot = [self rn_screenshot];
    //  imgView.alpha = 1.f;
    finishImgView.layer.contents = (id)screenshot.CGImage;
    
    UIBezierPath *blurExclusionPath = [UIBezierPath bezierPathWithOvalInRect:finishImgView.frame];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0L), ^{
        UIImage *blur = [screenshot rn_boxblurImageWithBlur: 0.5f ];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CATransition *transition = [CATransition animation];
            
            transition.duration = 0.2;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionFade;
            
            [finishImgView.layer addAnimation:transition forKey:nil];
            finishImgView.layer.contents = (id)blur.CGImage;
            
            [self.view setNeedsLayout];
            [self.view layoutIfNeeded];
        });
    });

}

- (UIImage *)rn_screenshot {
    UIGraphicsBeginImageContext(finishImgView.bounds.size);
    [finishImgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // helps w/ our colors when blurring
    // feel free to adjust jpeg quality (lower = higher perf)
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
    image = [UIImage imageWithData:imageData];
    
    return image;
}


- (void)shareVideo
{
    [DiaryFileManager saveVideo:[NSURL fileURLWithPath:path] withTitle:@"" andTaskInfo:nil];
    
}

- (void)deleteVideo
{
    [self hidden];
}


- (void)show
{
    
    [_contentView showInFrom:kAFAnimationFromTop inView:self.view withFade:NO duration:2 delegate:self startSelector:nil stopSelector:nil];
    [moviePlayer play];

}

- (void)hidden
{
    [_contentView hiddenOutTo:kAFAnimationFromOutTop inView:self.view withFade:NO duration:2 delegate:self startSelector:nil stopSelector:@selector(finishOut)];
    
}


- (void)finishOut
{
    [_delegate babyViewfinished];
    [self viewDidDisappear:NO];
    [MyNotiCenter removeObserver:self];
}

- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}
@end