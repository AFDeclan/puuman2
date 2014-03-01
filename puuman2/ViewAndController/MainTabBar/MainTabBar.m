//
//  MainTabBar.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MainTabBar.h"
#import "UniverseConstant.h"

@implementation MainTabBar
@synthesize delegate = _delegate;
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
    animating = NO;
    selectedBoard = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 368)];
    [self addSubview:selectedBoard];
    
    bg_Btn = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 128)];
    [bg_Btn setImage:[UIImage imageNamed:@"pic1_circle_diary.png"]];
    [selectedBoard addSubview:bg_Btn];
    
    diaryBtn = [[MainTabBarButton alloc] initWithFrame:CGRectMake(0,24, 64, 80)];
    diaryBtn.tag = 1;
    [diaryBtn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
    diaryBtn.normalImage = [UIImage imageNamed:@"btn_diary2_diary.png"];
    diaryBtn.selectedImage = [UIImage imageNamed:@"btn_diary1_diary.png"];
    [diaryBtn setSelected:YES withAnimate:NO];
    [selectedBoard addSubview:diaryBtn];
    
    babyInfoBtn = [[MainTabBarButton alloc] initWithFrame:CGRectMake(0,104, 64, 80)];
    babyInfoBtn.tag = 2;
    [babyInfoBtn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
    babyInfoBtn.normalImage = [UIImage imageNamed:@"btn_baby2_diary.png"];
    babyInfoBtn.selectedImage = [UIImage imageNamed:@"btn_baby1_diary.png"];
    [selectedBoard addSubview:babyInfoBtn];
      [babyInfoBtn setSelected:NO];
    socialBtn = [[MainTabBarButton alloc] initWithFrame:CGRectMake(0,184, 64, 80)];
    socialBtn.tag = 3;
    [socialBtn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
    socialBtn.normalImage = [UIImage imageNamed:@"btn_happen2_diary.png"];
    socialBtn.selectedImage = [UIImage imageNamed:@"btn_happen1_diary.png"];
    [selectedBoard addSubview:socialBtn];
      [socialBtn setSelected:NO];
    shopBtn = [[MainTabBarButton alloc] initWithFrame:CGRectMake(0,264, 64, 80)];
    shopBtn.tag = 4;
    [shopBtn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
    shopBtn.normalImage = [UIImage imageNamed:@"btn_shop2_diary.png"];
    shopBtn.selectedImage = [UIImage imageNamed:@"btn_shop1_diary.png"];
    [selectedBoard addSubview:shopBtn];
    [shopBtn setSelected:NO];
    selectedBtn = diaryBtn;
    settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 688, 64, 80)];
    [settingBtn setImage:[UIImage imageNamed:@"btn_set2_diary.png"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:settingBtn];
}

- (void)clickedBtn:(MainTabBarButton *)sender
{
    
    if (!animating) {
        [selectedBtn setSelected:NO];
        [sender setSelected:YES];
        selectedBtn = sender;
        NSInteger tag = sender.tag;
        NSLog(@"%d",tag);
        [_delegate selectedWithTag:tag];
        animating = YES;
        [UIView animateWithDuration:animateTime animations:^{
            SetViewLeftUp(bg_Btn,0,(tag-1)*80);
        }completion:^(BOOL finished) {
            animating = NO;
        }];
    }

}

- (void)settingBtnPressed
{
    [_delegate showSettingView];
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
@end
