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
#import "VideoShowView.h"
#import "VideoShowButton.h"
#import "PuuamnShowView.h"
#import "BabyView.h"
#import "BabyShowButton.h"

#define IMG_DIARY_H @"bg_h.png"
#define IMG_DIARY_V @"bg.png"

@interface MainTabBarController : UITabBarController<UITabBarControllerDelegate,MainTabBarDelegate,UITextViewDelegate,PopViewDelegate,VideoShowButtonDelegate,VideoShowViewDelegate>
{
    MainTabBar *tabBar;
    UIImageView *bgImgView;
    LoginViewController *loginViewC;
    UserInfo *userInfo;
    AutoImportViewController *improtAutoVC;
    ChatInputViewController *inputVC;
    SettingViewController *settingVC;
    VideoShowView *videoView;
    VideoShowButton *videoBtn;
    NSTimer *timer;
    float progress;
    NSString *videoPath;
    PuuamnShowView *puumanView;
    BabyView *infoView;
    BabyShowButton *babyShowBtn;
    UIButton *babyInfoBtn;
    UIView *diaryTurorialView;

}

@property(assign,nonatomic) BOOL isVertical;
@property(assign,nonatomic) BOOL refresh_HV;
@property(assign,nonatomic) BOOL isReply;
@property(assign,nonatomic) BOOL videoShowed;
@property(assign,nonatomic) BOOL hasShareVideo;

//@property(assign,nonatomic) BOOL loadingVideo;

+ (MainTabBarController *)sharedMainViewController;
+ (void)showHud:(NSString *)text;
+ (void)showHudCanCancel:(NSString *)text;
+ (void)hideHud;
- (void)startGif;
- (void)goToShopWithParentIndex:(NSInteger)parentMenu andChildIndex:(NSInteger)childMenu;
- (void)initautoImportView;
- (void)removeAutoImportView;
- (void)showAutoImportView;
- (void)hiddenBottomInputView;
- (void)updatePuumanData;
- (void)refreshBabyInfoView;

@end
