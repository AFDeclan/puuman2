//
//  MainTabBarController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MainTabBarController.h"
#import "UniverseConstant.h"
#import "BabyData.h"
#import "TaskModel.h"
#import "PumanBookModel.h"
#import "CartModel.h"
#import "SocialNetwork.h"
#import "SettingViewController.h"
#import "DiaryViewController.h"
#import "CustomNotiViewController.h"
#import "MBProgressHUD.h"
#import "ShopModel.h"
#import "EnterTutorialView.h"
#import "ShareVideo.h"
#import "UpLoaderShareVideo.h"
#import "CAKeyframeAnimation+DragAnimation.h"

@interface MainTabBarController ()

@end
static MainTabBarController *instance;
static MBProgressHUD *hud;

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
        [MyNotiCenter addObserver:self selector:@selector(userChanged) name:Noti_UserLogined object:nil];
        [MyNotiCenter addObserver:self selector:@selector(showLoginView) name:Noti_UserLogouted object:nil];
        [MyNotiCenter addObserver:self selector:@selector(hiddenBottomInputView) name:Noti_BottomInputViewHidden object:nil];
        [MyNotiCenter addObserver:self selector:@selector(showBottomInputView:) name:Noti_BottomInputViewShow object:nil];
        [MyNotiCenter addObserver:self selector:@selector(refreshProgressAutoVideo:) name:Noti_RefreshProgressAutoVideo object:nil];
        [MyNotiCenter addObserver:self selector:@selector(downAutoVideo) name:Noti_HasShareVideo object:nil];
        [MyNotiCenter addObserver:self selector:@selector(finishDownShareVideo:) name:Noti_FinishShareVideo object:nil];
        [MyNotiCenter addObserver:self selector:@selector(failDownShareVideo) name:Noti_FailShareVideo object:nil];

        [self.tabBar removeFromSuperview];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
//    UIView *transitionView = [self.view.subviews firstObject];
//    for (UIView *view in [self.view subviews]) {
//        [view removeFromSuperview];
//    }
    babyInfoShowed = NO;
    _babyInfoShowed = NO;
    [self initWithTabBar];
    _isReply = YES;
    _videoShowed = NO;
    _hasShareVideo = NO;
    progress = 0;
    videoPath = @"";
    userInfo = [UserInfo sharedUserInfo];
   // _loadingVideo = YES;
    videoBtn = [[VideoShowButton alloc] initWithFrame:CGRectMake(608, -189, 189,180) fileName:@"animate_puuman"];
    [videoBtn setDelegate:self];
    [self.view addSubview:videoBtn];
    [videoBtn setClickEnable:NO];
    [videoBtn setAlpha:1];
    [self.view.layer setMasksToBounds:YES];
  

}




- (void)downAutoVideo
{

    SetViewLeftUp(videoBtn, 608, -189);
    [videoBtn setClickEnable:NO];
    if (!_isVertical) {
        [videoBtn setAlpha:1];
    }else{
        [videoBtn setAlpha:0];

    }
    UpLoaderShareVideo *downloader = [[UpLoaderShareVideo alloc] init];
    [downloader downloadDataFromUrl:[[UserInfo sharedUserInfo] shareVideo].videoUrl];
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshProgress) userInfo:nil repeats:YES];
    _hasShareVideo = NO;
   


}

- (void)refreshProgress
{
    [videoBtn setAlpha:1];
    [UIView animateWithDuration:1 animations:^{
        SetViewLeftUp(videoBtn, 608, -189*(1 - progress));
    }];
}


- (void)refreshProgressAutoVideo:(NSNotification *)notification
{

    progress = [[notification object] floatValue];
    
   
    
}

- (void)failDownShareVideo
{
   // _loadingVideo = NO;
    SetViewLeftUp(videoBtn, 608, -189);
    [videoBtn setAlpha:0];
 

}



- (void)finishDownShareVideo:(NSNotification *)notification
{
   // _loadingVideo = NO;
    videoPath = [notification object];
    _hasShareVideo = YES;
    if (([[DiaryModel sharedDiaryModel] downloadedCnt] == [[DiaryModel sharedDiaryModel] updateCnt]) && _hasShareVideo) {
        [self performSelector:@selector(startGif) withObject:nil afterDelay:0];
    }
}

