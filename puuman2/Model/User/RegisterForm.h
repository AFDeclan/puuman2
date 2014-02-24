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
    NSMutableDictionary *_babyMeta;
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
//生日（预产期)
@property (retain, nonatomic) NSDate * birthDay;
//是否已出生
@property (assign, nonatomic) BOOL whetherBirth;
//昵称
@property (retain, nonatomic) NSString *nickName;
//性别
@property (assign, nonatomic) BOOL isBoy;

@end
