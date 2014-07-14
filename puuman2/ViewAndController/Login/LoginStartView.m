//
//  LoginStartView.m
//  puman
//
//  Created by 祁文龙 on 13-10-17.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "LoginStartView.h"
#import "ColorsAndFonts.h"
#import "UserInfo.h"
#import "UniverseConstant.h"
#import "CustomAlertViewController.h"
#import "BabyData.h"
#import "MainTabBarController.h"

@implementation LoginStartView

@synthesize delegate = _delegate;
@synthesize relation = _relation;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _relation = Relate_none;
        stateSelf = State_none;
        [self initialize];
    }
    return self;
}

- (void) initialize
{
    
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(0, 112, 704, 16)];
    [title setFont:PMFont2];
    [title setText:@"宝宝现在的状态是？"];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setTextColor:PMColor3];
    [title setBackgroundColor:[UIColor clearColor]];
    [self addSubview:title];
    goBirthViewButton=[[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 255, 224)];
    [goBirthViewButton.title setText:@"已出生"];
    [goBirthViewButton.title setTextColor:PMColor1];
    [goBirthViewButton.title setFont:PMFont2];
    [goBirthViewButton setIconImg:[UIImage imageNamed:@"pic_born_login.png"]];
    [goBirthViewButton adjustLayout];
    [goBirthViewButton addTarget:self action:@selector(goBirthView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:goBirthViewButton];
    [goBirthViewButton setBackgroundColor:PMColor5];

    goPregnancyViewButton=[[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 255, 224)];
    [goPregnancyViewButton.title setText:@"怀孕中"];
    [goPregnancyViewButton.title setTextColor:PMColor1];
    [goPregnancyViewButton.title setFont:PMFont2];
    [goPregnancyViewButton setIconImg:[UIImage imageNamed:@"pic_pre_login.png"]];
    [goPregnancyViewButton adjustLayout];
    [goPregnancyViewButton addTarget:self action:@selector(goPregnancyView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:goPregnancyViewButton];
    [goPregnancyViewButton setBackgroundColor:PMColor5];

    if ([[UserInfo sharedUserInfo] logined])
    {
        SetViewLeftUp(title, 0, 80);
        SetViewLeftUp(goBirthViewButton, 80, 112);
        SetViewLeftUp(goPregnancyViewButton, 368, 112);
    }else
    {
        
        SetViewLeftUp(title, 0, 112);
        SetViewLeftUp(goBirthViewButton, 80, 144);
        SetViewLeftUp(goPregnancyViewButton, 368, 144);
        UILabel *relate=[[UILabel alloc] initWithFrame:CGRectMake(0, 16, 704, 16)];
        [relate setFont:PMFont2];
        [relate setText:@"您是宝宝的？"];
        [relate setTextAlignment:NSTextAlignmentCenter];
        [relate setBackgroundColor:[UIColor clearColor]];
        [relate setTextColor:PMColor3];
        [self addSubview:relate];
        
        mother = [[AFTextImgButton alloc] initWithFrame:CGRectMake(80, 48, 256, 40)];
        [mother.title setText:@"妈妈"];
        [mother.title setTextColor:PMColor1];
        [mother.title setFont:PMFont2];
        [mother setIconImg:[UIImage imageNamed:@"icon_mom_diary.png"]];
        [mother adjustLayout];
        [mother setBackgroundColor:PMColor5];
        [mother addTarget:self action:@selector(motherSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:mother];
        
        father=[[AFTextImgButton alloc] initWithFrame:CGRectMake(368, 48, 256, 40)];
        [father.title setText:@"爸爸"];
        [father.title setTextColor:PMColor1];
        [father.title setFont:PMFont2];
        [father setIconImg:[UIImage imageNamed:@"icon_dad_diary.png"]];
        [father adjustLayout];
        [father setBackgroundColor:PMColor5];
        [father addTarget:self action:@selector(fatherSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:father];
        
        AFTextImgButton *goLoginViewButton=[[AFTextImgButton alloc] initWithFrame:CGRectMake(80, 424, 544, 40)];
        [goLoginViewButton.title setText:@"我已经有账号或邀请码"];
        [goLoginViewButton.title setTextColor:[UIColor whiteColor]];
        [goLoginViewButton.title setFont:PMFont2];
        [goLoginViewButton setIconImg:[UIImage imageNamed:@"tri_white_right.png"]];
        [goLoginViewButton adjustLayout];
        [goLoginViewButton setBackgroundColor:PMColor6];
        [goLoginViewButton addTarget:self action:@selector(goLoginloadView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:goLoginViewButton];

    }

    
}

- (void)motherSelected:(UIButton *)sender
{
    [MobClick event:umeng_event_click label:@"Mother_LoginStartView"];
    [mother selectedButton];
    [father unSelectedButton];
    _relation = Relate_mother;
    switch (stateSelf) {
        case State_birth:
            [self goBirthView:goBirthViewButton];
            break;
        case State_pre:
            [self goPregnancyView:goPregnancyViewButton];
            break;
        case State_none:

            break;
        default:
            break;
    }
}

- (void)fatherSelected:(UIButton *)sender
{
   [MobClick event:umeng_event_click label:@"Father_LoginStartView"];
      [father  selectedButton];
      [mother  unSelectedButton];
      _relation = Relate_father;
      switch (stateSelf) {
        case State_birth:
            [self goBirthView:goBirthViewButton];
            break;
        case State_pre:
            [self goPregnancyView:goPregnancyViewButton];
            break;
        case State_none:
            
            break;
        default:
            break;
    }
}

- (void)hideGoLoginBtn
{
    UIButton *btn = (UIButton *)[self viewWithTag:10];
    btn.alpha = 0;
}

- (void)goBirthView:(UIButton *)sender
{
    if([[UserInfo sharedUserInfo] logined]){
        
        [CustomAlertViewController showAlertWithTitle:@" 亲 您的宝贝降落人间了么" confirmHandler:^{
        
            [MobClick event:umeng_event_click label:@"Birth_LoginStartView"];
                stateSelf =State_birth;
                [goBirthViewButton selectedButton];
                [goPregnancyViewButton unSelectedButton];
               if ([[UserInfo sharedUserInfo] logined])
                {
                 [_delegate selectLoginView:kLoginBirthRegisterView];
            
                }else{
                    if (_relation == Relate_none) {
            
                     }else
                    {
                        [_delegate selectLoginView:kLoginBirthRegisterView];
                    }
                }
        
            }
         cancelHandler:^{
        
        
                        }];

    }  else{
    
        
        [MobClick event:umeng_event_click label:@"Birth_LoginStartView"];
        stateSelf =State_birth;
        [goBirthViewButton selectedButton];
        [goPregnancyViewButton unSelectedButton];
        if ([[UserInfo sharedUserInfo] logined])
        {
            [_delegate selectLoginView:kLoginBirthRegisterView];
            
        }else{
            if (_relation == Relate_none) {
                
            }else
            {
                [_delegate selectLoginView:kLoginBirthRegisterView];
            }
        }

       
    }
    
    
    
   
   
}
- (void)goPregnancyView:(UIButton *)sender
{
        [MobClick event:umeng_event_click label:@"Pregnancy_LoginStartView"];
        [goPregnancyViewButton selectedButton];
        [goBirthViewButton unSelectedButton];
        stateSelf =  State_pre;
        if ([[UserInfo sharedUserInfo] logined])
        {
            [_delegate selectLoginView:kLoginPregnancyRegisterView];
            
        }else{
            if (_relation == Relate_none) {
                
            }else
            {
                [_delegate selectLoginView:kLoginPregnancyRegisterView];
            }
        }
    
}
- (void)goLoginloadView:(UIButton *)sender
{
    [MobClick event:umeng_event_click label:@"LoginLoad_LoginStartView"];
    [_delegate selectLoginView:kLoginLoadView];
}

@end
