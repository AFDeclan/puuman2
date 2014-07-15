//
//  LoginStartView.h
//  puman
//
//  Created by 祁文龙 on 13-10-17.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginStartStatusSelectedButton.h"

@protocol LoginStartViewDelegate;
typedef enum
{
    kLoginStartView = 0,
    kLoginBirthRegisterView,
    kLoginPregnancyRegisterView,
    kLoginEndView,
    kLoginLoadView,
    kLoginCodeView
    
}LoginView;

typedef enum
{
    Relate_mother,
    Relate_father,
    Relate_none
}Relation;
typedef enum
{
    State_birth,
    State_pre,
    State_none
}State;
@interface LoginStartView : UIView
{
    AFSelectedButton *mother;
    AFSelectedButton *father;
    LoginStartStatusSelectedButton *goBirthViewButton;
    LoginStartStatusSelectedButton *goPregnancyViewButton;
    State stateSelf;
}
@property (nonatomic, weak) id<LoginStartViewDelegate> delegate;
@property (nonatomic, assign) Relation relation;

- (void)hideGoLoginBtn;
@end

@protocol LoginStartViewDelegate <NSObject>
@optional
- (void)selectLoginView:(LoginView)login;
@end