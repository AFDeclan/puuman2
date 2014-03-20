//
//  AppDelegate.m
//  puuman2
//
//  Created by Declan on 14-2-22.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "DiaryViewController.h"
//#import "PuumanViewController.h"
#import "ShopViewController.h"
#import "BabyInfoViewController.h"
#import "SocialViewController.h"
#import "Models.h"
@implementation AppDelegate
@synthesize rootTabBarC = _rootTabBarC;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self initWithContent];
    [self initialUmeng];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)initWithContent
{
    _rootTabBarC = [MainTabBarController sharedMainViewController];
    DiaryViewController *diaryVC = [DiaryViewController sharedDiaryViewController];
    BabyInfoViewController *babyInfoVC = [[BabyInfoViewController alloc] init];
    SocialViewController *socialVC = [[SocialViewController alloc] init];
    ShopViewController *shopVC = [[ShopViewController alloc] init];
   
    [_rootTabBarC addChildViewController:diaryVC];
    [_rootTabBarC addChildViewController:babyInfoVC];
    [_rootTabBarC addChildViewController:socialVC];
    [_rootTabBarC addChildViewController:shopVC];
    self.window.rootViewController = _rootTabBarC;
    
}

#pragma mark - Refresh Net
- (void)refreshNet
{
    [[TaskModel sharedTaskModel] updateTasks];
    [[CartModel sharedCart] update:YES];
    [[UserInfo sharedUserInfo] updateUserInfo];
    [[DiaryModel sharedDiaryModel] updateDiaryFromServer];
    [MobClick updateOnlineConfig];
    [MobClick checkUpdateWithDelegate:self selector:@selector(appUpdate:)];
    PostNotification(Noti_Refresh, nil);
}

#pragma mark - Umeng and Update

- (void)initialUmeng
{
    //Umeng
    [MobClick startWithAppkey:umeng_appkey reportPolicy:(ReportPolicy) BATCH channelId:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    
}

- (void)onlineConfigCallBack:(NSNotification *)notification {
    NSLog(@"online config has fininshed and params = %@", notification.userInfo);
    NSString *noti = [notification.userInfo valueForKey:@"notification"];
    if (noti && ![noti isEqualToString:@"none"])
    {
    }
}

- (void)appUpdate:(NSDictionary *)appInfo
{
    if ([[appInfo valueForKey:@"update"] boolValue])
    {
        NSString *newVersion = [appInfo valueForKey:@"version"];
        NSString *hint = [NSString stringWithFormat:@"扑满日记有新版本（%@）咯~~请前往更新。", newVersion];
        NSString *trackViewUrl = [appInfo valueForKey:@"path"];
//        [CustomAlertView showInView:nil content:hint confirmHandler:^{
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];
//        }];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self refreshNet];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