- (void)startGif
{

    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    videoView = [[VideoShowView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768) withVideoPath:videoPath];
    [videoView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:videoView];
    [videoView setDelegate:self];
    [videoView  setAlpha:0];
    [videoView.layer setMasksToBounds:YES];
    _hasShareVideo = NO;
    [self performSelector:@selector(showBtnEnable) withObject:nil afterDelay:0];

}

- (void)showBtnEnable
{
    [videoBtn startGif];
    [videoBtn setClickEnable:YES];

}


- (void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults boolForKey:@"tutorialShowed"]){
        
        [userDefaults setBool:YES forKey:@"tutorialShowed"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startApp) name:Noti_TutorialFinshed object:nil];
        
    }else{
        
        [self initautoImportView];
        
        if (![userInfo logined]) {
            if (![userInfo loginFromUserDefault])
            {
                [self showLoginView];
            }
            
        }

    }

    
}

- (void)showVideo
{
   
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    positionAnimation.fillMode = kCAFillModeForwards;
//    positionAnimation.removedOnCompletion =NO;
    positionAnimation.duration = 1;
    CGMutablePathRef positionPath = CGPathCreateMutable();
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [positionAnimation setBeginTime:0];
    CGPathMoveToPoint(positionPath, NULL, [videoBtn layer].position.x, [videoBtn layer].position.y);
    CGPathAddQuadCurveToPoint(positionPath, NULL, [videoBtn layer].position.x, [videoBtn layer].position.y, [videoBtn layer].position.x,[videoBtn layer].position.y+768);
    positionAnimation.path = positionPath;
    [videoBtn.layer addAnimation:positionAnimation forKey:@"position"];
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

- (void)startApp
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Noti_TutorialFinshed object:nil];
    [self initautoImportView];
    
    if (![userInfo logined]) {
        if (![userInfo loginFromUserDefault])
        {
            [self showLoginView];
        }
        
    }
    
}



- (void)initWithTabBar
{
    tabBar  = [[MainTabBar alloc] initWithFrame:CGRectMake(0, 0, 64, 0)];
    [tabBar setDelegate:self];
    [self.view addSubview:tabBar];
    
    self.hidesBottomBarWhenPushed = YES;
    UIView *transitionView = [self.view.subviews firstObject];
    transitionView.frame = CGRectMake(0, 0, 1024, 1024);
    bgImgView = [[UIImageView alloc] init];
    [self.view insertSubview:bgImgView atIndex:0];
    
}

 -(void)selectedWithTag:(NSInteger)tag
{
    if (tag == 1) {
        [[DiaryViewController alloc] refresh];
    }
    [self setSelectedIndex:tag];
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
    if (infoView) {
        if (babyInfoShowed) {
            [infoView setFrame:CGRectMake(0, 0, 768, 1024)];
        }else{
            [infoView setFrame:CGRectMake(0, -1024, 768, 1024)];

        }
        [infoView setVerticalFrame];
    }
    
    if (babyInfoBtn) {
        if (babyInfoShowed) {
            SetViewLeftUp(babyInfoBtn,768 -16 - 56, 1024);
        }else{
            SetViewLeftUp(babyInfoBtn,768 -16 - 56, 0);
        }
    }
    
    if (babyShowBtn) {
        SetViewLeftUp(babyShowBtn,768 -16 - 80, 1024);
        
    }
    
    
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
    if (infoView) {
        if (babyInfoShowed) {
            [infoView setFrame:CGRectMake(0, 0, 1024,768 )];
        }else{
            [infoView setFrame:CGRectMake(0, -768, 1024, 768)];
            
        }
        [infoView setHorizontalFrame];
    }
    
    if (babyInfoBtn) {
        if (babyInfoShowed) {
            SetViewLeftUp(babyInfoBtn,1024 -16 - 56,768);
        }else{
            SetViewLeftUp(babyInfoBtn,1024 -16 - 56, 0);
        }
    }
    
    if (babyShowBtn) {
        SetViewLeftUp(babyShowBtn,1024 -16 - 80, 768);
    }
}

