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
#import "SkipViewController.h"
#import "CustomAlertViewController.h"
#import "Models.h"
#import "NSString+VersionCompare.h"

@implementation AppDelegate
@synthesize rootTabBarC = _rootTabBarC;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self initWithContent];
    [self initialUmeng];
    
    [self initialSocialNetWork];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)initialSocialNetWork
{
    [SocialNetwork initSocialNetwork];
}


- (void)initWithContent
{
    _rootTabBarC = [MainTabBarController sharedMainViewController];
    DiaryViewController *diaryVC = [DiaryViewController sharedDiaryViewController];
    BabyInfoViewController *babyInfoVC = [[BabyInfoViewController alloc] init];
    SocialViewController *socialVC = [[SocialViewController alloc] init];
    ShopViewController *shopVC = [[ShopViewController alloc] init];
    SkipViewController *skipVC = [[SkipViewController alloc] init];
    [_rootTabBarC addChildViewController:skipVC];
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
//    [MobClick checkUpdateWithDelegate:self selector:@selector(appUpdate:)];
    [self checkUpdate];
    PostNotification(Noti_Refresh, nil);
}

- (void)checkUpdate
{
    [ASIHTTPRequest setSessionCookies:nil];
    NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@", APPID]];
    ASIHTTPRequest* request = [[ASIHTTPRequest alloc] initWithURL:url];
    request.delegate = self;
    [request setTimeOutSeconds:5];
    [request setTag:1];
    [request setRequestMethod:@"GET"];
    [request startAsynchronous];
}

#pragma mark - Umeng and Update

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSError* parseError = nil;
    id result =[[request responseData] objectFromJSONDataWithParseOptions:JKParseOptionStrict error:&parseError];
    if ( parseError )
    {
        [ErrorLog errorLog:@"JSON Error" fromFile:@"AppDelegate.m" error:parseError];
    }
    else
    {
        NSArray* appInfo = [NSArray arrayWithArray:[result objectForKey:@"results"]];
        NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setValue:appInfo forKey:APPINFO];
        [userDefault synchronize];
        NSString* receivedVersion = @"";
        NSString* trackViewUrl = @"";
        for( id conf in appInfo ){
            receivedVersion = [conf objectForKey:@"version"];
            trackViewUrl = [conf objectForKey:@"trackViewUrl"];
            break;
        }
        NSString* currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        if( [currentVersion earlierThenVersion:receivedVersion] && ![currentVersion isEqualToString:@""])
        {
            
            [CustomAlertViewController showAlertWithTitle:[NSString stringWithFormat:@"扑满日记有新版本（%@）咯~~请前往更新。",receivedVersion] confirmRightHandler:^{
             //   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];
            }];
            
        }
    }
}

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

//- (void)appUpdate:(NSDictionary *)appInfo
//{
//    if ([[appInfo valueForKey:@"update"] boolValue])
//    {
//        NSString *newVersion = [appInfo valueForKey:@"version"];
//        NSString *hint = [NSString stringWithFormat:@"扑满日记有新版本（%@）咯~~请前往更新。", newVersion];
//        NSString *trackViewUrl = [appInfo valueForKey:@"path"];
//        [CustomAlertViewController showAlertWithTitle:hint confirmRightHandler:^{
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];
//        }];
//
//    }
//}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [[MainTabBarController sharedMainViewController] removeAutoImportView];
    [userDefaults setObject:[NSDate date] forKey:@"closeDate"];
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults valueForKey:@"autoImport"]) {
        [userDefaults setObject:@"YES" forKey:@"autoImport"];
    }
    if ([[userDefaults valueForKey:@"autoImport"] boolValue]&&[[UserInfo sharedUserInfo] logined]) {
        [[MainTabBarController sharedMainViewController] initautoImportView];
        
    }
    
  
  

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

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [SocialNetwork handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [SocialNetwork handleOpenURL:url];
}


@end
