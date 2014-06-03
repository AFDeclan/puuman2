//
//  RegisterForm.h
//  PuumanForPhone
//
//  Created by Declan on 14-1-8.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface RegisterForm : NSObject
{
}

+ (RegisterForm *)sharedForm;
+ (void)releaseForm;

//注册
- (enum userActionResult)registerUserWithMail:(NSString *)mail phoneNum:(NSString *)phone password:(NSString *)pwd;
- (enum userActionResult)registerUserWithInvitationCode:(NSString *)token password:(NSString *)pwd;
/*
 succeeded: 注册成功
 dumplicated: 用户已存在
 timeOut: 网络连接超时
 otherError: 网络或服务器错误
 checkFailed: 邀请码无效
 */

//爸爸or妈妈
@property (assign, nonatomic) UserIdentity relationIdentity;
@property (retain, nonatomic) BabyInfo * babyInfo;

@end
