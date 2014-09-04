//
//  UserInfo.h
//  puuman model
//
//  Created by 陈晔 on 13-4-13.
//  Copyright (c) 2013年 ÂàõÂßã‰∫∫Âõ¢Èòü. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileUploader.h"
#import "JSONKit.h"
#import "MD5.h"
#import "MobClick.h"
#import "UniverseConstant.h"
#import "AFNetwork.h"
#import "BabyInfo.h"
#import "ShareVideo.h"


#define defaultUserID       -1

#define kUserIdentity_Father    @"father"
#define kUserIdentity_Mother    @"mother"

#define userInfoKey                 @"userInfo"
#define userInfo_uid                @"userID"
#define userInfo_bid                @"userBID"
#define userInfo_identity           @"userIdentity"
#define userInfo_mail               @"usermailAddr"
#define userInfo_phone              @"userPhoneNum"
#define userInfo_UCorns             @"userPuman"
#define userInfo_UCornsConnect      @"userPumanConnect"
#define userInfo_UCornsUsed         @"userUCornsUsed"
#define userInfo_pumanBound             @"userPumanBound"
#define userInfo_pumanLocalAdded        @"userPumanLocalAdded"
#define userInfo_pumanLocalAddedDaily   @"userPumanLocalAddedDaily"
#define userInfo_pumanLocalAddedTime    @"userPumanLocalTime"
#define userInfo_Baby               @"userBaby"
#define userInfo_pumanUsed          @"userPumanUsed"
#define userInfo_meta               @"userMeta"
#define userInfo_pwdMd5             @"userPwdMd5"
#define userInfo_createTime         @"userCreateTime"

#define uMetaKey                    @"_puman_UserMeta"
#define uMeta_alipayAccount         @"AliPayAccount"
#define uMeta_InviteStateKey        @"InviteState"
#define uMeta_InvitedKey            @"Invited"
#define uMeta_RewardList            @"RewardList"

typedef enum userActionResult{
    //both
    succeeded = -1,
    otherError = 0,
    timeOut = 1,
    //login
    checkFailed = 2,
    //register
    dumplicated = 3,
    //resetpwd
    noSuchUser = 4
} UserActionResult;

typedef enum userIdentity {
    Father = 0,
    Mother = 1
} UserIdentity;

typedef enum inviteState {
    noInvite = 0,
    waitForAccept = 1,
    done = 2,
}InviteState;


@interface UserInfo : NSObject <UploaderDelegate, ASIHTTPRequestDelegate, AFRequestDelegate>
{
    BOOL logined;
    double _UCornsLocalAdded, _UCornsLocalAdded_daily;
    NSDate * _addTime;
}

@property (assign, readonly) NSInteger        UID;
@property (assign, readonly) NSInteger        BID;
@property (retain, readonly) BabyInfo   *     babyInfo;
@property (retain, readonly) NSString*        identityStr;
@property (assign, readonly) enum userIdentity identity;
@property (assign, readonly) enum inviteState inviteState;
@property (retain, readonly) NSString*        pwd_md5;
@property (assign, readonly) NSInteger        status;
@property (retain, readonly) NSDate*          createTime;
@property (retain, readonly) NSMutableDictionary* meta;
@property (retain, readonly) NSString *       UMail;
@property (retain, readonly) NSString *       UPhone;

@property (assign, readonly) double           UCorns;
@property (assign, readonly) double           UCornsUsed;
@property (assign, readonly) double           UCornsBound;

@property (assign, readonly) double           UCorns_connect;

//登录时填充
@property (retain) NSString*        mailAddr;
@property (retain) NSString*        phoneNum;
@property (retain) NSString*        pwd;
//重发验证码倒计时
@property (assign, nonatomic, readonly) NSInteger timeToResendVerifyMsg;

@property (retain, nonatomic, readonly) ShareVideo * shareVideo;

+ (void)init;
+ (UserInfo *)sharedUserInfo;

//登录
- (BOOL)loginFromUserDefault;
- (enum userActionResult)login;
//登出
- (void)logout;

//新增扑满币，（单日超出上限后返回No）
- (BOOL)addCorns:(double)add;
- (void)outCorns:(double)num;

//提交用户信息。
- (BOOL)uploadUserMetaVal:(NSString *)val forKey:(NSString *)key;
- (NSString *)alipayAccount;
- (BOOL)setAlipayAccount:(NSString *)alipayAccount;
- (BOOL)mailVerified;
- (BOOL)phoneVerified;

- (BOOL)logined;
- (BOOL)checkPwd:(NSString *)pwd;

- (enum userActionResult)changePwdTo:(NSString *)newPwd;
- (enum userActionResult)changeMailTo:(NSString *)newMail phoneTo:(NSString *)newPhone;

//更新用户信息
- (void)updateUserInfo;

//关联账户
- (NSString *)invitedBy;
- (enum userActionResult)acceptInvite;
- (enum userActionResult)rejectInvite;

//打赏 新打赏的日记列表
- (NSArray *)rewardDiaryList;
- (void)resetRewardList;

//邀请
- (enum userActionResult)sendInvitationToMail:(NSString *)mail phoneNum:(NSString *)phone;
/*
 succeeded, timeOut, otherError,
 dumplicated: 被邀请用户已注册
 */
- (enum userActionResult)verifyUser:(BOOL)verifMail;
/*
 succeeded, timeOut, otherError
 */
- (enum userActionResult)verifyPhoneWithCode:verif;
/*
 succeeded, timeOut, checkFaild（验证码有误）, otherError
 */
+ (enum userActionResult)resetPwdForMail:(NSString *)mail phoneNum:(NSString *)phone;

@end
