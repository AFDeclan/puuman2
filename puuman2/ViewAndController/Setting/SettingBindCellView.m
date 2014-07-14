//
//  SettingBindCellView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-17.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SettingBindCellView.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"
#import "UserNameCheck.h"
#import "UserInfo.h"
#import "CustomAlertViewController.h"
#import "CustomNotiViewController.h"
#import "MainTabBarController.h"

@implementation SettingBindCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
          [self initialization];
    }
    return self;
}

- (void)initialization
{
    isCheck = NO;
    numTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(0, 0, 544, 48)];
    [numTextField setTextAlignment:NSTextAlignmentLeft];
    [numTextField setDelegate:self];
    [numTextField setEnabled:NO];
    
    [self addSubview:numTextField];
    
    codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(456,0, 64, 48)];
    [codeLabel setText:@"(已验证)"];
    [codeLabel setFont:PMFont2];
    [codeLabel setTextColor:PMColor2];
    [codeLabel setBackgroundColor:[UIColor clearColor]];
    [codeLabel setAlpha:0];
    [self addSubview:codeLabel];
    
    settingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 544, 48)];
    [settingButton addTarget:self action:@selector(settingBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [settingButton setBackgroundColor:[UIColor clearColor]];
    settingBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 544, 48)];
    [settingBgImgView setBackgroundColor:[UIColor blackColor]];
    [settingBgImgView setAlpha:0.5];
    [settingButton addSubview:settingBgImgView];
    [self addSubview:settingButton];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,544, 48)];
    [titleLabel setFont:PMFont2];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [settingButton addSubview:titleLabel];
    
    modify = [[AFColorButton alloc] init];
    [modify.title setText:@"修改"];
    [modify setColorType:kColorButtonBlueColor];
    [modify setDirectionType:kColorButtonLeft];
    [modify resetColorButton];
    [self addSubview:modify];
    [modify addTarget:self action:@selector(modify:) forControlEvents:UIControlEventTouchUpInside];
    SetViewLeftUp(modify, 560, 4);
    
    conformBtn =[[UIButton alloc] initWithFrame:CGRectMake(0, 6, 36, 36)];
    [conformBtn setImage:[UIImage imageNamed:@"btn_finish1.png"] forState:UIControlStateNormal];
    [conformBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [conformBtn setAlpha:0];
    
    [numTextField setRightViewMode:UITextFieldViewModeAlways];
    [numTextField setRightView:conformBtn];
}

