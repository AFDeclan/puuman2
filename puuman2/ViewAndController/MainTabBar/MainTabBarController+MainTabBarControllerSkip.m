//
//  MainTabBarController+MainTabBarControllerSkip.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-17.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MainTabBarController+MainTabBarControllerSkip.h"
#import "SettingViewController.h"



@implementation MainTabBarController (MainTabBarControllerSkip)

- (void)showDiary
{
    [tabBar selectedWithTag:kTypeTabBarOfDiary];
}

- (void)showShop
{
    [tabBar selectedWithTag:kTypeTabBarOfShop];
    PostNotification(Noti_RefreshMenu, nil);
    
}



-(void)selectedWithTag:(TypeTabBarButton)tag
{
    [self setSelectedIndex:tag];
}


- (void)showSettingView
{

    SettingViewController *settingVC = [[SettingViewController alloc] initWithNibName:nil bundle:nil];
    [settingVC show];
    [self.view addSubview:settingVC.view];
    
}


@end
