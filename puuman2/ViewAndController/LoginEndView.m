//
//  LoginEndView.m
//  puman
//
//  Created by 祁文龙 on 13-10-17.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "LoginEndView.h"
#import "ColorsAndFonts.h"
#import "CustomAlertViewController.h"
#import "UserInfo.h"
#import "MainTabBarController.h"
#import "DateFormatter.h"
#import "RegisterForm.h"
//#import "ProtocalViewController.h"

@implementation LoginEndView
@synthesize delegate = _delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}
- (void) initialize
{
  
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(0, 16, 704, 16)];
    [title setFont:PMFont2];
    [title setText:@"注册一个扑满日记账号吧！"];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setTextColor:PMColor3];
    title.tag = 10;
    [self addSubview:title];
    
    UIImageView *icon=[[UIImageView alloc] initWithFrame:CGRectMake(280, 48, 144, 180) ];
    [icon setImage:[UIImage imageNamed:@"pic_puuman_login_diary.png"]];
    [icon setBackgroundColor:[UIColor clearColor]];
    [self addSubview:icon];
    
    _userNameLabel=[[UILabel alloc] initWithFrame:CGRectMake(140, 274,68, 16)];
    [_userNameLabel setFont:PMFont2];
    [_userNameLabel setText:@"用户名"];
    [_userNameLabel setTextAlignment:NSTextAlignmentRight];
    [_userNameLabel setTextColor:PMColor1];
    [self addSubview:_userNameLabel];
    
    _passwordLabel=[[UILabel alloc] initWithFrame:CGRectMake(140, 336, 68, 16)];
    [_passwordLabel setFont:PMFont2];
    [_passwordLabel setText:@"密码"];
    [_passwordLabel setTextAlignment:NSTextAlignmentRight];
    [_passwordLabel setTextColor:PMColor1];
    [self addSubview:_passwordLabel];
 
    _userField = [[CustomTextField alloc] initWithFrame:CGRectMake(240, 256,256, 48)];
    [_userField setPlaceholder:@"常用邮箱或手机"];
    [_userField setDelegate:self];
    [self addSubview:_userField];
    
    _pwdField = [[CustomTextField alloc] initWithFrame:CGRectMake(240, 320, 256, 48)];
    [self addSubview:_pwdField];
    
    
    _registerBtn = [[ColorButton alloc] init];
    [_registerBtn initWithTitle:@"注册" andButtonType:kBlueLeft];
    [_registerBtn addTarget:self action:@selector(registerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_registerBtn];
    SetViewLeftCenter(_registerBtn, 592, 443);
    
    _loginBtn = [[ColorButton alloc] init];
    [_loginBtn initWithTitle:@"登陆" andButtonType:kBlueLeftDown];
    [_loginBtn addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginBtn];
     SetViewLeftCenter(_loginBtn, 592, 443);
    
    _resetPwdBtn = [[ColorButton alloc] init];
    [_resetPwdBtn initWithTitle:@"  忘记密码？" andButtonType:kGrayLeft];
    [_resetPwdBtn addTarget:self action:@selector(forgetBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_resetPwdBtn];
     SetViewLeftCenter(_resetPwdBtn, 592, 331);
    
    _inviteCodeBtn = [[ColorButton alloc ]init];
    [_inviteCodeBtn initWithTitle:@"我有邀请码" andButtonType:kRedLeftUp];
    [_inviteCodeBtn addTarget:self action:@selector(inviteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_inviteCodeBtn];
    _hasInviteCode = NO;
    SetViewLeftCenter(_inviteCodeBtn, 592, 403);
    UIGestureRecognizer  *hidden = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resigntextField)];
    [self addGestureRecognizer:hidden];
}



- (void)forgetBtnPressed:(UIButton *)sender
{
    [MobClick event:umeng_event_click label:@"Forget_LoginEndView"];
    [_delegate forget];
}

- (void)theViewIsEndView:(BOOL)isEndView
{
    if (isEndView) {
        [_registerBtn setAlpha:1];
        [_loginBtn setAlpha:0];
        [_resetPwdBtn setAlpha:0];
        [_pwdField setSecureTextEntry:NO];
        [_inviteCodeBtn setAlpha:0];
         [protocolView setAlpha:1];
        return;
    }
    [_pwdField setSecureTextEntry:YES];
    [_resetPwdBtn setAlpha:1];
    [_registerBtn setAlpha:0];
    [_loginBtn setAlpha:1];
    [_inviteCodeBtn setAlpha:1];
    UILabel *title = (UILabel *)[self viewWithTag:10];
    [title setText:@"登陆您的扑满日记账号吧！"];
}



- (void)inviteBtnClicked
{
    _hasInviteCode = !_hasInviteCode;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished){
        if (_hasInviteCode)
        {
            _userNameLabel.text = @"邀请码";
            _userField.placeholder = @"输入您的邀请码";
            _passwordLabel.text = @"设置密码";
            _pwdField.secureTextEntry = NO;
            _inviteCodeLabel.text = @"我没有邀请码";
            [_loginBtn setImage:[UIImage imageNamed:@"btn_reg_login_diary.png"] forState:UIControlStateNormal];
            UILabel *title = (UILabel *)[self viewWithTag:10];
            [title setText:@"用邀请码注册您的扑满日记账号吧！"];
        }
        else
        {
            _userNameLabel.text = @"用户名";
            _userField.placeholder = @"常用邮箱或手机";
            _passwordLabel.text = @"密码";
            _pwdField.secureTextEntry = YES;
            _inviteCodeLabel.text = @"我有邀请码";
            [_loginBtn setImage:[UIImage imageNamed:@"btn2_login_diary.png"] forState:UIControlStateNormal];
            UILabel *title = (UILabel *)[self viewWithTag:10];
            [title setText:@"登陆您的扑满日记账号吧！"];
        }
        [UIView animateWithDuration:0.2 animations:^{self.alpha = 1;}];
    }];
}

