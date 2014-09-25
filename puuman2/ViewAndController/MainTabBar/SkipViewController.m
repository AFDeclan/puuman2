//
//  SkipViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SkipViewController.h"
#import "MainTabBarController+MainTabBarControllerSkip.h"
#import "UniverseConstant.h"
#import "Models.h"
#import "DiaryViewController.h"
#import "Friend.h"
#import "Forum.h"

@interface SkipViewController ()

@end
static SkipViewController *instance;

@implementation SkipViewController

+ (SkipViewController *)sharedController
{
    if (!instance)
    {
        instance = [[SkipViewController alloc] initWithNibName:nil bundle:nil];
    }
    return instance;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [MyNotiCenter addObserver:self selector:@selector(showLoginView) name:Noti_UserLogouted object:nil];
        [MyNotiCenter addObserver:self selector:@selector(userChanged) name:Noti_UserLogined object:nil];
        [MyNotiCenter addObserver:self selector:@selector(reloadUserData) name:Noti_UserInfoUpdated object:nil];

    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)userChanged
{
    if (loginViewC) {
        [loginViewC loginSucceed];
    }
    
    [Forum releaseInstance];
    [Friend releaseInstance];
    //`[[TaskModel sharedTaskModel] updateTasks];
    [[DiaryModel sharedDiaryModel] reloadData];
    [[DiaryModel sharedDiaryModel] updateDiaryFromServer];
    [[MainTabBarController sharedMainViewController] showDiary];
    
    [[DiaryViewController sharedDiaryViewController] removeheadView];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults boolForKey:@"DiarytutorialShowed"]){
        [userDefaults setBool:YES forKey:@"DiarytutorialShowed"];
        [[DiaryViewController sharedDiaryViewController] showTurorialView];
    }
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[BabyData sharedBabyData] reloadData];
    });
    
}

- (void)reloadUserData
{
    [SocialNetwork initSocialNetwork];
    [[PumanBookModel bookModel] initialize];
    [[CartModel sharedCart] update:NO];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[MainTabBarController sharedMainViewController] refreshBabyInfoView];
    });
 
}

//
- (void)showLoginView
{
    [[MainTabBarController sharedMainViewController] setSelectedIndex:0];
    loginViewC = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:loginViewC.view];
    [loginViewC setControlBtnType:kCloseAndFinishButton];
    [loginViewC setTitle:@"欢迎使用扑满日记！" withIcon:nil];
    [loginViewC loginSetting];
    [loginViewC show];
    
}


- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
