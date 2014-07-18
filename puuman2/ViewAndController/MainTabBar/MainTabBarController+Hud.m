//
//  MainTabBarController+Hud.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-18.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MainTabBarController+Hud.h"

#import "MBProgressHUD.h"
static MBProgressHUD *hud;
@implementation MainTabBarController (Hud)
#pragma mark - Hud


+ (void)showHudCanCancel:(NSString *)text
{
    MainTabBarController *viewCon = [self sharedMainViewController];
    if (!hud)
    {
        hud = [[MBProgressHUD alloc] initWithView:viewCon.view];
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelHud)];
        [hud addGestureRecognizer:tap];
    }
    else return;
    hud.labelText = text;
    [viewCon.view addSubview:hud];
    [hud show:YES];
}

+ (void)hideHud
{
    [hud removeFromSuperview];
    hud = nil;
}

+ (void)cancelHud
{
    [self hideHud];
    PostNotification(Noti_HudCanceled, nil);
}

+ (void)showHud:(NSString *)text
{
    MainTabBarController *viewCon = [self sharedMainViewController];
    if (!hud)
    {
        hud = [[MBProgressHUD alloc] initWithView:viewCon.view];
    }
    else return;
    hud.labelText = text;
    [viewCon.view addSubview:hud];
    [hud show:YES];
}
@end
