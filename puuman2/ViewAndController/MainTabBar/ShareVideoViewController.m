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
#import "UserInfo.h"
#import "CustomNotiViewController.h"

@interface ShareVideoViewController ()

@end

@implementation ShareVideoViewController
@synthesize contentView = _contentView;
@synthesize filePath = _filePath;

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
    shareType = SocialNone;
    saved = NO;
    deleteVideo = NO;
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [_contentView setBackgroundColor:PMColor6];
    [self.view addSubview:_contentView];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.view setFrame:CGRectMake(0, 0, 1024, 768)];

    
    moviePlayer = [[MPMoviePlayerController alloc] init];
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
    [MyNotiCenter addObserver:self selector:@selector(continueVideo) name:Noti_ContinueVideo object:nil];
    
}

- (void)continueVideo
{
    if ([moviePlayer playbackState] == MPMoviePlaybackStatePaused) {
        [moviePlayer play];
    }
}

- (void)setFilePath:(NSString *)filePath
{
    _filePath = filePath;
    [moviePlayer setContentURL:[NSURL fileURLWithPath:filePath]];

}


-(void)movieFinished:(NSNotification*)notify{
    MPMoviePlayerController *moveController = [notify object];
    [finishImgView setImage:[DiaryFileManager imageForVideo:_filePath withDuraTion:moveController.duration]];
    [self showBlur];
    [manageView setAlpha:1];
    [manageView showAnimate];

}

- (void)showBlur
{
    UIImage *screenshot = [self rn_screenshot];
    //  imgView.alpha = 1.f;
    finishImgView.layer.contents = (id)screenshot.CGImage;
    
    
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
    ShareSelectedViewController *shareVC = [[ShareSelectedViewController alloc] initWithNibName:nil bundle:nil];
    [self.view addSubview:shareVC.view];
    [shareVC setShareText:[[UserInfo sharedUserInfo] shareVideo].shareUrl];
    [shareVC setShareTitle:@"ShareVideo"];
    [shareVC setShareImg:[DiaryFileManager imageForVideo:_filePath]];
    [shareVC setStyle:ConfirmError];
    shareVC.shareDelegate = self;
    [shareVC show];
    
}


- (void)deleteVideo
{
    if (saved) {
        [self hidden];
    }else{
        shareDeleteVC = [[ShareVideoDeleteViewController alloc] initWithNibName:nil bundle:nil];
        [self.view addSubview:shareDeleteVC.view];
        [shareDeleteVC setStyle:ConfirmError];
        shareDeleteVC.deleteDelegate = self;
        shareDeleteVC.delegate = self;
        [shareDeleteVC show];
    }
}


- (void)popViewfinished
{
    if (deleteVideo) {
        [self hidden];
    }
}

- (void)saveVideo
{
    if (!saved) {
        [DiaryFileManager saveVideo:[NSURL fileURLWithPath:_filePath] withTitle:@"" andTaskInfo:nil];
        [CustomNotiViewController showNotiWithTitle:@"保存完成" withTypeStyle:kNotiTypeStyleRight];

    }else{
        //[CustomNotiViewController showNotiWithTitle:@"已保存" withTypeStyle:kNotiTypeStyleRight];
    }
    saved = YES;
}

- (void)selectedShareType:(SocialType)type
{
    shareType = type;
}

- (void)saveShareVideo
{
    [manageView saved];
    [self saveVideo];
}

- (void)deleteShareVideo
{
    deleteVideo = YES;
    [shareDeleteVC hidden];

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
    [_delegate shareViewfinished];
    [self viewDidDisappear:NO];
    [MyNotiCenter removeObserver:self];
}

- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}
@end
