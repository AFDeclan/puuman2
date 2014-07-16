//
//  SkipViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SkipViewController.h"
#import "MainTabBarController.h"
#import "UniverseConstant.h"
#import "Models.h"
#import "DiaryViewController.h"

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


    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  
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
    [[MainTabBarController sharedMainViewController] showDiary];
    [[MainTabBarController sharedMainViewController] refreshBabyInfoView];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults boolForKey:@"DiarytutorialShowed"]){
        [userDefaults setBool:YES forKey:@"DiarytutorialShowed"];
        [[DiaryViewController sharedDiaryViewController] showTurorialView];
    }
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
