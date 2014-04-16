//
//  codeView.m
//  puman
//
//  Created by 祁文龙 on 13-11-12.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "LoginCodeView.h"
#import "UniverseConstant.h"
#import "CustomAlertViewController.h"
#import "MainTabBarController.h"
#import <ASIFormDataRequest.h>
#import "ErrorLog.h"
#import "UserInfo.h"
#import "ColorButton.h"

@implementation LoginCodeView

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
    [title setText:@"将修改密码的链接网址发送给您"];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setTextColor:PMColor2];
    [title setBackgroundColor:[UIColor clearColor]];
    [self addSubview:title];
    UIImageView *icon=[[UIImageView alloc] initWithFrame:CGRectMake(280, 48, 144, 180) ];
    [icon setImage:[UIImage imageNamed:@"pic_puuman_login_diary.png"]];
    [icon setBackgroundColor:[UIColor clearColor]];
    [self addSubview:icon];
    UILabel *userLabel=[[UILabel alloc] initWithFrame:CGRectMake(136, 280, 96, 16)];
    [userLabel setFont:PMFont2];
    [userLabel setText:@"邮箱或手机号"];
    [userLabel setTextAlignment:NSTextAlignmentRight];
    [userLabel setBackgroundColor:[UIColor clearColor]];
    [userLabel setTextColor:PMColor2];
    [self addSubview:userLabel];
    ColorButton  *send = [[ColorButton alloc] init];
    [send initWithTitle:@"发送" andButtonType:kBlueLeft];
    [send addTarget:self action:@selector(sendNums:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:send];
    SetViewLeftUp(send,592 , 423);
    user_textfield = [[CustomTextField alloc] initWithFrame:CGRectMake(240, 264,256, 48)];
    user_textfield.keyboardType = UIKeyboardTypeDefault;
    user_textfield.returnKeyType = UIReturnKeyDone;
    [user_textfield setDelegate:self];
    [self addSubview:user_textfield];
}
- (void)sendNums:(UIButton *)sender
{
    
    [MobClick event:umeng_event_click label:@"SendNums_LoginCodeView"];
    [user_textfield resignFirstResponder];
    if ([self usernameIsRight]) {
        NSString *mail = @"";
        NSString *phone = @"";
        if ([self usernameIsPhoneNum])
            phone = user_textfield.text;
        else
            mail = user_textfield.text;
        [MainTabBarController showHud:@"向服务器提交申请中..."];
        enum userActionResult ret = [UserInfo resetPwdForMail:mail phoneNum:phone];
        [MainTabBarController hideHud];
        switch (ret) {
            case succeeded:
            {
                [CustomAlertViewController showAlertWithTitle:@"已向您的邮箱或手机发送重置密码链接，一天内使用有效。" confirmRightHandler:^{
                
                }];
            }
                break;
            case timeOut:
            {
                [CustomAlertViewController showAlertWithTitle:@"网络连接超时，请稍后再试" confirmRightHandler:^{
                    
                }];
            }
                break;
            case noSuchUser:
            {
                [CustomAlertViewController showAlertWithTitle:@"用户不存在！" confirmRightHandler:^{
                    
                }];
            }
                break;
            default:
            {
                [CustomAlertViewController showAlertWithTitle:@"连接服务器失败，请稍后再试" confirmRightHandler:^{
                    
                }];
            }

                break;
        }
    }else
    {
        [CustomAlertViewController showAlertWithTitle:@"请正确输入邮箱或手机号码" confirmRightHandler:^{
            
        }];
    }
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
    NSString *username = user_textfield.text;
    NSRange range = [username rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"@"]];
    if (range.location != NSNotFound) return YES;
    else return NO;
}
- (BOOL)usernameIsPhoneNum
{
    return [self validateMobile:user_textfield.text];
}
- (BOOL)usernameIsRight
{
    return [self usernameIsMailAddr] || [self usernameIsPhoneNum];
}
@end
