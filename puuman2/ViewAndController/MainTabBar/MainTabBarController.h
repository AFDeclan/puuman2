//
//  MainTabBarController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBar.h"
#import "LoginViewController.h"
#import "UserInfo.h"
#define IMG_DIARY_H @"bg_h.png"
#define IMG_DIARY_V @"bg.png"


@interface MainTabBarController : UITabBarController<UITabBarControllerDelegate,MainTabBarDelegate>
{
    MainTabBar *tabBar;
    UIImageView *bgImgView;
    LoginViewController *loginViewC;
    UserInfo *userInfo;
}

@property(assign,nonatomic) BOOL isVertical;

+ (MainTabBarController *)sharedMainViewController;

@end
