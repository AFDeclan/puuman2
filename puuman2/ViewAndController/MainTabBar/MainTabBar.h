//
//  MainTabBar.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarButton.h"

@protocol MainTabBarDelegate;
@interface MainTabBar : UIView
{
    UIView *selectedBoard;
    MainTabBarButton *diaryBtn;
    MainTabBarButton *babyInfoBtn;
    MainTabBarButton *socialBtn;
    MainTabBarButton *shopBtn;
    UIButton *settingBtn;
    MainTabBarButton *selectedBtn;
    UIImageView *bg_Btn;
    BOOL animating;
}
@property(assign,nonatomic)id<MainTabBarDelegate> delegate;
-(void)setVerticalFrame;
-(void)setHorizontalFrame;
@end

@protocol MainTabBarDelegate <NSObject>
- (void)selectedWithTag:(NSInteger)tag;
- (void)showSettingView;
@end