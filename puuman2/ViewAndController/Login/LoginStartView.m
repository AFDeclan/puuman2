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
    [self addSubview:title];
    
    goBirthViewButton=[[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 255, 224)];
    [goBirthViewButton setTitle:@"已出生" andImg:[UIImage imageNamed:@"pic_born_login.png"] andButtonType:kButtonTypeThree];
    [goBirthViewButton setTitleLabelColor:PMColor1];
    [goBirthViewButton addTarget:self action:@selector(goBirthView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:goBirthViewButton];
    
    goPregnancyViewButton=[[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 255, 224)];
    [goPregnancyViewButton setTitle:@"怀孕中" andImg:[UIImage imageNamed:@"pic_pre_login.png"] andButtonType:kButtonTypeThree];
    [goPregnancyViewButton setTitleLabelColor:PMColor1];
    [goPregnancyViewButton addTarget:self action:@selector(goPregnancyView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:goPregnancyViewButton];
    
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
        [relate setTextColor:PMColor3];
        [self addSubview:relate];
        
        mother = [[AFTextImgButton alloc] initWithFrame:CGRectMake(80, 48, 256, 40)];
        [mother setTitle:@"妈妈" andImg:[UIImage imageNamed:@"icon_mom_diary.png"] andButtonType:kButtonTypeTwo];
        [mother setTitleLabelColor:PMColor1];
        [mother addTarget:self action:@selector(motherSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:mother];
        
        father=[[AFTextImgButton alloc] initWithFrame:CGRectMake(368, 48, 256, 40)];
        [father setTitle:@"爸爸" andImg:[UIImage imageNamed:@"icon_dad_diary.png"] andButtonType:kButtonTypeTwo];
        [father setTitleLabelColor:PMColor1];
        [father addTarget:self action:@selector(fatherSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:father];
        AFTextImgButton *goLoginViewButton=[[AFTextImgButton alloc] initWithFrame:CGRectMake(80, 424, 544, 40)];
        [goLoginViewButton setTitle:@"我已经有账号或邀请码" andImg:[UIImage imageNamed:@"tri_white_right.png"] andButtonType:kButtonTypeFour];
        [goLoginViewButton setTitleLabelColor:[UIColor whiteColor]];
        [goLoginViewButton addTarget:self action:@selector(goLoginloadView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:goLoginViewButton];

    }

    
}

- (void)motherSelected:(UIButton *)sender
{
    [MobClick event:umeng_event_click label:@"Mother_LoginStartView"];
    [mother selected];
    [father unSelected];
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
      [father  selected];
      [mother  unSelected];
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
     [MobClick event:umeng_event_click label:@"Birth_LoginStartView"];
    stateSelf =State_birth;
    [goBirthViewButton selected];
    [goPregnancyViewButton unSelected];
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
- (void)goPregnancyView:(UIButton *)sender
{
    
    [MobClick event:umeng_event_click label:@"Pregnancy_LoginStartView"];
    [goPregnancyViewButton selected];
    [goBirthViewButton unSelected];
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
