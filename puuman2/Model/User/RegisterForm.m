//
//  RegisterForm.m
//  PuumanForPhone
//
//  Created by Declan on 14-1-8.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "RegisterForm.h"
#import "PumanRequest.h"
#import "DateFormatter.h"

static RegisterForm *instance;

@implementation RegisterForm

@synthesize relationIdentity = _relationIdentity;
@synthesize birthDay = _birthDay;
@synthesize whetherBirth = _whetherBirth;
@synthesize nickName = _nickName;
@synthesize isBoy = _isBoy;

+ (RegisterForm *)sharedForm
{
    if (!instance)
    {
        instance = [[RegisterForm alloc] init];
    }
    return instance;
}

+ (void)releaseForm
{
    instance = nil;
}

- (id)init
{
    if (self = [super init])
    {
        _babyMeta = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (enum userActionResult)registerUserWithInvitationCode:(NSString *)token password:(NSString *)pwd
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_RegisterUserWithCode;
    [request setParam:token forKey:@"Token"];
    [request setParam:[MD5 md5: pwd] forKey:@"UPwd"];
    [request setTimeOutSeconds:5];
    [request postSynchronous];
    if (request.result == PumanRequest_Succeeded)
    {
        NSString *res = request.resObj;
        NSRange range = [res rangeOfString:@"|"];
        if (range.location == 0)
        {
            [UserInfo sharedUserInfo].mailAddr = @"";
            [UserInfo sharedUserInfo].phoneNum = [res substringFromIndex:1];
        }
        else
        {
            [UserInfo sharedUserInfo].mailAddr = [res substringToIndex:range.location];
            [UserInfo sharedUserInfo].phoneNum = @"";
        }
        [UserInfo sharedUserInfo].pwd = pwd;
    }
    return request.result;
}

- (enum userActionResult)registerUserWithMail:(NSString *)mail phoneNum:(NSString *)phone password:(NSString *)pwd
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_RegisterUser;
    [request setParam:phone forKey:@"UPhone"];
    [request setParam:mail forKey:@"UMail"];
    [request setParam:[MD5 md5: pwd] forKey:@"UPwd"];
    [self buildBabyMeta];
    for (NSString *key in _babyMeta.keyEnumerator)
    {
        [request setParam:[_babyMeta valueForKey:key] forKey:key];
    }
    switch (_relationIdentity) {
        case Father:
            [request setParam:kUserIdentity_Father forKey:@"Identity"];
            break;
        case Mother:
            [request setParam:kUserIdentity_Mother forKey:@"Identity"];
            break;
    }
    //设置请求方式
    [request setTimeOutSeconds:5];
    [request postSynchronous];
    return request.result;
}

#pragma mark - babyMeta 设置
- (void)buildBabyMeta
{
    [_babyMeta setValue:_nickName forKey:uMeta_nickName];
    if (_whetherBirth)
    {
        [_babyMeta setValue:@"生日" forKey:uMeta_whetherBirth];
    }
    else
    {
        [_babyMeta setValue:@"预产期" forKey:uMeta_whetherBirth];
    }
    if (_isBoy)
    {
        [_babyMeta setValue:@"男宝宝" forKey:uMeta_gender];
    }
    else
    {
        [_babyMeta setValue:@"女宝宝" forKey:uMeta_gender];
    }
    [_babyMeta setValue:[DateFormatter stringFromDate:_birthDay] forKey:uMeta_birthDate];
}

@end
