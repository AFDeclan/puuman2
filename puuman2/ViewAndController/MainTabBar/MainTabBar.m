//
//  MainTabBar.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MainTabBar.h"
#import "UniverseConstant.h"
#import "DiaryViewController.h"
#import "MainTabBarController+MainTabBarControllerSkip.h"

@implementation MainTabBar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initWithSelectBoard];
    }
    return self;
}

- (void)initWithSelectBoard
{
    selectedBoard = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 368)];
    [self addSubview:selectedBoard];
    
    bg_Btn = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 128)];
    [bg_Btn setImage:[UIImage imageNamed:@"pic1_circle_diary.png"]];
    [selectedBoard addSubview:bg_Btn];
    
    diaryBtn = [[MainTabBarButton alloc] initWithFrame:CGRectMake(0,24, 64, 80)];
    diaryBtn.animate = YES;
    diaryBtn.flagTag = kTypeTabBarOfDiary;
    diaryBtn.delegate = self;
    [selectedBoard addSubview:diaryBtn];
    [diaryBtn setSelected:YES];

    socialBtn = [[MainTabBarButton alloc] initWithFrame:CGRectMake(0,104, 64, 80)];
    socialBtn.animate = YES;
    socialBtn.flagTag = kTypeTabBarOfSocial;
    socialBtn.delegate = self;
    [selectedBoard addSubview:socialBtn];
    [socialBtn setSelected:NO];
    
    
    shopBtn = [[MainTabBarButton alloc] initWithFrame:CGRectMake(0,184, 64, 80)];
    shopBtn.animate = YES;
    shopBtn.flagTag = kTypeTabBarOfShop;
    shopBtn.delegate = self;
    [selectedBoard addSubview:shopBtn];
    [shopBtn setSelected:NO];
    
    settingBtn = [[MainTabBarButton alloc] initWithFrame:CGRectMake(0, 688, 64, 80)];
    settingBtn.animate = NO;
    settingBtn.flagTag = kTypeTabBarOfSetting;
    settingBtn.delegate = self;
    [settingBtn setSelected:NO];
    [self addSubview:settingBtn];
    selectedBtn = nil;
}

- (void)clickAFButtonWithButton:(AFButton *)button
{
    
    if (button.flagTag == kTypeTabBarOfSetting) {
        [[MainTabBarController sharedMainViewController] showSettingView];
    }else{
        if (selectedBtn) {
            [selectedBtn setSelected:NO];
        }
        [(MainTabBarButton *)button setSelected:YES];
        selectedBtn = (MainTabBarButton *)button;
        [[MainTabBarController sharedMainViewController] selectedWithTag:button.flagTag];
        [UIView animateWithDuration:MainTabBarButtonanimateTime animations:^{
            SetViewLeftUp(bg_Btn,0,(button.flagTag - 1)*80);
        }];
    }

 
}


-(void)setVerticalFrame
{
    self.frame = CGRectMake(0, 0, 80, 1024);
    SetViewLeftUp(selectedBoard, 0, 328);
    SetViewLeftUp(settingBtn, 0, 944);
}

-(void)setHorizontalFrame
{
    self.frame = CGRectMake(0,0, 80, 768);
    SetViewLeftUp(selectedBoard, 0, 150);
    SetViewLeftUp(settingBtn, 0, 688);
}

- (void)selectedWithTag:(TypeTabBarButton)tag
{
    switch (tag) {
        case kTypeTabBarOfDiary:
        {
            [[DiaryViewController alloc] refresh];
            [self clickAFButtonWithButton:diaryBtn];
            return;
        }
        case kTypeTabBarOfSocial:
        {
            [self clickAFButtonWithButton:socialBtn];
            return;
        }
        case kTypeTabBarOfShop:
        {
            [self clickAFButtonWithButton:shopBtn];
            return;
        }
            
        default:
            break;
    }

}

@end
