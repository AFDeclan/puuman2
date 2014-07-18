//
//  MainTabBarController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBar.h"
#import "UserInfo.h"
#import "AutoImportViewController.h"
#import "VideoShowView.h"
#import "VideoShowButton.h"
#import "BabyView.h"

#define IMG_DIARY_H @"bg_h.png"
#define IMG_DIARY_V @"bg.png"

@interface MainTabBarController : UITabBarController<UITabBarControllerDelegate,UITextViewDelegate,PopViewDelegate,VideoShowButtonDelegate,VideoShowViewDelegate>
{
    MainTabBar *tabBar;
    UIImageView *bgImgView;
    UserInfo *userInfo;
    AutoImportViewController *improtAutoVC;
    VideoShowView *videoView;
    VideoShowButton *videoBtn;
    
    BabyView *infoView;
    UIButton *babyInfoBtn;
    BOOL babyInfoShowed;
}

@property(assign,nonatomic) BOOL isVertical;
@property(assign,nonatomic) BOOL refresh_HV;
@property(assign,nonatomic) BOOL isReply;
@property(assign,nonatomic) BOOL videoShowed;
@property(assign,nonatomic) BOOL hasShareVideo;
@property(assign,nonatomic) BOOL babyInfoShowed;


//@property(assign,nonatomic) BOOL loadingVideo;

+ (MainTabBarController *)sharedMainViewController;




@end
