//
//  MainTabBar.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MainTabBarDelegate;
@interface MainTabBar : UIView
{
    UIView *selectedBoard;
    UIButton *diaryBtn;
    UIButton *babyInfoBtn;
    UIButton *socialBtn;
    UIButton *shopBtn;
    UIButton *settingBtn;
}
@property(assign,nonatomic)id<MainTabBarDelegate> delegate;
-(void)setVerticalFrame;
-(void)setHorizontalFrame;
@end

@protocol MainTabBarDelegate <NSObject>
- (void)selectedWithTag:(NSInteger)tag;
@end