//
//  LoginViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-7.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "LoginStartView.h"
#import "LoginEndView.h"
#import "LoginPregnancyView.h"
#import "LoginBirthRegisterView.h"
#import "LoginCodeView.h"

#define kLoginsubViewWidth 704
#define kLoginsubViewHeight 1024

@interface LoginViewController : CustomPopViewController<LoginStartViewDelegate,EndViewDelegate>
{
    UIScrollView *changeView;
    LoginStartView *startView;
    LoginEndView *endView;
    LoginEndView *loadView;
    LoginPregnancyView *pregnancy;
    LoginBirthRegisterView *birth;
    LoginView loginView;
    LoginCodeView *loginCode;
    BOOL isBirthView;
    BOOL modifyMode;
    UIView *protocolNotiView;
}
- (void)loginSetting;
@end