- (void)showLoginView
{
    [self setSelectedIndex:0];
    loginViewC = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
    [self.view addSubview:loginViewC.view];
    [loginViewC setControlBtnType:kCloseAndFinishButton];
    [loginViewC setTitle:@"欢迎使用扑满日记！" withIcon:nil];
    [loginViewC loginSetting];
    [loginViewC show];
    
  
}

- (void)userChanged
{

    if (loginViewC) {
        [loginViewC loginSucceed];
    }
   
    [[BabyData sharedBabyData] reloadData];
    [[TaskModel sharedTaskModel] updateTasks];
    [[PumanBookModel bookModel] initialize];
    [[CartModel sharedCart] update:NO];
    [SocialNetwork initSocialNetwork];
    [[DiaryModel sharedDiaryModel] reloadData];
    [[DiaryModel sharedDiaryModel] updateDiaryFromServer];
    [tabBar selectedWithTag:1];
    [self refreshBabyInfoView];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults boolForKey:@"DiarytutorialShowed"]){
        [userDefaults setBool:YES forKey:@"DiarytutorialShowed"];
        diaryTurorialView =[[UIView alloc] init];
        UIImageView *diaryTurorial = [[UIImageView alloc] init];
        if (_isVertical ) {
            [diaryTurorialView setFrame:CGRectMake(0, 0, 768, 1024)];
            [diaryTurorial setFrame:CGRectMake(0, 0, 768, 1024)];
            [diaryTurorial setImage:[UIImage imageNamed:@"pic2_course2.png"]];

        }else{
            [diaryTurorialView setFrame:CGRectMake(0, 0, 1024, 768)];
            [diaryTurorial setFrame:CGRectMake(0, 0, 1024, 768)];
            [diaryTurorial setImage:[UIImage imageNamed:@"pic1_course1.png"]];

        }
      
        [diaryTurorialView setAlpha:1];
        [diaryTurorialView addSubview:diaryTurorial];
        [self.view addSubview:diaryTurorialView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenDiaryTurorialView)];
        [diaryTurorialView addGestureRecognizer:tap];
    }
}

- (void)hiddenDiaryTurorialView
{
    [diaryTurorialView setAlpha:0];
    [diaryTurorialView removeFromSuperview];
}


- (void)showSettingView
{
    if (settingVC) {
        [settingVC.view removeFromSuperview];
    }
    settingVC = [[SettingViewController alloc] initWithNibName:nil bundle:nil];
    [settingVC show];
    [self.view addSubview:settingVC.view];
    
}

- (void)initautoImportView
{
    
    if (improtAutoVC) {
        improtAutoVC = nil;
    }
    improtAutoVC = [[AutoImportViewController alloc] initWithNibName:nil bundle:nil];
    [improtAutoVC setControlBtnType:kCloseAndFinishButton];
    [improtAutoVC setTitle:@"您好像拍了新的照片，是否导入？" withIcon:nil];
    
}

- (void)showAutoImportView
{
    
    if (improtAutoVC) {
        [self.view addSubview:improtAutoVC.view];
        [improtAutoVC show];
    }
    
    
}

- (void)removeAutoImportView
{
    if (improtAutoVC) {

        [improtAutoVC.view removeFromSuperview];
        improtAutoVC = nil;
    }
    
}

- (void)goToShopWithParentIndex:(NSInteger)parentMenu andChildIndex:(NSInteger)childMenu
{
    [tabBar selectedWithTag:4];
    [ShopModel sharedInstance].sectionIndex = parentMenu;
    [ShopModel sharedInstance].subClassIndex = childMenu;
     PostNotification(Noti_RefreshMenu, nil);
}

- (void)showBottomInputView:(NSNotification *)notification
{
  //  if (!inputVC) {
        inputVC = [[ChatInputViewController alloc] initWithNibName:nil bundle:nil];
        [[MainTabBarController sharedMainViewController].view addSubview:inputVC.view];
        [inputVC setActionParent:[notification object]];
        [inputVC setSendIsHidden:_isReply];
        [inputVC setDelegate:self];
        [inputVC show];
  //  }
 
}



- (void)hiddenBottomInputView
{
    if (inputVC) {
        [inputVC hidden];
        inputVC = nil;
    }
}

