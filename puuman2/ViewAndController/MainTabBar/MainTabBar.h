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
@interface MainTabBar : UIView<AFButtonDelegate>
{
    UIView *selectedBoard;
    MainTabBarButton *diaryBtn;
    MainTabBarButton *socialBtn;
    MainTabBarButton *shopBtn;
    MainTabBarButton *settingBtn;
    MainTabBarButton *selectedBtn;
    UIImageView *bg_Btn;
    
}
@property(assign,nonatomic)id<MainTabBarDelegate> delegate;
- (void)selectedWithTag:(TypeTabBarButton )tag;
-(void)setVerticalFrame;
-(void)setHorizontalFrame;
@end

@protocol MainTabBarDelegate <NSObject>
- (void)selectedWithTag:(TypeTabBarButton)tag;
- (void)showSettingView;
@end