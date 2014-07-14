//
//  InviteView.m
//  puman
//
//  Created by 祁文龙 on 13-11-14.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "InviteView.h"
#import "ColorsAndFonts.h"
#import "CustomAlertViewController.h"
#import "CustomNotiViewController.h"
#import "UserInfo.h"
#import "BabyData.h"
#import "JoinView.h"

@implementation InviteView

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
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 208, 16)];
    [titleLabel setFont:PMFont2];
    [titleLabel setTextColor:PMColor6];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    NSString *nickName =  [[[UserInfo sharedUserInfo] babyInfo] Nickname];
    NSString *nameStr;
    if (nickName) {
        if ([[UserInfo sharedUserInfo] identity] == Mother) {
            nameStr = [NSString stringWithFormat:@"%@爸",nickName];
           
        }else
        {
                nameStr = [NSString stringWithFormat:@"%@妈",nickName];
            
           
        }
        
    }else{
        if ([[UserInfo sharedUserInfo] identity] == Mother) {
            
            nameStr = @"爸爸";
            
        }else
        {
            
            nameStr = @"妈妈";
            
        }
      
    }
     [titleLabel setText:[NSString stringWithFormat:@"您还没有邀请%@",nameStr]];
     [self addSubview:titleLabel];
     detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, 208, 40)];
     [detailLabel setNumberOfLines:2];
     [detailLabel setTextColor:PMColor3];
     [detailLabel setTextAlignment:NSTextAlignmentLeft];
     [detailLabel setText:[NSString stringWithFormat: @"邀请%@来共同编辑%@的成长日记吧！",nameStr,nickName]];
     [detailLabel setFont:PMFont3];
     [detailLabel setBackgroundColor:[UIColor clearColor]];
     [self addSubview:detailLabel];
     relateNum = [[CustomTextField alloc] initWithFrame:CGRectMake(0, 80, 240, 48)];
     [relateNum setText:@""];
    relateNum.keyboardType = UIKeyboardTypeDefault;
    relateNum.returnKeyType = UIReturnKeySend;
    [relateNum setDelegate:self];
     [relateNum setPlaceholder:@"输入对方的邮箱或电话号"];
     [self addSubview:relateNum];
     inviteBtn = [[AFColorButton alloc] init];
    [inviteBtn.title setText:@"邀请"];
    [inviteBtn setColorType:kColorButtonBlueColor];
    [inviteBtn setDirectionType:kColorButtonLeft];
    [inviteBtn resetColorButton];
     SetViewLeftUp(inviteBtn, 128, 144);
     [inviteBtn addTarget:self action:@selector(invite:) forControlEvents:UIControlEventTouchUpInside];
     [self addSubview:inviteBtn];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self invite:nil];
    return YES;
}

-(void)resign
{
    [relateNum resignFirstResponder];
}

- (void)invite:(UIButton *)sender
{
    if ([relateNum.text isEqualToString:@""]) {
        
    }else{
        [MobClick event:umeng_event_click label:@"Invite_InviteViewr"];
        [relateNum resignFirstResponder];
        if ([self usernameIsRight]) {
            
            NSString *mail = @"";
            NSString *phoneNum = @"";
            if ([self usernameIsPhoneNum])
            {
                phoneNum = relateNum.text;
            }
            else
            {
                mail = relateNum.text;
            }
            enum userActionResult res = [[UserInfo sharedUserInfo] sendInvitationToMail:mail phoneNum:phoneNum];
            switch (res) {
                case succeeded:
                    [CustomNotiViewController showNotiWithTitle:@"发送成功" withTypeStyle:kNotiTypeStyleRight];
                    [[JoinView sharedJoinView] refreshStaus];
                    break;
                case timeOut:
                {
                    [CustomAlertViewController showAlertWithTitle:@"操作失败！网络不给力哦~" confirmRightHandler:^{
                        
                    }];
                }
                    break;
                case dumplicated:
                {
                    [CustomAlertViewController showAlertWithTitle:@"操作失败！您邀请的账户已经注册~" confirmRightHandler:^{
                        
                    }];
                }
                    break;
                default:
                {
                    [CustomAlertViewController showAlertWithTitle:@"操作失败！服务器遇到未知错误" confirmRightHandler:^{
                        
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
}
- (BOOL)usernameIsRight
{
    return [self usernameIsMailAddr] || [self usernameIsPhoneNum];
}
- (BOOL)usernameIsMailAddr
{
    NSString *username = relateNum.text;
    NSRange range = [username rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"@"]];
    if (range.location != NSNotFound) return YES;
    else return NO;
}
- (BOOL)usernameIsPhoneNum
{
    return [self validateMobile:relateNum.text];
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
@end
