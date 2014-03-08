//
//  MainTabBarController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MainTabBarController.h"
#import "UniverseConstant.h"


@interface MainTabBarController ()

@end
static MainTabBarController *instance;
@implementation MainTabBarController
@synthesize isVertical = _isVertical;

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
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tabBar removeFromSuperview];
    [self initWithTabBar];
    userInfo = [UserInfo sharedUserInfo];

    
}

- (void)viewDidAppear:(BOOL)animated
{
    if (![userInfo loginFromUserDefault])
    {
        [self showLoginView];
    }
    else
    {
    }
}

- (void)initWithTabBar
{
    tabBar  = [[MainTabBar alloc] initWithFrame:CGRectMake(0, 0, 64, 0)];
    [tabBar setDelegate:self];
    [self.view addSubview:tabBar];
    
    bgImgView = [[UIImageView alloc] init];
    [self.view insertSubview:bgImgView atIndex:0];
}

 -(void)selectedWithTag:(NSInteger)tag
{
    [self setSelectedIndex:tag-1];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    
    return YES;
}

- (BOOL)shouldAutorotate
{
    
    return YES;
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    UIInterfaceOrientation interfaceOrientation=[[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationPortraitUpsideDown) {
        //翻转为竖屏时
        [self setVerticalFrame];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_Vertical object:nil];
        
        
    }else if (interfaceOrientation==UIDeviceOrientationLandscapeLeft || interfaceOrientation == UIDeviceOrientationLandscapeRight) {
        //翻转为横屏时
        
        [self setHorizontalFrame];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_Horizontal object:nil];
    }
}

-(void)setVerticalFrame
{
    _isVertical = YES;
    [tabBar setVerticalFrame];
    [bgImgView setImage:[UIImage imageNamed:IMG_DIARY_V]];
    [bgImgView setFrame:CGRectMake(0, 0, 768, 1024)];
    
}

-(void)setHorizontalFrame
{
    _isVertical = NO;
    [tabBar setHorizontalFrame];
    [bgImgView setImage:[UIImage imageNamed:IMG_DIARY_H]];
    [bgImgView setFrame:CGRectMake(0, 0, 1024, 768)];
}

- (void)showLoginView
{
    loginViewC = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
    [self.view addSubview:loginViewC.view];
    [loginViewC setControlBtnType:kCloseAndFinishButton];
    [loginViewC setTitle:@"欢迎使用扑满日记！" withIcon:nil];
    [loginViewC loginSetting];
    [loginViewC show];
}

- (void)userChanged
{
    [loginViewC loginSucceed];
}

- (void)showSettingView
{

}

@end