- (void)confirm
{
    switch (status) {
        case Status_NotAdded:
        case Status_Changing:
            
            [numTextField resignFirstResponder];
            if (buttontype == TypeOfEmail) {
                if (![UserNameCheck validateEmail:numTextField.text]) {
                    [CustomAlertViewController showAlertWithTitle:@"该邮箱不存在，请确认输入的邮箱是否正确" confirmRightHandler:^{
                        
                    }];
                    return;
                }else{
                   // PostNotification(Noti_ShowHud, );
                    [MainTabBarController showHud:@"向服务器提交中..."];
                    enum userActionResult result = [[UserInfo sharedUserInfo] changeMailTo:numTextField.text phoneTo:@""];
                  //  PostNotification(Noti_HideHud, nil);
                    [MainTabBarController hideHud];
                    switch (result) {
                        case succeeded:
                            [self setCheck:[[UserInfo sharedUserInfo] mailVerified] andType:buttontype withTheNum:numTextField.text];
                           
                            if (status == Status_Changing){
                                [CustomNotiViewController showNotiWithTitle:@"修改成功~" withTypeStyle:kNotiTypeStyleRight];
                            }else{
                                [CustomNotiViewController showNotiWithTitle:@"添加成功~" withTypeStyle:kNotiTypeStyleRight];
                            }
                           //PostNotification(Noti_SettingSafeViewReload, nil);
                            
                            break;
                        case timeOut:
                        {
                            [CustomAlertViewController showAlertWithTitle:@"您当前的网络链接存在问题，请检查后再试。" confirmRightHandler:^{
                                
                            }];
                        }
                            return;
                        case checkFailed:
                            
                            return;
                        case dumplicated:
                        {
                            [CustomAlertViewController showAlertWithTitle:[NSString stringWithFormat:@"邮箱%@已被关联过！", numTextField.text] confirmRightHandler:^{
                                
                            }];
                        }
                        
                            return;
                        default:
                            [CustomAlertViewController showAlertWithTitle:@"服务器异常，请稍后再试。服务器异常，请稍后再试。" confirmRightHandler:^{
                                
                            }];
                            return;
                    }
                }
            }else{
                
                if (![UserNameCheck validateMobile:numTextField.text]) {
                    [CustomAlertViewController showAlertWithTitle:@"该手机号码不存在，请确认输入的手机号码是否正确" confirmRightHandler:^{
                        
                    }];
                   
                    return;
                }else{
                  //  PostNotification(Noti_ShowHud, @"向服务器提交中...");
                    [MainTabBarController showHud:@"向服务器提交中..."];

                    enum userActionResult result = [[UserInfo sharedUserInfo] changeMailTo:@"" phoneTo:numTextField.text];
                  //  PostNotification(Noti_HideHud, nil);
                    [MainTabBarController hideHud];
                    switch (result) {
                        case succeeded:
                             [self setCheck:[[UserInfo sharedUserInfo] phoneVerified] andType:buttontype withTheNum:numTextField.text];
                            if (status == Status_Changing){
                                [CustomNotiViewController showNotiWithTitle:@"修改成功~" withTypeStyle:kNotiTypeStyleRight];
                            }else{
                                [CustomNotiViewController showNotiWithTitle:@"添加成功~" withTypeStyle:kNotiTypeStyleRight];
                            }
                           // PostNotification(Noti_SettingSafeViewReload, nil);
                            break;
                        case timeOut:
                        {
                            [CustomAlertViewController showAlertWithTitle:@"您当前的网络链接存在问题，请检查后再试。" confirmRightHandler:^{
                                
                            }];
                        }
                            return;
                        case checkFailed:
                            
                            
                            return;
                        case dumplicated:
                        {
                            [CustomAlertViewController showAlertWithTitle:[NSString stringWithFormat:@"手机号码%@已被关联过！", numTextField.text] confirmRightHandler:^{
                                
                            }];
                        }
                            return;
                        default:
                            [CustomAlertViewController showAlertWithTitle:@"服务器异常，请稍后再试。" confirmRightHandler:^{
                                
                            }];
                            return;
                    }
                }
            }
            
            break;
            
        default:
                    switch ([[UserInfo sharedUserInfo] verifyPhoneWithCode:numTextField.text]) {
                        case succeeded:
                           [codeLabel setAlpha:1];
                            [conformBtn setAlpha:0];
                            [numTextField setEnabled:NO];
                            break;
                        case otherError:
                            [numTextField setText:@""];
                            [conformBtn setAlpha:0];
                            [CustomAlertViewController showAlertWithTitle:@"出现位置问题。" confirmRightHandler:^{
                                
                            }];
                            break;
                        case timeOut:
                            [numTextField setText:@""];
                            [conformBtn setAlpha:0];
                            [CustomAlertViewController showAlertWithTitle:@"连接超时，请检查网络后重新发送。" confirmRightHandler:^{
                                
                            }];
                           
                            break;
                        case checkFailed:
                            [numTextField setText:@""];
                            [conformBtn setAlpha:0];
                            [CustomAlertViewController showAlertWithTitle:@"验证码错误，请检查后重新输入。" confirmRightHandler:^{
                                
                            }];
                           
                            break;
                        case noSuchUser:
                            [numTextField setText:@""];
                            [conformBtn setAlpha:0];
                            [CustomAlertViewController showAlertWithTitle:@"该用户不存在。" confirmRightHandler:^{
                                
                            }];
                            break;
            
                        default:
                            break;
                    }
            
            break;
    }
    [modify setAlpha:1];
}

