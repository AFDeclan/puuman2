//
//  MainTabBarController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MainTabBarController.h"
#import "UniverseConstant.h"
#import "SocialNetwork.h"
#import "SettingViewController.h"
#import "CustomNotiViewController.h"
#import "ShopModel.h"
#import "EnterTutorialView.h"
#import "ShareVideo.h"
#import "CAKeyframeAnimation+DragAnimation.h"

@interface MainTabBarController ()

@end
static MainTabBarController *instance;

@implementation MainTabBarController
@synthesize isVertical = _isVertical;
@synthesize refresh_HV = _refresh_HV;
@synthesize isReply = _isReply;
@synthesize videoShowed =_videoShowed;
@synthesize hasShareVideo = _hasShareVideo;
@synthesize babyInfoShowed = _babyInfoShowed;

//@synthesize loadingVideo = _loadingVideo;
+ (MainTabBarController *)sharedMainViewController
{
    if (!instance)
    {
        instance = [[MainTabBarController alloc] initWithNibName:nil bundle:nil];
    }
    return instance;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setDelegate:self];
        _isVertical = YES;



        [self.tabBar removeFromSuperview];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    babyInfoShowed = NO;
    _babyInfoShowed = NO;
    [self initWithTabBar];
    _isReply = YES;
    _videoShowed = NO;
    _hasShareVideo = NO;
   
    userInfo = [UserInfo sharedUserInfo];
   // _loadingVideo = YES;
    videoBtn = [[VideoShowButton alloc] initWithFrame:CGRectMake(608, -189, 189,180) fileName:@"animate_puuman"];
    [videoBtn setDelegate:self];
    [self.view addSubview:videoBtn];
    [videoBtn setClickEnable:NO];
    [videoBtn setAlpha:1];
    [self.view.layer setMasksToBounds:YES];

}



- (void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults boolForKey:@"tutorialShowed"]){
        
        [userDefaults setBool:YES forKey:@"tutorialShowed"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startApp) name:Noti_TutorialFinshed object:nil];
        
    }else{
        if (![userInfo logined]) {
            if (![userInfo loginFromUserDefault])
            {
                PostNotification(Noti_UserLogouted, nil);
            }
            
        }

    }
    
}



- (void)startApp
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Noti_TutorialFinshed object:nil];
    if (![userInfo logined]) {
        if (![userInfo loginFromUserDefault])
        {
            PostNotification(Noti_UserLogouted, nil);
        }
        
    }
    
}



- (void)initWithTabBar
{
    tabBar  = [[MainTabBar alloc] initWithFrame:CGRectMake(0, 0, 64, 0)];
    [self.view addSubview:tabBar];
    
    self.hidesBottomBarWhenPushed = YES;
    UIView *transitionView = [self.view.subviews firstObject];
    transitionView.frame = CGRectMake(0, 0, 1024, 1024);
    bgImgView = [[UIImageView alloc] init];
    [self.view insertSubview:bgImgView atIndex:0];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController*)viewController
{
    CATransition *animation =[CATransition animation];
    [animation setDuration:0.75f];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setType:kCATransitionFade];
    [animation setSubtype:kCATransitionFromRight];
    [tabBarController.view.layer addAnimation:animation forKey:@"reveal"];
    return YES;
}


#pragma mark - vertiacl and horizontal



-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    
    return YES;
    
}

- (BOOL)shouldAutorotate
{
    if (_videoShowed) {
        return NO;
    }else{
        return YES;
    }
   
}


-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationPortraitUpsideDown) {
        //翻转为竖屏时
        [self setVerticalFrame];

        
    }else if (interfaceOrientation==UIDeviceOrientationLandscapeLeft || interfaceOrientation == UIDeviceOrientationLandscapeRight) {
        //翻转为横屏时
        
        [self setHorizontalFrame];
        
    }
}

-(void)setVerticalFrame
{
    if (!_isVertical) {
        _isVertical = YES;
         [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_Vertical object:nil];
    }
    [videoBtn setAlpha:0];
    [tabBar setVerticalFrame];
    [bgImgView setImage:[UIImage imageNamed:IMG_DIARY_V]];
    [bgImgView setFrame:CGRectMake(0, 0, 768, 1024)];
    
    
}

-(void)setHorizontalFrame
{
    if (_isVertical) {
         _isVertical = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_Horizontal object:nil];
    }
    [videoBtn setAlpha:1];
    [tabBar setHorizontalFrame];
    [bgImgView setImage:[UIImage imageNamed:IMG_DIARY_H]];
    [bgImgView setFrame:CGRectMake(0, 0, 1024, 1024)];
    
}

#pragma mark - shareVideo

- (void)initVideoWithViewoPath:(NSString *)videoPath
{
    videoView = [[VideoShowView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768) withVideoPath:videoPath];
    [videoView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:videoView];
    [videoView setDelegate:self];
    [videoView  setAlpha:0];
    [videoView.layer setMasksToBounds:YES];
    _hasShareVideo = NO;
    
}

- (void)showVideo
{
    
    [CAKeyframeAnimation dragAnimationWithView:videoBtn andDargPoint:CGPointMake(0, 768) andDelegate:nil];
    [videoView setAlpha:1];
    // [videoBtn setAlpha:0];
    [videoView showVideoView];
    [videoView playVideo];
    _videoShowed = YES;
    
}

- (void)deleteVideo
{
    [videoBtn stopGif];
    _videoShowed = NO;
    [videoView  removeFromSuperview];
    videoView = nil;
    SetViewLeftUp(videoBtn, 608, -189);
    //[videoBtn showGifAtIndex:0];
    [videoBtn setClickEnable:NO];
    [videoBtn setAlpha:0];
    
}




@end