- (void)popViewfinished
{
    [inputVC.view removeFromSuperview];
    inputVC = nil;
}

+ (void)showHud:(NSString *)text
{
    MainTabBarController *viewCon = [self sharedMainViewController];
    if (!hud)
    {
        hud = [[MBProgressHUD alloc] initWithView:viewCon.view];
    }
    else return;
    hud.labelText = text;
    [viewCon.view addSubview:hud];
    [hud show:YES];
}


+ (void)showHudCanCancel:(NSString *)text
{
    MainTabBarController *viewCon = [self sharedMainViewController];
    if (!hud)
    {
        hud = [[MBProgressHUD alloc] initWithView:viewCon.view];
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelHud)];
        [hud addGestureRecognizer:tap];
    }
    else return;
    hud.labelText = text;
    [viewCon.view addSubview:hud];
    [hud show:YES];
}

+ (void)hideHud
{
    [hud removeFromSuperview];
    hud = nil;
}

+ (void)cancelHud
{
    [self hideHud];
    PostNotification(Noti_HudCanceled, nil);
}

- (void)updatePuumanData
{
    [puumanView updateData];
}

- (void)refreshBabyInfoView
{
    if (infoView) {
        [infoView removeFromSuperview];
    }
    infoView = [[BabyView alloc] initWithFrame:CGRectMake(0, -768, 1024, 768)];
    [self.view addSubview:infoView];
    [infoView.layer setMasksToBounds:NO];
    if (!babyShowBtn) {
        babyShowBtn = [[BabyShowButton alloc] initWithFrame:CGRectMake(1024 -16 - 80, 768, 80, 100)];
        [babyShowBtn setBackgroundColor:[UIColor clearColor]];
    }
    [infoView addSubview:babyShowBtn];
    
    [babyShowBtn loadPortrait];
    if (!babyInfoBtn) {
        babyInfoBtn = [[UIButton alloc ]initWithFrame:CGRectMake(1024 -16 - 80, 0, 80, 100)];
        [babyInfoBtn addTarget:self action:@selector(showBabyView) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:babyInfoBtn];
    }
    
    if (_isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
    
}

-(void)showBabyView
{
    [infoView loadDataInfo];
    float posX = 0;
    float posY = 0;
    
    if (_isVertical) {
        posX = 768;
        posY = 1024;
    }else{
        posX = 1024;
        posY = 768;
    }
    SetViewLeftUp(babyInfoBtn, posX -16 - 56, posY);

    [self dragAnimationWithView:infoView andDargPoint:CGPointMake(0, posY)];
    SetViewLeftUp(infoView, 0, 0);
    babyInfoShowed = YES;
    // [babyShowBtn addPuuman];
}

- (void)hiddenBabyView
{
    float posX = 0;
    float posY = 0;
    
    if (_isVertical) {
        posX = 768;
        posY = -1024;
    }else{
        posX = 1024;
        posY = -768;
    }
    [self dragAnimationWithView:infoView andDargPoint:CGPointMake(0, posY)];
    SetViewLeftUp(infoView, 0, posY);
    SetViewLeftUp(babyInfoBtn, posX -16 - 56, 0);

    babyInfoShowed = NO;

}

-(void)dragAnimationWithView:(UIView *)view andDargPoint:(CGPoint)pos
{
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //    positionAnimation.fillMode = kCAFillModeForwards;
    //    positionAnimation.removedOnCompletion =NO;
    positionAnimation.duration = 1;
    CGMutablePathRef positionPath = CGPathCreateMutable();
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [positionAnimation setBeginTime:0];
    CGPathMoveToPoint(positionPath, NULL, [view layer].position.x, [view layer].position.y);
    CGPathAddQuadCurveToPoint(positionPath, NULL, [view layer].position.x, [view layer].position.y, [view layer].position.x +pos.x,[view layer].position.y+pos.y);
    positionAnimation.path = positionPath;
    [positionAnimation setDelegate:self];
    [view.layer addAnimation:positionAnimation forKey:@"position"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (!flag) {
        return;
    }
   _babyInfoShowed = babyInfoShowed;
    
}




@end