- (void)resigntextField
{
    [_userField resignFirstResponder];
    [_pwdField resignFirstResponder];
}

- (void)loginButtonPressed:(UIButton *)sender
{
    if (_hasInviteCode)
    {
        [MobClick event:umeng_event_click label:@"RegisterWithCode_LoginEndView"];
        [self resigntextField];
        if (![self passWordIsRight])
        {

            [CustomAlertViewController showAlertWithTitle:@"请输入密码" andContrlType:kNoneButton];
            return;
        }
        enum userActionResult ret = [[RegisterForm sharedForm] registerUserWithInvitationCode:_userField.text password:_pwdField.text];
        switch (ret) {
            case succeeded:
            {
//                [CustomAlertView showInView:nil content:@"注册成功！欢迎开始您的扑满日记~"confirmHandler:^{
//                    [[UserInfo sharedUserInfo] login];
//                }];
                break;
            }
            case timeOut:
              //  [CustomAlertView showInView:nil content:@"您当前的网络链接存在问题，请检查后再试"];
                break;
            case dumplicated:
             //   [CustomAlertView showInView:nil content:@"注册失败，用户已注册！"];
                break;
            case checkFailed:
             //   [CustomAlertView showInView:nil content:@"注册失败，邀请码有误或已过期！"];
                break;
            default:
              //  [CustomAlertView showInView:nil content:@"服务器异常"];
                break;
        }
        return;
    }
    [MobClick event:umeng_event_click label:@"Login_LoginEndView"];
    [self resigntextField];
    if ([self usernameIsRight] && [self passWordIsRight]) {
    
        UserInfo *userInfo = [UserInfo sharedUserInfo];
        if ([self usernameIsMailAddr])
        {
            userInfo.mailAddr = _userField.text;
            userInfo.phoneNum = @"";
        }
        else
        {
            userInfo.mailAddr = @"";
            userInfo.phoneNum = _userField.text;
        }

         userInfo.pwd = _pwdField.text;
        //[MainViewController showHud:@"登陆中..."];
        UserActionResult result = [userInfo login];
        //[MainViewController hideHud];
        switch (result) {
            case succeeded:
                //[CustomAlertView showInView:nil content:@"登录成功，开始您的扑满日记吧"];
                break;
            case checkFailed:
               // [CustomAlertView showInView:nil content:@"登陆失败，用户名或密码错误。"];
                break;
            case timeOut:
              //  [CustomAlertView showInView:nil content:@"登陆失败，请检查联网状态。"];
                break;
            default:
            //    [CustomAlertView showInView:nil content:@"服务器异常。"];
                break;
        }
    }
    else
    {
      //  [CustomAlertView showInView:nil content:@"账号不存在或密码错误,请检查后登陆"];
    }
    
}


- (BOOL)usernameIsPhoneNum
{
    return [self validateMobile:_userField.text];
}

- (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)usernameIsMailAddr
{
    NSString *username = _userField.text;
    NSRange range = [username rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"@"]];
    if (range.location != NSNotFound) return YES;
    else return NO;
}

- (BOOL)usernameIsRight
{
    return [self usernameIsMailAddr] || [self usernameIsPhoneNum];
}

- (BOOL)passWordIsRight
{
    if (_pwdField.text.length > 0)
        return YES;
    else return NO;
}

- (void)registerButtonPressed:(UIButton *)sender
{
    
    [MobClick event:umeng_event_click label:@"Register_LoginEndView"];
         [self resigntextField];
    if ([self usernameIsRight] && [self passWordIsRight])
    {
        RegisterForm *regForm = [RegisterForm sharedForm];
        regForm.birthDay = self.birthDate;
        regForm.isBoy = self.isBoy;
        regForm.relationIdentity = self.identity;
        regForm.whetherBirth = self.whetherBirth;
        regForm.nickName = self.babyName;
        NSString *mail = @"";
        NSString *phoneNum = @"";
        if ([self usernameIsPhoneNum])
        {
            phoneNum = _userField.text;
        }
        else
        {
            mail = _userField.text;
        }
      //  [MainViewController showHud:@"正在处理注册请求，请稍后.."];
        enum userActionResult result = [regForm registerUserWithMail:mail phoneNum:phoneNum password:_pwdField.text];
     //   [MainViewController hideHud];
        switch (result) {
            case succeeded:
            {
      //          [CustomAlertView showInView:nil content:@"注册成功！欢迎开始您的扑满日记~"confirmHandler:^{[self loginButtonPressed:nil];}];
                break;
            }
            case timeOut:
        //        [CustomAlertView showInView:nil content:@"您当前的网络链接存在问题，请检查后再试"];
                break;
            case dumplicated:
        //        [CustomAlertView showInView:nil content:@"当前邮箱或手机已被注册，请尝试使用其他其他邮箱注册" ];
                break;
            default:
             //   [CustomAlertView showInView:nil content:@"服务器异常，请稍后再试"];
                break;
        }
    }else
    {
        if (![self usernameIsRight])
        {
       //     [CustomAlertView showInView:nil content:@"请正确输入邮箱或手机号码"];
        }
        else
        {
       //     [CustomAlertView showInView:nil content:@"请输入密码"];
        }
    }
    
}

@end