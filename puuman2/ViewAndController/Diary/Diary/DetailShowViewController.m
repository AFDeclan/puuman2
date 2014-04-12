//
//  DetailShowViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-11.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "DetailShowViewController.h"
#import "MainTabBarController.h"
#import "DiaryFileManager.h"

@interface DetailShowViewController ()

@end

static DetailShowViewController *detailVC;

@implementation DetailShowViewController
@synthesize index = _index;
@synthesize model = _model;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _model = kModelOfNone;
         [_content setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)setVerticalFrame
{
    [super setVerticalFrame];
    [_content setFrame:CGRectMake(0, 0, 768, 1024)];
    if (_model == kModelOfVideo) {
         [moviePlayer.view setFrame:CGRectMake(0, 0, 768, 1024)];
    }else if(_model == kModelOfPicMore ||_model == kModelOfPicSingle){
        for (int i=0; i<[photoPaths count]; i++)
        {
            UIView *photoView = [photoScroll viewWithTag:i+1];
            [photoView setFrame:CGRectMake(i*768, 0, 768, 1024)];
            [photoView setContentMode:UIViewContentModeScaleAspectFit];
        }
        [photoScroll setContentOffset:CGPointMake((photoScroll.contentOffset.x)*768/1024, 0)];
        [photoScroll setFrame:CGRectMake(0, 0, 768, 1024)];
        [photoScroll setContentSize:CGSizeMake(768*[photoPaths count], 1024)];
    }
    
}

- (void)setHorizontalFrame
{
    [super setHorizontalFrame];
    [_content setFrame:CGRectMake(0, 0, 1024, 768)];
    
    if (_model == kModelOfVideo) {
         [moviePlayer.view setFrame:CGRectMake(0, 0, 1024, 768)];
    }else if(_model == kModelOfPicMore ||_model == kModelOfPicSingle){
        for (int i=0; i<[photoPaths count]; i++)
        {
            UIView *photoView = [photoScroll viewWithTag:i+1];
            [photoView setFrame:CGRectMake(i*1024, 0, 1024, 768)];
            [photoView setContentMode:UIViewContentModeScaleAspectFit];
        }
        
        [photoScroll setContentSize:CGSizeMake(1024*[photoPaths count], 768)];
        [photoScroll setContentOffset:CGPointMake((photoScroll.contentOffset.x)*1024/768, 0)];
        [photoScroll setFrame:CGRectMake(0, 0, 1024, 768)];

    }
}

-(void)showPhotoPath:(NSString *)imgPath
{
   [self showPhotosPath:[NSArray arrayWithObject:imgPath] atIndex:0];
}

-(void)showVideo:(NSString *)path
{
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:path]];
    [moviePlayer prepareToPlay];
    [moviePlayer setShouldAutoplay:NO];
    [moviePlayer setFullscreen:YES];
    [moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
    [_content addSubview:moviePlayer.view];
    for (UIView *view in [[[[moviePlayer.view viewWithTag:0] viewWithTag:0] viewWithTag:0] subviews]) {
//        if ([view isKindOfClass:[UILabel class]]) {
//            NSLog(@"%@",view.tag);
//        }
        NSLog(@"%@",[view class]);
    }
    [moviePlayer.view  viewWithTag:0];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieFinishedCallback)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];

}
- (void)movieFinishedCallback
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 0;
    }];
    [self hidden];
}

- (void)showPhotosPath:(NSArray *)imgPaths atIndex:(NSInteger)index
{
    photoPaths = imgPaths;
    photoScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
    photoScroll.contentSize = CGSizeMake(768*[imgPaths count], 1024);
    photoScroll.backgroundColor = [UIColor clearColor];
    for (int i=0; i<[photoPaths count]; i++)
    {
        UIImage *photo = [DiaryFileManager imageForPath:[photoPaths objectAtIndex:i]];
        UIImageView *photoView = [[UIImageView alloc] initWithFrame:CGRectMake(i*768, 0, 768, 1024)];
        [photoView setTag:i+1];
        [photoView setContentMode:UIViewContentModeScaleAspectFit];
        [photoView setImage:photo];
        [photoView setBackgroundColor:[UIColor clearColor]];
        [photoScroll addSubview:photoView];
    }
    UITapGestureRecognizer *tapPhotos = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photosTapped:)];
    [photoScroll addGestureRecognizer:tapPhotos];
    photoScroll.alpha = 0;
    [self.view addSubview:photoScroll];
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
        [photoScroll setContentOffset:CGPointMake(768*index, 0)];
    }else{
        [self setHorizontalFrame];
        [photoScroll setContentOffset:CGPointMake(1024*index, 0)];
    }
    photoScroll.pagingEnabled = YES;
    [UIView animateWithDuration:0.5 animations:^{
        photoScroll.alpha = 1;
    }];
    
 
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)showPhotosPath:(NSArray *)imgPaths atIndex:(NSInteger)index
{
    detailVC = [[DetailShowViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:detailVC.view];
    detailVC.model = kModelOfPicMore;
    [detailVC showPhotosPath:imgPaths atIndex:index];
    [detailVC show];
}

+ (void)showVideo:(NSString *)path
{
    detailVC = [[DetailShowViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:detailVC.view];
    detailVC.model = kModelOfVideo;
    [detailVC showVideo:path];
    [detailVC show];
}

+ (void)showPhotoPath:(NSString *)imgPath
{
    detailVC = [[DetailShowViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:detailVC.view];
    detailVC.model = kModelOfPicSingle;
    [detailVC showPhotoPath:imgPath];
    [detailVC show];
}




- (void)photosTapped:(UIGestureRecognizer *)sender
{
   
    [UIView animateWithDuration:0.5 animations:^{
        photoScroll.alpha = 0;
    }];

    [self hidden];
}


- (void)show
{
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
    
    [bgView setAlpha:0];
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0.3];
    }];
    [_content showInFrom:kAFAnimationNone inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:nil];
}

- (void)hidden
{
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0];
    }];
    [_content hiddenOutTo:kAFAnimationNone inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:@selector(finishOut)];
    
}

- (void)finishOut
{
    [super dismiss];
    [self.view removeFromSuperview];
    detailVC = nil;
}

@end