- (void)settingBtnPressed:(UIButton *)sender
{
    switch (status) {
        case Status_NotAdded:
        case Status_Changing:
        {
            [numTextField setEnabled:YES];
            [numTextField becomeFirstResponder];
            [modify setAlpha:0];
            [settingButton setAlpha:0];
            
            
        }
            break;
        case Status_NotVerified:
            //发送验证
            if (buttontype == TypeOfEmail) {
              //  PostNotification(Noti_ShowHud, @"请求提交中...");
                [MainTabBarController showHud:@"请求提交中..."];

                enum userActionResult result = [[UserInfo sharedUserInfo] verifyUser:YES];
                [MainTabBarController hideHud];
               // PostNotification(Noti_HideHud, nil);
                switch (result) {
                    case succeeded:
                    {
                        [CustomAlertViewController showAlertWithTitle:@"验证邮件已发送~" confirmRightHandler:^{
                            
                        }];
                    }
                        
                        break;
                    case timeOut:
                    {
                        [CustomAlertViewController showAlertWithTitle:@"您当前的网络链接存在问题，请检查后再试。" confirmRightHandler:^{
                            
                        }];
                    }
                        return;
                    default:
                    {
                        [CustomAlertViewController showAlertWithTitle:@"服务器异常，请稍后再试。" confirmRightHandler:^{
                            
                        }];
                    }
                        return;
                }
            }else{
               // PostNotification(Noti_ShowHud, @"请求提交中...");
                [MainTabBarController showHud:@"请求提交中..."];

                enum userActionResult result = [[UserInfo sharedUserInfo] verifyUser:NO];
                [MainTabBarController hideHud];

               // PostNotification(Noti_HideHud, nil);
                switch (result) {
                    case succeeded:
                    {
                        
                        [CustomAlertViewController showAlertWithTitle:@"验证短信已发送~" confirmRightHandler:^{
                                
                        }];
                        [settingButton setAlpha:0];
                        [numTextField setEnabled:YES];
                        [numTextField setTextAlignment:NSTextAlignmentCenter];
                        [numTextField setText:@""];
                        [numTextField setPlaceholder:@"输入验证码"];
                        [_delegate sendTheInfo];
                        [modify setAlpha:0];
                        [numTextField becomeFirstResponder];
                    }
                        break;
                    case timeOut:
                    {
                        [CustomAlertViewController showAlertWithTitle:@"您当前的网络链接存在问题，请检查后再试。" confirmRightHandler:^{
                            
                        }];
                    }
                       return;
                    default:
                    {
                        [CustomAlertViewController showAlertWithTitle:@"服务器异常，请稍后再试。" confirmRightHandler:^{
                            
                        }];
                    }
                        return;
                }
            }
            
            break;
        case Status_Verified:
            
            break;
            
        default:
            break;
    }
}

- (void)modify:(UIButton *)sender
{
    oStatus = status;
    status = Status_Changing;
    [self settingBtnPressed:nil];
}

- (void)resend
{
    [self settingBtnPressed:nil];
}

- (void)setCheck:(BOOL)check andType:(ButtonType)btnType withTheNum:(NSString *)num;
{
    buttontype = btnType;
    if ([num isEqualToString:@""]) {
        status = Status_NotAdded;
        [modify setAlpha:0];
        [titleLabel setText:@"添加"];
        [settingButton setAlpha:1];
        [conformBtn setAlpha:0];
        [codeLabel setAlpha:0];
    }else{
        if (check) {
            status = Status_Verified;
            [modify setAlpha:1];
            [settingButton setAlpha:0];
            [codeLabel setAlpha:1];
            [conformBtn setAlpha:0];
        }
        else{
            status = Status_NotVerified;
            [modify setAlpha:1];
            [settingButton setAlpha:1];
            [codeLabel setAlpha:0];
            [conformBtn setAlpha:0];
            if (btnType == TypeOfEmail) {
                [titleLabel setText:@"获取验证邮件"];
            }else{
                [titleLabel setText:@"获取验证短信"];
            }
        }
    }
    
    if (btnType == TypeOfEmail) {
        numTextField.keyboardType = UIKeyboardTypeEmailAddress;
        numTextField.returnKeyType = UIReturnKeyDone;
    }else{
        numTextField.keyboardType = UIKeyboardTypeNumberPad;
        numTextField.returnKeyType = UIReturnKeyDone;
    }
    
    [numTextField setText:num];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.length == 1) {
        if ([textField.text length]==1) {
            [conformBtn setAlpha:0];
            
        }else{
            [conformBtn setAlpha:1];
            
        }
    }else{
        [conformBtn setAlpha:1];
    }
    
    return YES;
}
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    if (conformBtn.alpha == 0) {
//        [modify setAlpha:0];
//        [codeLabel setAlpha:0];
//        [settingButton setAlpha:1];
//        [numTextField setEnabled:NO];
//    }
//
//    return YES;
//}

- (void)textFieldresignFirstResponder
{
    [numTextField resignFirstResponder];
    status = oStatus;
}


@end
