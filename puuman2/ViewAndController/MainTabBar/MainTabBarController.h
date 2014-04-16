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
#import "AutoImportViewController.h"
#import "ChatInputViewController.h"
#import "SettingViewController.h"

#define IMG_DIARY_H @"bg_h.png"
#define IMG_DIARY_V @"bg.png"

@interface MainTabBarController : UITabBarController<UITabBarControllerDelegate,MainTabBarDelegate,UITextViewDelegate,PopViewDelegate>
{
    MainTabBar *tabBar;
    UIImageView *bgImgView;
    LoginViewController *loginViewC;
    UserInfo *userInfo;
    AutoImportViewController *improtAutoVC;
    ChatInputViewController *inputVC;
    SettingViewController *settingVC;
}

@property(assign,nonatomic) BOOL isVertical;
@property(assign,nonatomic) BOOL refresh_HV;
@property(assign,nonatomic) BOOL isReply;

+ (MainTabBarController *)sharedMainViewController;
+ (void)showHud:(NSString *)text;
+ (void)showHudCanCancel:(NSString *)text;
+ (void)hideHud;
- (void)goToShopWithParentIndex:(NSInteger)parentMenu andChildIndex:(NSInteger)childMenu;
- (void)initautoImportView;
- (void)removeAutoImportView;
- (void)showAutoImportView;
- (void)hiddenBottomInputView;
@end
