//
//  MainTabBarController+Hud.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-18.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController (Hud)
+ (void)showHud:(NSString *)text;
+ (void)showHudCanCancel:(NSString *)text;
+ (void)hideHud;
@end
