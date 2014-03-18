//
//  LoginEndView.h
//  puman
//
//  Created by 祁文龙 on 13-10-17.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "ColorButton.h"

@protocol EndViewDelegate;
@interface LoginEndView : UIView<UITextFieldDelegate>
{
    UILabel *_userNameLabel;
    UILabel *_passwordLabel;
    CustomTextField *_userField;
    CustomTextField *_pwdField;
    ColorButton *_loginBtn;
    ColorButton *_registerBtn;
    ColorButton *_resetPwdBtn;
    ColorButton *_inviteCodeBtn;
    UILabel *_inviteCodeLabel;
    
    BOOL _hasInviteCode;
    UIView *protocolView;
    UIButton *detailBtn;
}
@property (assign,nonatomic) id <EndViewDelegate> delegate;
- (void)theViewIsEndView:(BOOL)isEndView;
- (void)resigntextField;

@property (retain, nonatomic) NSString *babyName;
@property (assign, nonatomic) BOOL whetherBirth;
@property (assign, nonatomic) BOOL isBoy;
@property (retain, nonatomic) NSDate *birthDate;
@property (assign, nonatomic) enum userIdentity identity;

@end
@protocol EndViewDelegate <NSObject>
@optional
- (void)forget;
@end