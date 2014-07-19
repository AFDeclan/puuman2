//
//  MainTabBarController+MainTabBarControllerSkip.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-17.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MainTabBarController.h"


@interface MainTabBarController (MainTabBarControllerSkip)
- (void)showSettingView;
- (void)showDiary;
- (void)showShop;
- (void)selectedWithTag:(TypeTabBarButton)tag;
@end
